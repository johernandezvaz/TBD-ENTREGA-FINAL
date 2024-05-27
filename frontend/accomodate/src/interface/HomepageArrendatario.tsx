import React, { useEffect, useState } from 'react';

interface Property {
  id: number;
  name: string;
  description: string;
}

const HomepageArrendatario: React.FC = () => {
  const [properties, setProperties] = useState<Property[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProperties = async () => {
      try {
        const response = await fetch('http://localhost:5000/arrendatario-properties', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include', // Asegura que las cookies de sesión se envíen y reciban
        });

        if (!response.ok) {
          throw new Error('Error al obtener las propiedades del arrendatario');
        }

        const result = await response.json();
        setProperties(result.properties);
      } catch (error) {
        setError('Error al obtener las propiedades del arrendatario');
      }
    };

    fetchProperties();
  }, []);

  if (error) {
    return <div>{error}</div>;
  }

  return (
    <div className="container mx-auto mt-8">
      <div className="max-w-md mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Propiedades del arrendatario</h2>
        {properties.length === 0 ? (
          <p className="text-center">El arrendatario no tiene propiedades registradas.</p>
        ) : (
          <ul className="list-disc list-inside">
            {properties.map((property) => (
              <li key={property.id}>
                <h3 className="text-lg font-semibold">{property.name}</h3>
                <p>{property.description}</p>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
};

export default HomepageArrendatario;
