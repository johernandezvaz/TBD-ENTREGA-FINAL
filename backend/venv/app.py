import random
import MySQLdb
from flask import Flask, request, jsonify, session, redirect
from flask_mysqldb import MySQL
from flask_cors import CORS
import datetime
from datetime import date
from config import Config

from requests import Session

app = Flask(__name__)
CORS(app, supports_credentials=True, origins=["http://localhost:5173"])
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

        # Verificar si el correo electrónico ya está en uso
        cur.execute("SELECT * FROM usuario WHERE correo_electronico = %s", (email,))
        existing_user = cur.fetchone()

        if existing_user:
            # El correo electrónico ya está en uso, devolver un mensaje de error
            return jsonify({"error": "El correo electrónico ya está en uso"}), 400

        # Encriptar la contraseña (si es necesario)
        # Aquí puedes agregar la encriptación si lo deseas
        current_date = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        # Insertar el nuevo usuario en la base de datos
        cur.execute("INSERT INTO usuario (nombre, apellido, correo_electronico, direccion, tipo_usuario, contrasena, fecha_registro, id_ciudad, id_pais) VALUES (%s, %s, %s, %s, %s, %s, %s, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = %s), %s)", 
                    (first_name, last_name, email, address, role, password, current_date, city_name, country))
        
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
        cur.execute("SELECT id_usuario, nombre, apellido, correo_electronico, tipo_usuario FROM usuario WHERE correo_electronico = %s AND contrasena = %s", (email, password))
        user = cur.fetchone()
        cur.close()

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

    # Obtener los datos del formulario enviado por el cliente
    name = data.get('name')
    description = data.get('description')
    address = data.get('address')
    city_id = data.get('city_id')
    # Asegúrate de agregar más campos según la estructura de tu tabla alojamiento

    if not name or not address or not city_id:
        return jsonify({"error": "Por favor complete todos los campos requeridos"}), 400

    try:
        cur = mysql.connection.cursor()

        # Insertar el nuevo alojamiento en la base de datos
        cur.execute("INSERT INTO alojamiento (nombre_alojamiento, descripcion, direccion, id_ciudad, id_anfitrion, precio) VALUES (%s, %s, %s, %s, %s, %s)", 
                    (name, description, address, city_id, session['user_id'], 0.0))  # Precio inicialmente 0.0, puedes cambiarlo según tu lógica

        mysql.connection.commit()
        cur.close()
        return jsonify({"message": "Alojamiento agregado exitosamente"}), 200

    except Exception as e:
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

        # Obtener las propiedades por país
        cur.execute("""
            SELECT a.id_alojamiento, a.nombre_alojamiento, a.descripcion, c.nombre_ciudad, a.direccion
            FROM alojamiento a
            LEFT JOIN ciudad c ON a.id_ciudad = c.id_ciudad
            LEFT JOIN pais p ON c.id_pais = p.id_pais
            WHERE p.nombre_pais = %s
        """, (country,))
        properties = [
            {
                "id": row[0],
                "name": row[1],
                "description": row[2],
                "city": row[3],
                "address": row[4]
            } 
            for row in cur.fetchall()
        ]
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
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
    response.headers.add("Access-Control-Allow-Headers", "Content-Type")
    return response

def _corsify_actual_response(response, status_code=200):
    response.status_code = status_code
    response.headers.add("Access-Control-Allow-Origin", "*")
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
        return _build_cors_preflight_response()

    data = request.json
    fecha_inicio = data.get('fechaInicio')
    fecha_fin = data.get('fechaFin')
    id_huesped = session.get('user_id')
    id_alojamiento = session.get('id_alojamiento')

    if not id_huesped or not id_alojamiento:
        return _corsify_actual_response(jsonify({"error": "Sesión no válida o datos incompletos"}), 400)

    try:
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO reserva (fecha_inicio, fecha_fin, id_huesped, id_alojamiento) VALUES (%s, %s, %s, %s)",
                    (fecha_inicio, fecha_fin, id_huesped, id_alojamiento))
        mysql.connection.commit()
        cur.close()
        return _corsify_actual_response(jsonify({"message": "Reserva confirmada"}), 200)
    except Exception as e:
        return _corsify_actual_response(jsonify({"error": str(e)}), 500)
    
@app.route('/session', methods=['GET', 'OPTIONS'])
def get_session():
    if request.method == 'OPTIONS':
        return _build_cors_preflight_response()

    id_huesped = session.get('user_id')
    id_alojamiento = session.get('id_alojamiento')

    if not id_huesped or not id_alojamiento:
        return _corsify_actual_response(jsonify({"error": "Sesión no válida o datos incompletos"}), 400)

    return _corsify_actual_response(jsonify({"id_huesped": id_huesped, "id_alojamiento": id_alojamiento}), 200)

