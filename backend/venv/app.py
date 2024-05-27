import csv
from flask import Flask, Response, request, jsonify, session
from flask_mysqldb import MySQL
from flask_cors import CORS
import datetime

app = Flask(__name__)
CORS(app)
app.secret_key = 'supersecretkey'  # Necesario para usar sesiones

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

    if not request.is_json:
        return jsonify({"error": "La solicitud debe contener datos JSON"}), 400
    
    
    data = request.json

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"error": "Por favor, proporcione correo electrónico y contraseña"}), 400

    try:
        cur = mysql.connection.cursor()

        # Verificar las credenciales del usuario
        cur.execute("SELECT contrasena, tipo_usuario FROM usuario WHERE correo_electronico = %s", (email,))
        user = cur.fetchone()

        if user and password == user['contrasena']:
            # Credenciales válidas, establecer sesión
            session['email'] = email
            session['role'] = user['tipo_usuario']
            return jsonify({"message": "Inicio de sesión exitoso"}), 200
        else:
            # Credenciales inválidas
            return jsonify({"error": "Correo electrónico o contraseña incorrectos"}), 401

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/user-info', methods=['GET'])
def user_info():
    try:
        if 'email' in session and 'role' in session:
            email = session['email']
            role = session['role']
            return jsonify({"email": email, "role": role}), 200
        else:
            return jsonify({"error": "No hay sesión iniciada"}), 401
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)

@app.route('/logout', methods=['POST'])
def logout():
    session.pop('email', None)
    session.pop('role', None)
    return jsonify({"message": "Sesión cerrada exitosamente"}), 200
