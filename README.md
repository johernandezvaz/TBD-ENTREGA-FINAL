# Accomodate

Bienvenido al repositorio de Accomodate, una aplicación web diseñada para facilitar la gestión de propiedades inmobiliarias. A continuación, encontrarás una descripción detallada del proyecto, sus componentes principales y las tecnologías utilizadas.

## Descripción del Proyecto

Accomodate es una plataforma que permite a los usuarios buscar propiedades disponibles para alquilar o comprar. Los usuarios pueden registrarse, iniciar sesión y gestionar su perfil, así como ver detalles de las propiedades y ponerse en contacto con los propietarios o agentes inmobiliarios.

## Componentes

### Backend

El backend de Accomodate está desarrollado en Python utilizando Flask. Se encarga de manejar la lógica del negocio, la autenticación de usuarios y la comunicación con la base de datos.

#### Llamadas a Flask

1. `/register`: Registra un nuevo usuario en la base de datos.
2. `/login`: Inicia sesión de un usuario existente.
3. `/logout`: Cierra sesión de un usuario autenticado.
4. `/user-info`: Obtiene la información del usuario autenticado y sus propiedades.

### Frontend

El frontend de Accomodate está desarrollado en React.js. Proporciona una interfaz de usuario interactiva y receptiva para que los usuarios puedan interactuar con la aplicación.

#### Componentes

1. `Homepage`: Página principal que muestra la información del usuario y sus propiedades.
2. `Login`: Formulario de inicio de sesión.
3. `Register`: Formulario de registro de nuevos usuarios.

## Tecnologías Utilizadas

- **Backend**: Python, Flask, Flask-Session, MySQL.
- **Frontend**: JavaScript, React.js, React Router.
- **Base de Datos**: MySQL.
