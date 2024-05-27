import React, { useEffect, useState } from 'react';

interface UserInfo {
  name: string;
  role: string;
  countries: string[];
}

const HomepageCliente: React.FC = () => {
  const [userInfo, setUserInfo] = useState<UserInfo | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchUserInfo = async () => {
      try {
        const response = await fetch('http://localhost:5000/cliente-info', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include', // Asegura que las cookies de sesión se envíen y reciban
        });

        if (!response.ok) {
          throw new Error('Error al obtener la información del usuario');
        }

        const result = await response.json();
        setUserInfo(result);
      } catch (error) {
        setError('Error al obtener la información del usuario');
      }
    };

    fetchUserInfo();
  }, []);

  if (error) {
    return <div>{error}</div>;
  }

  if (!userInfo) {
    return <div>Cargando...</div>;
  }

  return (
    <div className="container mx-auto mt-8">
      <div className="max-w-md mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Bienvenido, {userInfo.name}</h2>
        <p className="text-center mb-4">Rol: {userInfo.role}</p>
        <h3 className="text-xl font-semibold mb-2">Países recomendados para viajar:</h3>
        <ul className="list-disc list-inside">
          {userInfo.countries.map((country, index) => (
            <li key={index}>{country}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default HomepageCliente;
