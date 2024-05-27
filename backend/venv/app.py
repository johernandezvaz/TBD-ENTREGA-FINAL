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

@app.route('/reset_auto_increment', methods=['GET'])
def reset_auto_increment_route():
    reset_auto_increment('arrendatarios')
    reset_auto_increment('clientes')
    return jsonify({"message": "Auto increment reseteado"}), 200

@app.route('/register', methods=['POST'])
def register():
    data = request.json

    first_name = data.get('firstName')
    last_name = data.get('lastName')
    email = data.get('email')
    address = data.get('address')
    city = data.get('city')
    country = data.get('country')
    role = data.get('role')
    password = data.get('password')

    if not first_name or not last_name or not email or not address or not city or not country or not role or not password:
        return jsonify({"error": "Por favor complete todos los campos"}), 400

    try:
        cur = mysql.connection.cursor()

        # Verificar si el correo electrónico ya está en uso en ambas tablas
        cur.execute("SELECT * FROM clientes WHERE CorreoElectronico = %s UNION SELECT * FROM arrendatarios WHERE CorreoElectronico = %s", (email, email))
        existing_user = cur.fetchone()
        if existing_user:
            return jsonify({"error": "El correo electrónico ya está en uso"}), 400

        if role == 'Arrendatario':
            cur.execute("INSERT INTO arrendatarios (nombre, apellido, CorreoElectronico, Direccion, Ciudad, Pais, contrasena) VALUES (%s, %s, %s, %s, %s, %s, %s)", 
                        (first_name, last_name, email, address, city, country, password))
        elif role == 'Cliente':
            cur.execute("INSERT INTO clientes (nombre, apellido, CorreoElectronico, Direccion, Ciudad, Pais, contrasena) VALUES (%s, %s, %s, %s, %s, %s, %s)", 
                        (first_name, last_name, email, address, city, country, password))
        else:
            return jsonify({"error": "Rol no válido"}), 400

        mysql.connection.commit()
        cur.close()
        return jsonify({"message": "Registro exitoso"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/login', methods=['POST'])
def login():
    if request.method == 'OPTIONS':
        response = jsonify()
        response.headers.add('Access-Control-Allow-Origin', '*')
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
        response.headers.add('Access-Control-Allow-Methods', 'POST')
        return response

    data = request.json
    email = data.get('CorreoElectronico')
    password = data.get('contrasena')

    if not email or not password:
        return jsonify({"error": "Por favor, proporcione correo electrónico y contraseña"}), 400

    try:
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)  # Utilizar DictCursor para obtener resultados como diccionario

        # Verificar en la tabla de clientes
        cur.execute("SELECT contrasena FROM clientes WHERE CorreoElectronico = %s", (email,))
        usuario = cur.fetchone()
        if usuario and password == usuario['contrasena']:
            session['email'] = email
            session['role'] = 'Cliente'
            cur.close()
            return jsonify({"message": "Inicio de sesión exitoso"}), 200

        # Verificar en la tabla de arrendatarios
        cur.execute("SELECT contrasena FROM arrendatarios WHERE CorreoElectronico = %s", (email,))
        usuario = cur.fetchone()
        cur.close()

        if usuario and password == usuario['contrasena']:
            session['email'] = email
            session['role'] = 'Arrendatario'
            return jsonify({"message": "Inicio de sesión exitoso"}), 200

        return jsonify({"error": "Correo electrónico o contraseña incorrectos"}), 401

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/user-info', methods=['GET'])
def user_info():
    email = session.get('email')
    role = session.get('role')
    if not email or not role:
        return jsonify({"error": "Usuario no autenticado"}), 401

    try:
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        if role == 'Arrendatario':
            cur.execute("SELECT nombre FROM arrendatarios WHERE CorreoElectronico = %s", (email,))
        else:
            cur.execute("SELECT nombre FROM clientes WHERE CorreoElectronico = %s", (email,))
        user = cur.fetchone()
        if not user:
            return jsonify({"error": "Usuario no encontrado"}), 404

        user_name = user['nombre']
        properties = [
            {"id": 1, "name": "Propiedad 1", "description": "Descripción de la propiedad 1"},
            {"id": 2, "name": "Propiedad 2", "description": "Descripción de la propiedad 2"},
        ]
        cur.close()
        return jsonify({"name": user_name, "role": role, "properties": properties}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/logout', methods=['POST'])
def logout():
    session.pop('email', None)
    session.pop('role', None)
    return jsonify({"message": "Sesión cerrada exitosamente"}), 200
