import React, { useEffect, useState } from 'react';
import { FaTimes } from 'react-icons/fa';
import { useNavigate } from 'react-router-dom';

interface UserInfo {
  name: string;
  role: string;
  countries: string[];
}

interface Property {
  id: number;
  name: string;
  description: string;
}

interface AllCountry {
  id: number;
  name: string;
}

const HomepageCliente: React.FC = () => {
  const [userInfo, setUserInfo] = useState<UserInfo | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [selectedCountry, setSelectedCountry] = useState<string | null>(null);
  const [properties, setProperties] = useState<Property[]>([]);
  const [popupVisible, setPopupVisible] = useState(false);
  const [allCountries, setAllCountries] = useState<AllCountry[]>([]);
  const [searchCountries, setSearchCountries] = useState<string[]>([]);
  const navigate = useNavigate();

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

  function parseTextData(textData: string): AllCountry[] {
    const rows = textData.split('\n');
    const countries = rows.map(row => {
        const [id, name] = row.split(',').map(item => item.trim());
        return { id: parseInt(id), name: name }; // Convertir id a número usando parseInt
    });
    return countries;
  }

  useEffect(() => {
    fetch('http://localhost:5000/countries')
      .then(response => response.text())  // Leer los datos como texto
      .then(data => {
        // Convertir los datos de texto en un arreglo de objetos
        const parsedData = parseTextData(data);
        setAllCountries(parsedData);
      })
      .catch(error => console.error('Error fetching countries:', error));
  }, []);

  const handleReservarClick = (property: Property) => {
    navigate(`/reserva/${property.id}`);
  };

  const handleCountryClick = async (country: string) => {
    setSelectedCountry(country);
    setPopupVisible(true);

    try {
      const response = await fetch(`http://localhost:5000/properties?country=${country}`);
      if (!response.ok) {
        throw new Error('Error al obtener las propiedades');
      }
      const data = await response.json();
      setProperties(data.properties);
    } catch (error) {
      console.error('Error al obtener las propiedades:', error);
    }
  };

  const handleCountryChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
    const country = event.target.value;
    if (country) {
      setSearchCountries([country]);
    } else {
      setSearchCountries([]);
    }
  };

  const closePopup = () => {
    setPopupVisible(false);
    setSelectedCountry(null);
    setProperties([]);
  };

  return (
    <div className="container mx-auto mt-8">
      {error && <div>{error}</div>}
      {!userInfo && <div>Cargando...</div>}
      {userInfo && (
        <div className="max-w-screen-lg mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
          <h2 className="text-center text-2xl font-semibold mb-4">Bienvenido, {userInfo.name}</h2>
          <p className="text-center mb-4">Rol: {userInfo.role}</p>
          <h3 className="text-xl font-semibold mb-2">Países recomendados para viajar:</h3>
          <div className="flex flex-wrap">
            {userInfo.countries.map((country, index) => (
              <button key={index} onClick={() => handleCountryClick(country)} className="m-2 bg-alternative-300 text-alternative-200 hover:bg-gray-200 hover:text-alternative-200 px-4 py-2 rounded-md">
                {country}
              </button>
            ))}
          </div>
          <h3 className="text-xl font-semibold mb-2 mt-4">Busca tu destino ideal:</h3>
          <select
            value={selectedCountry || ''}
            onChange={handleCountryChange}
            className="border border-gray-300 rounded-md px-3 py-2 mb-4 w-full"
          >
            <option value="">Selecciona un país...</option>
            {allCountries.map((country: AllCountry) => (
              <option key={country.id} value={country.name}>{country.name}</option>
            ))}
          </select>

          {searchCountries.length > 0 && (
            <div className="flex flex-wrap">
              {searchCountries.map((country, index) => (
                <button key={index} onClick={() => handleCountryClick(country)} className="m-2 bg-alternative-300 text-alternative-200 hover:bg-gray-200 hover:text-alternative-200 px-4 py-2 rounded-md">
                  {country}
                </button>
              ))}
            </div>
          )}
        </div>
      )}

      {popupVisible && (
        <div className="fixed top-0 left-0 w-full h-full flex justify-center items-center bg-gray-800 bg-opacity-75">
          <div className="bg-white rounded-md p-4 max-h-96 overflow-y-auto"> {/* Ajustar la altura máxima y permitir desplazamiento vertical */}
            <div className="flex justify-end mb-2"> {/* Agregar un contenedor para el icono de cierre */}
              <button onClick={closePopup} className="absolute top-0 right-0 bg-red-500 text-white px-4 py-2 rounded-md flex items-center mt-2 mr-2">
                <FaTimes className="mr-1" /> Cerrar
              </button>
            </div>
            <h2 className="text-xl font-semibold mb-4">{selectedCountry} Propiedades</h2>
            {properties.length === 0 ? (
              <p>No hay propiedades aún en este país, lamentamos las molestias</p>
            ) : (
              <ul>
                {properties.map((property) => (
                  <li key={property.id}>
                    <h3>{property.name}</h3>
                    <p>{property.description}</p>
                    <button onClick={() => handleReservarClick(property)} className="bg-blue-500 text-white px-4 py-2 rounded-md mt-2">Reservar</button>
                  </li>
                ))}
              </ul>
            )}
            <button onClick={closePopup} className="bg-red-500 text-white px-4 py-2 rounded-md mt-4">Cerrar</button>
          </div>
        </div>
      )}
    </div>
  );
};

export default HomepageCliente;
