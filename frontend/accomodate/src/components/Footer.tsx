import React from "react";

const Footer: React.FC = () => {
  return (
    <footer className="bg-secondary-400 text-white py-8">
      <div className="container mx-auto flex flex-col justify-center items-center">
        <div className="mb-4">
          <h2 className="text-lg font-semibold text-center">Accomodate</h2>
          <p className="text-sm">Tu plataforma de reservas de alojamiento</p>
        </div>
        <div className="mb-4">
          <h3 className="text-sm font-semibold">Síguenos en redes sociales:</h3>
          <div className="flex space-x-4">
            <a href="#" className="text-white hover:text-gray-300">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                {/* Icono de Facebook */}
              </svg>
            </a>
            <a href="#" className="text-white hover:text-gray-300">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                {/* Icono de Twitter */}
              </svg>
            </a>
            {/* Agrega más enlaces a redes sociales aquí si lo deseas */}
          </div>
        </div>
        <div className="text-sm">
          <p>&copy; 2024 Accomodate. Todos los derechos reservados.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
