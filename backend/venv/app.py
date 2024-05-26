from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
from flask_cors import CORS
import bcrypt
import datetime

app = Flask(__name__)
CORS(app)

# Configuración de la base de datos
app.config.from_object('config.Config')

mysql = MySQL(app)


def reset_auto_increment(table_name):
    try:
        cur = mysql.connection.cursor()

        # Ejecutar el procedimiento almacenado de MySQL
        cur.callproc('reset_auto_increment', (table_name,))

        # Confirmar los cambios
        mysql.connection.commit()

        print(f"Auto increment reset for table {table_name} successful.")

        cur.close()
    except Exception as e:
        print("Error al llamar al procedimiento reset_auto_increment:", e)
    


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

        # Verificar si el correo electrónico ya está en uso
        cur.execute("SELECT * FROM clientes WHERE CorreoElectronico = %s", (email,))
        existing_user = cur.fetchone()

        print(existing_user)

        if existing_user:
            # El correo electrónico ya está en uso, devolver un mensaje de error
            return jsonify({"error": "El correo electrónico ya está en uso"}), 400

    
        # Encriptar la contraseña
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

        fecha_hoy = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        if role == 'Arrendatario':
            cur.execute("INSERT INTO arrendatarios (nombre, apellido, CorreoElectronico, Direccion, Ciudad, Pais, contrasena, FechaRegistro) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", 
                        (first_name, last_name, email, address, city, country, hashed_password, fecha_hoy))
        elif role == 'Cliente':
            cur.execute("INSERT INTO clientes (nombre, apellido, CorreoElectronico, Direccion, Ciudad, Pais, contrasena, FechaRegistro) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", 
                        (first_name, last_name, email, address, city, country, hashed_password, fecha_hoy))
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
        # Manejar solicitudes OPTIONS retornando una respuesta vacía con los headers CORS apropiados
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
        cur = mysql.connection.cursor()
        cur.execute("SELECT contrasena FROM usuarios WHERE CorreoElectronico = %s", (email,))
        usuario = cur.fetchone()
        cur.close()

        if usuario and bcrypt.checkpw(password.encode('utf-8'), usuario['contrasena'].encode('utf-8')):
            # Credenciales válidas, devolver éxito
            return jsonify({"message": "Inicio de sesión exitoso"}), 200
        else:
            # Credenciales inválidas, devolver error
            return jsonify({"error": "Correo electrónico o contraseña incorrectos"}), 401

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    reset_auto_increment('arrendatarios')
    reset_auto_increment('clientes')
    app.run(debug=True)