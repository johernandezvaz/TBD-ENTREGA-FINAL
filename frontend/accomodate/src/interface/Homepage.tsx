import React, { useEffect, useState } from 'react';

interface Property {
  id: number;
  name: string;
  description: string;
}

const Homepage: React.FC = () => {
  const [properties, setProperties] = useState<Property[]>([]);
  const [userInfo, setUserInfo] = useState({ name: '', role: '' });

  useEffect(() => {
    const fetchUserInfo = async () => {
      try {
        const response = await fetch('http://localhost:5000/user-info', {
          method: 'GET',
          credentials: 'include', // Para enviar cookies con la solicitud
          headers: {
            'Content-Type': 'application/json',
          },
        });
        const data = await response.json();
        if (response.ok) {
          setUserInfo({ name: data.name, role: data.role });
          setProperties(data.properties);
        } else {
          console.error(data.error);
        }
      } catch (error) {
        console.error('Error al obtener la información del usuario:', error);
      }
    };

    fetchUserInfo();
  }, []);

  return (
    <div className="container mx-auto mt-8">
      <div className="max-w-md mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Bienvenido {userInfo.name}</h2>
        <p className="text-center text-sm mb-4">Rol: {userInfo.role}</p>
        <h3 className="text-center text-xl font-semibold mb-4">Propiedades</h3>
        <ul>
          {properties.map((property) => (
            <li key={property.id} className="mb-2">
              <h4 className="font-bold">{property.name}</h4>
              <p>{property.description}</p>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default Homepage;
