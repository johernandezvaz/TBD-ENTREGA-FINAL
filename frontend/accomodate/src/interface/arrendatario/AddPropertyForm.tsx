import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const AddPropertyForm: React.FC = () => {
  const [newPropertyName, setNewPropertyName] = useState<string>('');
  const [newPropertyDescription, setNewPropertyDescription] = useState<string>('');
  const [cities, setCities] = useState<string[]>([]);
  const [newPropertyCity, setNewPropertyCity] = useState<string>('');
  const [newPropertyAddress, setNewPropertyAddress] = useState<string>('');
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchCities = async () => {
      try {
        const response = await fetch('http://localhost:5000/user-cities', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
        });

        if (!response.ok) {
          throw new Error('Error al obtener las ciudades');
        }

        const result = await response.json();
        setCities(result.cities);
      } catch (error) {
        setError('Error al obtener las ciudades');
      }
    };

    fetchCities();
  }, []);

  const handleAddProperty = async () => {
    try {
      const response = await fetch('http://localhost:5000/add-property', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify({
          name: newPropertyName,
          description: newPropertyDescription,
          city: newPropertyCity,
          address: newPropertyAddress,
        }),
      });

      if (!response.ok) {
        throw new Error('Error al agregar la propiedad');
      }

      navigate('/'); // Redirige de vuelta a la página principal después de agregar la propiedad
    } catch (error) {
      setError('Error al agregar la propiedad');
    }
  };

  if (error) {
    return <div>{error}</div>;
  }

  return (
    <div className="container mx-auto mt-8">
      <div className="max-w-md mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Agregar Nueva Propiedad</h2>
        <label className="block text-gray-700 text-sm font-bold mb-2">Nombre de la Propiedad</label>
        <input
          type="text"
          name="name"
          value={newPropertyName}
          onChange={(e) => setNewPropertyName(e.target.value)}
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline mb-2"
        />
        <label className="block text-gray-700 text-sm font-bold mb-2">Descripción de la Propiedad</label>
        <textarea
          value={newPropertyDescription}
          name="description"
          onChange={(e) => setNewPropertyDescription(e.target.value)}
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline mb-2"
        />
        <label className="block text-gray-700 text-sm font-bold mb-2">Ciudad de la Propiedad</label>
        <select
          value={newPropertyCity}
          onChange={(e) => setNewPropertyCity(e.target.value)}
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline mb-2"
        >
          <option value="">Selecciona una ciudad</option>
          {cities.map(city => (
            <option key={city} value={city}>{city}</option>
          ))}
        </select>
        <label className="block text-gray-700 text-sm font-bold mb-2">Dirección de la Propiedad</label>
        <input
          type="text"
          name="address"
          value={newPropertyAddress}
          onChange={(e) => setNewPropertyAddress(e.target.value)}
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline mb-2"
        />
        <button onClick={handleAddProperty} className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mt-4">
          Agregar
        </button>
      </div>
    </div>
  );
};

export default AddPropertyForm;
