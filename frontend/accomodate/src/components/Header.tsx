import React from 'react';
import { Link, useNavigate } from 'react-router-dom';

interface HeaderProps {
  loggedIn: boolean;
  onLogout: () => void;
}

const Header: React.FC<HeaderProps> = ({ loggedIn, onLogout }) => {
  const navigate = useNavigate();

  const handleLogout = async () => {
    try {
      const response = await fetch('http://localhost:5000/logout', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (response.status === 200) {
        onLogout();
        navigate('/');
      } else {
        console.error('Error al cerrar sesión');
      }
    } catch (error) {
      console.error('Error al cerrar sesión:', error);
    }
  };

  return (
    <header className="bg-secondary-200 p-4">
      <div className="container mx-auto flex justify-between items-center">
        <div className="text-white text-lg font-semibold">Accomodate</div>
        <nav>
          <ul className="flex space-x-4">
            {!loggedIn ? (
              <>
                <li><Link to="/" className="text-alternative-300 hover:text-gray-200">Inicio</Link></li>
                <li><Link to="/alojamientos" className="text-alternative-300 hover:text-gray-200">Alojamientos</Link></li>
                <li><Link to="/contacto" className="text-alternative-300 hover:text-gray-200">Contacto</Link></li>
                <li><Link to="/iniciar-sesion" className="text-alternative-300 hover:text-gray-200">Iniciar sesión</Link></li>
                <li><Link to="/registrarse" className="bg-alternative-300 text-alternative-200 hover:bg-gray-200 hover:text-alternative-200 px-4 py-2 rounded-md">Registrarse</Link></li>
              </>
            ) : (
              <li>
                <button 
                  onClick={handleLogout} 
                  className="bg-alternative-300 text-alternative-200 hover:bg-gray-200 hover:text-alternative-200 px-4 py-2 rounded-md"
                >
                  Cerrar sesión
                </button>
              </li>
            )}
          </ul>
        </nav>
      </div>
    </header>
  );
};

export default Header;
