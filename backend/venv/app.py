import MySQLdb
from flask import Flask, request, jsonify, session
from flask_mysqldb import MySQL
from flask_cors import CORS
import datetime

app = Flask(__name__)
CORS(app)
app.secret_key = 'supersecretkey'  # Necesario para usar sesiones

# Configuración de la base de datos
app.config.from_object('config.Config')

mysql = MySQL(app)

def reset_auto_increment(table_name):
    try:
        cur = mysql.connection.cursor()
        cur.callproc('reset_auto_increment', (table_name,))
        mysql.connection.commit()
        cur.close()
    except Exception as e:
        print("Error al llamar al procedimiento reset_auto_increment:", e)

@app.route('/countries', methods=['GET'])
def get_countries():
    try:
        cur = mysql.connection.cursor()
        cur.execute("SELECT id_pais, nombre_pais FROM pais")
        countries = cur.fetchall()
        cur.close()
        return jsonify(countries)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Endpoint para insertar una ciudad en la tabla ciudad
@app.route('/insertar-ciudad', methods=['POST'])
def insertar_ciudad():
    data = request.get_json()
    nombre_ciudad = data.get('nombre_ciudad')
    id_pais = data.get('id_pais')

    try:
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES (%s, %s)", (nombre_ciudad, id_pais))
        mysql.connection.commit()
        cur.close()
        return jsonify({"message": "Ciudad insertada correctamente"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)


@app.route('/reset_auto_increment', methods=['GET'])
def reset_auto_increment_route():
    reset_auto_increment('arrendatarios')
    reset_auto_increment('clientes')
    return jsonify({"message": "Auto increment reseteado"}), 200

@app.route('/register', methods=['POST'])
def register():
    data = request.json

    first_name = data.get('nombre')
    last_name = data.get('apellido')
    email = data.get('correo_electronico')
    address = data.get('direccion')
    role = data.get('tipo_usuario')
    password = data.get('contrasena')

    if not first_name or not last_name or not email or not address or not role or not password:
        return jsonify({"error": "Por favor complete todos los campos"}), 400

    try:
        cur = mysql.connection.cursor()

        # Verificar si el correo electrónico ya está en uso
        cur.execute("SELECT * FROM usuario WHERE correo_electronico = %s", (email,))
        existing_user = cur.fetchone()

        if existing_user:
            # El correo electrónico ya está en uso, devolver un mensaje de error
            return jsonify({"error": "El correo electrónico ya está en uso"}), 400

        # Encriptar la contraseña (si es necesario)
        # Aquí puedes agregar la encriptación si lo deseas

        # Insertar el nuevo usuario en la base de datos
        cur.execute("INSERT INTO usuario (nombre, apellido, correo_electronico, direccion, tipo_usuario, contrasena) VALUES (%s, %s, %s, %s, %s, %s)", 
                    (first_name, last_name, email, address, role, password))
        
        mysql.connection.commit()
        cur.close()
        return jsonify({"message": "Registro exitoso"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('correo_electronico')
    password = data.get('contrasena')

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
