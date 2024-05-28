import React from 'react';

interface HeaderProps {
  loggedIn: boolean;
  role?: string;
  onLogout: () => void;
}

const Header: React.FC<HeaderProps> = ({ loggedIn, onLogout }) => {
  return (
    <header className="bg-secondary-200 p-4">
      <div className="container mx-auto flex justify-between items-center">
        <div className="text-white text-lg font-semibold">Accomodate</div>
        <nav>
          <ul className="flex space-x-4">
            {loggedIn ? (
              <>
                <li><a href="/" className="text-alternative-300 hover:text-gray-200">Inicio</a></li>
                <li><a href="/alojamientos" className="text-alternative-300 hover:text-gray-200">Alojamientos</a></li>
                {/* Agrega más elementos según el rol si es necesario */}
                <li><button onClick={onLogout} className="text-alternative-300 hover:text-gray-200">Cerrar sesión</button></li>
              </>
            ) : (
              <>
                <li><a href="/" className="text-alternative-300 hover:text-gray-200">Inicio</a></li>
                <li><a href="/alojamientos" className="text-alternative-300 hover:text-gray-200">Alojamientos</a></li>
                <li><a href="/contacto" className="text-alternative-300 hover:text-gray-200">Contacto</a></li>
                <li><a href="/iniciar-sesion" className="text-alternative-300 hover:text-gray-200">Iniciar sesión</a></li>
                <li><a href="/registrarse" className="bg-alternative-300 text-alternative-200 hover:bg-gray-200 hover:text-alternative-200 px-4 py-2 rounded-md">Registrarse</a></li>
              </>
            )}
          </ul>
        </nav>
      </div>
    </header>
  );
}

export default Header;
