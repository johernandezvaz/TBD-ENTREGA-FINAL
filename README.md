# Proyecto XYZ

Este es el repositorio del proyecto XYZ, una aplicación web desarrollada para facilitar la gestión de propiedades inmobiliarias. La aplicación permite a los usuarios registrados buscar propiedades, ver detalles de las propiedades disponibles y administrar su perfil de usuario.

## Descripción del Proyecto

El objetivo principal de este proyecto es proporcionar una plataforma intuitiva para que los usuarios puedan buscar y gestionar propiedades inmobiliarias de manera eficiente. La aplicación está diseñada para ser fácil de usar y brindar una experiencia fluida al usuario.

## Componentes

### Backend

El backend de la aplicación está desarrollado en Python utilizando el framework Flask. Se encarga de manejar la lógica del negocio, la autenticación de usuarios, y la comunicación con la base de datos.

#### Llamadas a Flask

1. `/register`: Registra un nuevo usuario en la base de datos.
2. `/login`: Inicia sesión de un usuario existente.
3. `/logout`: Cierra sesión de un usuario autenticado.
4. `/user-info`: Obtiene la información del usuario autenticado y sus propiedades.

### Frontend

El frontend de la aplicación está desarrollado en React.js. Se encarga de proporcionar una interfaz de usuario interactiva y receptiva para que los usuarios puedan interactuar con la aplicación.

#### Componentes

1. `Homepage`: Página principal que muestra la información del usuario y sus propiedades.
2. `Login`: Formulario de inicio de sesión.
3. `Register`: Formulario de registro de nuevos usuarios.

## Tecnologías Utilizadas

- **Backend**: Python, Flask, Flask-Session, MySQL.
- **Frontend**: JavaScript, React.js, React Router.
- **Base de Datos**: MySQL.
