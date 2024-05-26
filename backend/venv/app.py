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

    # Encriptar la contraseña
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    fecha_hoy = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    try:
        cur = mysql.connection.cursor()

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

if __name__ == '__main__':
    app.run(debug=True)
