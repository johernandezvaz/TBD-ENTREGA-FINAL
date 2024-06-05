import MySQLdb
from flask import Flask, request, jsonify, session, redirect
import json
from flask_mysqldb import MySQL
from flask_cors import CORS
import datetime
from datetime import date
from datetime import datetime
from config import Config

from requests import Session

app = Flask(__name__)
CORS(app, supports_credentials=True, origins="http://localhost:5173")
app.config.from_object(Config)
app.secret_key = 'supersecretkey'  # Necesario para usar sesiones
app.config['SESSION_TYPE'] = 'filesystem'
Session()

# Configuración de la base de datos
app.config.from_object('config.Config')

mysql = MySQL(app)

@app.route('/countries', methods=['GET'])
def get_countries():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM pais")
    columns = [column[0] for column in cur.description]  # Obtener los nombres de las columnas
    countries = [dict(zip(columns, row)) for row in cur.fetchall()]  # Convertir cada fila en un diccionario
    cur.close()

    countries_text = '\n'.join([f"{country['id_pais']}, {country['nombre_pais']}" for country in countries])

    return countries_text


@app.route('/register', methods=['POST'])
def register():
    data = request.json

    first_name = data.get('firstName')
    last_name = data.get('lastName')
    email = data.get('email')
    address = data.get('address')
    role = data.get('role')
    city_name = data.get('city')  # Obtener el nombre de la ciudad
    country = data.get('country')
    password = data.get('password')

    if not first_name or not last_name or not email or not address or not country or not role or not password or not city_name:
        return jsonify({"error": "Por favor complete todos los campos"}), 400

    try:
        cur = mysql.connection.cursor()

        # Verificar si la ciudad ya existe en la base de datos
        cur.execute("SELECT * FROM ciudad WHERE nombre_ciudad = %s", (city_name,))
        existing_city = cur.fetchone()

        # Si la ciudad no existe, agregarla a la tabla ciudad
        if not existing_city:
            cur.execute("INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES (%s, %s)", (city_name, country))
            mysql.connection.commit()
            cur.execute("SELECT * FROM ciudad WHERE nombre_ciudad = %s", (city_name,))
            existing_city = cur.fetchone()

        # Asegurarse de que 'existing_city' no sea None
        if not existing_city:
            return jsonify({"error": "Error al crear o recuperar la ciudad"}), 500

        city_id = existing_city[0]  # Acceder al primer elemento de la tupla

        # Verificar si el correo electrónico ya está en uso
        cur.execute("SELECT * FROM usuario WHERE correo_electronico = %s", (email,))
        existing_user = cur.fetchone()

        if existing_user:
            # El correo electrónico ya está en uso, devolver un mensaje de error
            return jsonify({"error": "El correo electrónico ya está en uso"}), 400

        # Llamar al procedimiento almacenado para crear el nuevo usuario
        cur.callproc('GestionarUsuario', (
            'crear', 0, first_name, last_name, email, address, country, city_id, password, role
        ))
        
        mysql.connection.commit()
        cur.close()
        return jsonify({"message": "Registro exitoso"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500




@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    print(f"Datos recibidos: {data}")

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"error": "Por favor, proporcione correo electrónico y contraseña"}), 400

    try:
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute("SELECT id_usuario, nombre, apellido, correo_electronico, tipo_usuario FROM usuario WHERE correo_electronico = %s AND ValidarContrasena(correo_electronico, %s)", (email, password))
        user = cur.fetchone()

        if user:
            # Guardar la información del usuario en la sesión
            session['user_id'] = user['id_usuario']
            session['user_name'] = user['nombre']
            session['user_role'] = user['tipo_usuario']
            return jsonify({
                "message": "Inicio de sesión exitoso",
                "user": {
                    "id": user['id_usuario'],
                    "name": user['nombre'],
                    "role": user['tipo_usuario']
                }
            }), 200
        else:
            return jsonify({"error": "Correo electrónico o contraseña incorrectos"}), 401

    except Exception as e:
        print(f"Error en el servidor: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)



@app.route('/user-info', methods=['GET'])
def user_info():
    if 'user_id' not in session:
        return jsonify({"error": "No hay sesión iniciada"}), 401
    
    user_id = session['user_id']
    cur = mysql.connection.cursor()
    
    cur.execute("SELECT nombre, tipo_usuario FROM usuario WHERE id = %s", (user_id,))
    user = cur.fetchone()
    
    if not user:
        return jsonify({"error": "Usuario no encontrado"}), 404
    
    # Asumiendo que las propiedades están relacionadas con el usuario
    cur.execute("SELECT id, name, description FROM properties WHERE user_id = %s", (user_id,))
    properties = cur.fetchall()
    
    cur.close()
    
    user_info = {
        "name": user['nombre'],
        "role": user['tipo_usuario'],
        "properties": properties
    }
    
    return jsonify(user_info), 200


@app.route('/logout', methods=['POST'])
def logout():
    session.pop('email', None)
    session.pop('role', None)
    return jsonify({"message": "Sesión cerrada exitosamente"}), 200

@app.route('/cliente-info', methods=['GET'])
def cliente_info():
    if 'user_id' not in session:
        return jsonify({"error": "No hay sesión iniciada"}), 401
    
    user_id = session['user_id']
    cur = mysql.connection.cursor()

    # Obtener la información del usuario
    cur.execute("SELECT nombre, tipo_usuario FROM usuario WHERE id_usuario = %s", (user_id,))
    user = cur.fetchone()
    
    if not user:
        return jsonify({"error": "Usuario no encontrado"}), 404

    # Obtener una lista aleatoria de 6 países
    cur.execute("SELECT nombre_pais FROM pais ORDER BY RAND() LIMIT 6")
    countries = [row[0] for row in cur.fetchall()]
    
    cur.close()
    
    user_info = {
        "name": user[0],
        "role": user[1],
        "countries": countries
    }
    
    return jsonify(user_info), 200

@app.route('/arrendatario-properties', methods=['GET'])
def arrendatario_properties():
    if 'user_id' not in session:
        return jsonify({"error": "No hay sesión iniciada"}), 401
    
    user_id = session['user_id']
    cur = mysql.connection.cursor()

    # Obtener las propiedades del arrendatario junto con el nombre de la ciudad
    query = """
        SELECT a.id_alojamiento, a.nombre_alojamiento, a.descripcion, c.nombre_ciudad, a.direccion
        FROM alojamiento a
        LEFT JOIN ciudad c ON a.id_ciudad = c.id_ciudad
        WHERE a.id_anfitrion = %s
    """
    cur.execute(query, (user_id,))
    properties = [
        {
            "id": row[0],
            "name": row[1],
            "description": row[2],
            "city": row[3],  # Agregamos el nombre de la ciudad
            "address": row[4]
        } 
        for row in cur.fetchall()
    ]
    
    cur.close()

    print(properties)
    
    return jsonify({"properties": properties}), 200




@app.route('/add-property', methods=['POST'])
def add_property():
    if 'user_id' not in session:
        return jsonify({"error": "No hay sesión iniciada"}), 401

    data = request.json
    print(data)
    user_id = session['user_id']
    print(user_id)
    # Obtener los datos del formulario enviado por el cliente
    name = data.get('name')
    description = data.get('description')
    address = data.get('address')
   

    try:
        city_name = data.get('city')
        cur = mysql.connection.cursor()
        cur.execute("SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = %s", (city_name,))
        result = cur.fetchone()
        if result:
            city_id = result[0]
        else:
            return jsonify({"error": "La ciudad proporcionada no existe"}), 400
        
        if not name or not address or not city_id:
            return jsonify({"error": "Por favor complete todos los campos requeridos"}), 400

        cur = mysql.connection.cursor()
        print(city_id)
        # Insertar el nuevo alojamiento en la base de datos
        cur.execute("INSERT INTO alojamiento (nombre_alojamiento, descripcion, direccion, id_ciudad, id_anfitrion, precio) VALUES (%s, %s, %s, %s, %s, %s)", 
                    (name, description, address, city_id, user_id, 0.0))  # Precio inicialmente 0.0, puedes cambiarlo según tu lógica

        mysql.connection.commit()
        cur.close()
        return jsonify({"message": "Alojamiento agregado exitosamente"}), 200

    except Exception as e:
        print(e)
        return jsonify({"error": str(e)}), 500

# Otras rutas y funciones aquí...

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/user-cities', methods=['GET'])
def user_cities():
    if 'user_id' not in session:
        return jsonify({"error": "No hay sesión iniciada"}), 401
    
    user_id = session['user_id']
    cur = mysql.connection.cursor()

    # Obtener el id del país del usuario
    cur.execute("SELECT id_pais FROM usuario WHERE id_usuario = %s", (user_id,))
    country_id = cur.fetchone()[0]

    # Obtener las ciudades del país del usuario
    cur.execute("SELECT id_ciudad, nombre_ciudad FROM ciudad WHERE id_pais = %s", (country_id,))
    cities = [{"id": row[0], "name": row[1]} for row in cur.fetchall()]
    
    cur.close()
    
    return jsonify({"cities": cities}), 200

@app.route('/properties', methods=['GET'])
def get_properties_by_country():
    country = request.args.get('country')
    if not country:
        return jsonify({"error": "Se requiere el parámetro 'country'"}), 400

    try:
        cur = mysql.connection.cursor()

        cur.execute("SELECT BuscarAlojamientos(%s)", (country,))
        result = cur.fetchone()
        properties = json.loads(result[0])

        cur.close()

        return jsonify({"properties": properties}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500




@app.route('/all-countries', methods=['GET'])
def get_all_countries():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM pais")
    columns = [column[0] for column in cur.description]  # Obtener los nombres de las columnas
    countries = [dict(zip(columns, row)) for row in cur.fetchall()]  # Convertir cada fila en un diccionario
    cur.close()

    countries_text = '\n'.join([f"{country['id_pais']}, {country['nombre_pais']}" for country in countries])

    return countries_text


@app.route('/reserva', methods=['POST', 'OPTIONS'])
def reserva():
    if request.method == 'OPTIONS':
        return _build_cors_preflight_response()

    if request.method == 'POST':
        data = request.json
        if 'idAlojamiento' not in data:
            return _corsify_actual_response(jsonify({'error': 'Falta idAlojamiento en los datos de la solicitud'}), 400)


    
    id_alojamiento = data['idAlojamiento']
    session['id_alojamiento'] = id_alojamiento

    return _corsify_actual_response(jsonify({'message': 'Reserva temporalmente guardada en sesión'}))

def _build_cors_preflight_response():
    response = jsonify({'message': 'Preflight request received'})
    response.headers.add("Access-Control-Allow-Origin", "http://localhost:5173")
    response.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
    response.headers.add("Access-Control-Allow-Headers", "Content-Type")
    return response

def _corsify_actual_response(response, status_code=200):
    response.status_code = status_code
    response.headers.add("Access-Control-Allow-Origin", "http://localhost:5173")
    response.headers.add("Access-Control-Allow-Credentials", "true")
    return response

if __name__ == '__main__':
    app.run(debug=True)




@app.route('/property/<int:id>', methods=['GET'])
def get_property(id):
    try:
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        query = """
            SELECT a.id_alojamiento, a.nombre_alojamiento, a.descripcion, a.direccion, a.precio, c.nombre_ciudad, u.nombre AS anfitrion
            FROM alojamiento a
            LEFT JOIN ciudad c ON a.id_ciudad = c.id_ciudad
            LEFT JOIN usuario u ON a.id_anfitrion = u.id_usuario
            WHERE a.id_alojamiento = %s
        """
        cur.execute(query, (id,))
        property = cur.fetchone()
        cur.close()
        
        if property:
            return jsonify(property), 200
        else:
            return jsonify({"error": "Property not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/property/<int:id>/availability', methods=['GET'])
def get_availability(id):
    cur = mysql.connection.cursor()

    query = """
    SELECT fecha 
    FROM calendario_disponibilidad_propiedad 
    WHERE id_alojamiento = %s AND disponible = 1 AND fecha >= %s
    """
    today = date.today()
    cur.execute(query, (id, today))
    
    result = cur.fetchall()
    dates = [row[0].isoformat() for row in result]

    cur.close()
    
    return jsonify({'availability': dates})

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/confirmar-reserva', methods=['POST', 'OPTIONS'])
def confirmar_reserva():
    if request.method == 'OPTIONS':
        response = jsonify({'message': 'Preflight Request successful'})
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
        response.headers.add('Access-Control-Allow-Methods', 'POST')
        return response
    elif request.method == 'POST':
        if 'user_id' not in session:
            return jsonify({"error": "No hay sesión iniciada"}), 401

        user_id = session['user_id']
        data = request.json

        # Depurar datos recibidos
        print("Datos recibidos:", data)

        fecha_inicio_str = data.get('fechaInicio')
        fecha_fin_str = data.get('fechaFin')
        id_alojamiento = data.get('idAlojamiento')
        metodo_pago = data.get('metodoPago')  # Obtener el método de pago
        monto = data.get('monto')  # Obtener el monto de la reserva

        # Validar que todos los campos necesarios están presentes
        if not id_alojamiento or not fecha_inicio_str or not fecha_fin_str or not metodo_pago or not monto:
            return jsonify({"error": "Datos incompletos"}), 400

        try:
            id_alojamiento = int(id_alojamiento)  # Convertir a entero después de la validación
            fecha_inicio = datetime.strptime(fecha_inicio_str, '%Y-%m-%d').date()
            fecha_fin = datetime.strptime(fecha_fin_str, '%Y-%m-%d').date()
        except ValueError as e:
            return jsonify({"error": "Formato de fecha o ID inválido"}), 400

        try:
            cur = mysql.connection.cursor()

            # Generar código de confirmación
            cur.execute("SELECT GenerarCodigoConfirmacion()")
            codigo_confirmacion = cur.fetchone()[0]

            # Realizar reserva con código de confirmación
            cur.callproc('RealizarReserva', (fecha_inicio, fecha_fin, user_id, id_alojamiento, metodo_pago, monto, codigo_confirmacion))
            mysql.connection.commit()
            cur.close()
            return jsonify({"message": "Reserva confirmada", "codigo_confirmacion": codigo_confirmacion}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500

    
@app.route('/session', methods=['GET', 'OPTIONS'])
def get_session():
    if request.method == 'OPTIONS':
        return _build_cors_preflight_response()

    id_huesped = session.get('user_id')
    id_alojamiento = session.get('id_alojamiento')

    if not id_huesped or not id_alojamiento:
        return _corsify_actual_response(jsonify({"error": "Sesión no válida o datos incompletos"}), 400)

    return _corsify_actual_response(jsonify({"id_huesped": id_huesped, "id_alojamiento": id_alojamiento}), 200)

@app.route('/mis-reservas', methods=['GET'])
def mis_reservas():
    if 'user_id' not in session:
        return jsonify({'error': 'Usuario no autenticado'}), 401

    user_id = session['user_id']

    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    try:
        cur.execute("""
            SELECT r.id_reserva, r.fecha_inicio, r.fecha_fin, r.codigo_confirmacion, a.nombre_alojamiento AS alojamiento
            FROM reserva r
            JOIN alojamiento a ON r.id_alojamiento = a.id_alojamiento
            WHERE r.id_huesped = %s
        """, (user_id,))
        
        reservas = cur.fetchall()
        return jsonify({'reservas': reservas}), 200
    except Exception as e:
        print(f"Error: {e}")  # Agregar logging para errores
        return jsonify({'error': 'Error interno del servidor: ' + str(e)}), 500
    finally:
        cur.close()



#### LLamada a los procedimientos almacenados
@app.route('/calculate-reservation-price', methods=['POST'])
def calculate_reservation_price():
    data = request.json
    print(data)
    id_alojamiento = data['id_alojamiento']
    fecha_inicio = data['fecha_inicio']
    fecha_fin = data['fecha_fin']

    cur = mysql.connection.cursor()
    try:
        cur.execute("CALL CalcularPrecioReserva(%s, %s, %s, @p_precio_total)", (id_alojamiento, fecha_inicio, fecha_fin))
        cur.execute("SELECT @p_precio_total")
        result = cur.fetchone() 

        cur.execute("SELECT CalcularDiasEstancia(%s, %s)", (fecha_inicio, fecha_fin))
        result2 = cur.fetchone()
        print(result2)
        if result:
            price = result[0]
            return jsonify({'price': price, 'days': result2}), 200
        else:
            return jsonify({'error': 'No se pudo calcular el precio'}), 400
    except Exception as e:
        return jsonify({'error': 'Error interno del servidor: ' + str(e)}), 500
    finally:
        cur.close()

if __name__ == '__main__':
    app.run(debug=True)




@app.route('/cancelar-reserva', methods=['POST'])
def cancelar_reserva():
    data = request.json
    id_reserva = data.get('id_reserva')

    if 'user_id' not in session:
        return jsonify({'error': 'Usuario no autenticado'}), 401

    cur = mysql.connection.cursor()
    try:
        cur.callproc('CancelarReserva', [id_reserva])
        mysql.connection.commit()
        return jsonify({'message': 'Reserva cancelada exitosamente'}), 200
    except Exception as e:
        print(f"Error: {e}")  # Agregar logging para errores
        return jsonify({'error': 'Error interno del servidor: ' + str(e)}), 500
    finally:
        cur.close()

@app.route('/estadisticas-reservas', methods=['GET'])
def estadisticas_reservas():
    if 'user_id' not in session:
        return jsonify({"error": "No autorizado"}), 401

    user_id = session['user_id']
    fecha_inicio_str = request.args.get('fecha_inicio')
    fecha_fin_str = request.args.get('fecha_fin')

    fecha_inicio = datetime.strptime(fecha_inicio_str, '%Y-%m-%d').date()
    fecha_fin = datetime.strptime(fecha_fin_str, '%Y-%m-%d').date()



    if not fecha_inicio or not fecha_fin:
        return jsonify({"error": "Por favor, proporcione fecha de inicio y fecha de fin"}), 400

    try:
        cur = mysql.connection.cursor()
        
        
        # Llamar al procedimiento almacenado
        cur.execute("CALL GenerarEstadisticasReservas(%s, %s, @p_numero_total_reservas, @p_ingresos_generados, @p_promedio_duracion_estancia)", (fecha_inicio, fecha_fin))

        # Obtener los valores de los parámetros OUT
        cur.execute("SELECT @p_numero_total_reservas, @p_ingresos_generados, @p_promedio_duracion_estancia;")
        result = cur.fetchone()
        numero_total_reservas = int(result[0])
        ingresos_generados = float(result[1])
        promedio_duracion_estancia = float(result[2])

        print(numero_total_reservas)
        print(ingresos_generados)
        print(promedio_duracion_estancia)
        cur.close()

        return jsonify({
            "numero_total_reservas": numero_total_reservas,
            "ingresos_generados": ingresos_generados,
            "promedio_duracion_estancia": promedio_duracion_estancia
        }), 200

    except Exception as e:
        print(f"Error en el servidor: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/update-user', methods=['POST'])
def update():
    if 'user_id' in session:
        user_id = session['user_id']
        data = request.json
        new_password = data.get('password')
        new_email = data.get('email')

        if new_password and new_email:
            try:
                cur = mysql.connection.cursor()

                # Llamar al procedimiento almacenado
                cur.callproc('GestionarUsuario', ['actualizar', user_id, None, None, new_email, None, None, None, new_password, None])
                mysql.connection.commit()

                return jsonify({'message': 'User updated successfully'}), 200
            except Exception as e:
                return jsonify({'message': 'An error occurred', 'error': str(e)}), 500
            finally:
                cur.close()
        else:
            return jsonify({'message': 'Password and email are required'}), 400
    else:
        return jsonify({'message': 'User not logged in'}), 401

@app.route('/delete-user', methods=['DELETE'])
def delete_user():
    if 'user_id' in session:
        user_id = session['user_id']
        print(user_id)

        try:
            cur = mysql.connection.cursor()

            cur.callproc('GestionarUsuario', ['eliminar', user_id, None, None, None, None, None, None, None, None])
            mysql.connection.commit()
            return jsonify({'message': 'Usuario eliminado exitosamente'})
        except Exception as e:
            print(e)
            return jsonify({'error': str(e)}), 500
        finally:
            cur.close()
    else:
        return jsonify({'message': 'User not logged in'}), 401

if __name__ == '__main__':
    app.run(debug=True)