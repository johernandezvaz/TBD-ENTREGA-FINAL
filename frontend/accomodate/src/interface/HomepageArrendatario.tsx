import React, { useEffect, useState } from 'react';
import Modal from 'react-modal';
import { Link } from 'react-router-dom';

interface Property {
  id: number;
  name: string;
  description: string;
  city: string;
  address: string;
}

const HomepageArrendatario: React.FC = () => {
  const [properties, setProperties] = useState<Property[]>([]);
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProperties = async () => {
      try {
        const response = await fetch('http://localhost:5000/arrendatario-properties', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
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

  const handlePropertyClick = (property: Property) => {
    setSelectedProperty(property);
  };

  const closeModal = () => {
    setSelectedProperty(null);
  };

  return (
    <div className="container mr-2 ml-2 mt-8">
      <div className="max-w-screen-xl mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Propiedades del arrendatario</h2>
        <Link to="/add-property">
          <button className="block mx-auto bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mt-4 mb-4">
            Agregar Propiedad
          </button>
        </Link>
        {properties.length === 0 ? (
          <p className="text-center">El arrendatario no tiene propiedades registradas.</p>
        ) : (
          <div className="flex flex-wrap -mx-2">
            {properties.map((property) => (
              <div key={property.id} className="w-full sm:w-1/2 md:w-1/3 px-2 mb-4">
                <button 
                  onClick={() => handlePropertyClick(property)} 
                  className="bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-2 px-4 rounded w-full"
                >
                  {property.name}
                </button>
              </div>
            ))}
          </div>
        )}

        {selectedProperty && (
          <Modal
            isOpen={!!selectedProperty}
            onRequestClose={closeModal}
            contentLabel="Información de la Propiedad"
            className="modal bg-white rounded-lg p-6 max-w-md mx-auto mt-10"
            overlayClassName="overlay fixed inset-0 bg-gray-900 bg-opacity-75 flex items-center justify-center"
          >
            <div>
              <h3 className="text-lg font-semibold">{selectedProperty.name}</h3>
              <p>{selectedProperty.description}</p>
              <p>Ciudad: {selectedProperty.city}</p>
              <p>Dirección: {selectedProperty.address}</p>
              <button 
                onClick={closeModal} 
                className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mt-4"
              >
                Cerrar
              </button>
            </div>
          </Modal>
        )}
      </div>
    </div>
  );
};

export default HomepageArrendatario;
