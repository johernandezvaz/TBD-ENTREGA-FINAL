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

interface Reservation {
  id_reserva: number;
  fecha_inicio: string;
  fecha_fin: string;
  alojamiento: string;
}

const HomepageCliente: React.FC = () => {
  const [userInfo, setUserInfo] = useState<UserInfo | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [selectedCountry, setSelectedCountry] = useState<string | null>(null);
  const [properties, setProperties] = useState<Property[]>([]);
  const [popupVisible, setPopupVisible] = useState(false);
  const [allCountries, setAllCountries] = useState<AllCountry[]>([]);
  const [searchCountries, setSearchCountries] = useState<string[]>([]);
  const [reservations, setReservations] = useState<Reservation[]>([]);
  const [updateData, setUpdateData] = useState({
    email: '',
    password: ''
  });
  const [updateError, setUpdateError] = useState<string | null>(null);
  const [updateMessage, setUpdateMessage] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchUserInfo = async () => {
      try {
        const response = await fetch('http://localhost:5000/cliente-info', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include', 
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

  useEffect(() => {
    const fetchReservations = async () => {
      try {
        const response = await fetch('http://localhost:5000/mis-reservas', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
        });

        if (!response.ok) {
          throw new Error('Error al obtener las reservas');
        }

        const result = await response.json();
        setReservations(result.reservas);
      } catch (error) {
        setError('Error al obtener las reservas');
      }
    };

    fetchReservations();
  }, []);

  const handleCancelReservation = async (id_reserva: number) => {
    try {
      const response = await fetch('http://localhost:5000/cancelar-reserva', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify({ id_reserva }),
      });

      if (!response.ok) {
        throw new Error('Error al cancelar la reserva');
      }

      const result = await response.json();
      alert(result.message);
      
      // Actualizar la lista de reservas
      setReservations(reservations.filter(reservation => reservation.id_reserva !== id_reserva));
    } catch (error) {
      alert('Error al cancelar la reserva');
    }
  };

  function parseTextData(textData: string): AllCountry[] {
    const rows = textData.split('\n');
    const countries = rows.map(row => {
        const [id, name] = row.split(',').map(item => item.trim());
        return { id: parseInt(id), name: name }; 
    });
    return countries;
  }

  useEffect(() => {
    fetch('http://localhost:5000/countries')
      .then(response => response.text()) 
      .then(data => {
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

  const handleUpdateChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setUpdateData({ ...updateData, [name]: value });
  };

  const handleUpdateSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const response = await fetch('http://localhost:5000/update-user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify(updateData),
      });

      const result = await response.json();
      if (response.ok) {
        setUpdateMessage('Información actualizada exitosamente');
      } else {
        setUpdateError(result.error);
      }
    } catch (error) {
      setUpdateError('Error al actualizar la información');
    }
  };

  const handleDeleteUser = async () => {
    try {
      const response = await fetch('http://localhost:5000/delete-user', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
      });

      if (response.ok) {
        navigate(`/iniciar-sesion`);
      } else {
        setUpdateError('Error al eliminar la cuenta');
      }
    } catch (error) {
      setUpdateError('Error al eliminar la cuenta');
    }
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
          <h3 className="text-xl font-semibold mb-2 mt-4">Mis Reservas:</h3>
          {reservations.length === 0 ? (
            <p>No tienes reservas actualmente.</p>
          ) : (
            <ul>
              {reservations.map((reservation) => (
                <li key={reservation.id_reserva} className="mb-4 border-b border-gray-300 pb-4">
                  <h4 className="text-lg font-semibold">{reservation.alojamiento}</h4>
                  <p>Fecha inicio: {reservation.fecha_inicio}</p>
                  <p>Fecha fin: {reservation.fecha_fin}</p>
                  <button
                    onClick={() => handleCancelReservation(reservation.id_reserva)}
                    className="mt-2 bg-red-500 text-white px-4 py-2 rounded-md"
                  >
                    Cancelar Reserva
                  </button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}

      {popupVisible && (
        <div className="popup fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-4 rounded shadow-md max-w-md w-full">
            <button className="absolute top-0 right-0 mt-2 mr-2 text-gray-600 hover:text-gray-800" onClick={closePopup}>
              <FaTimes />
            </button>
            <h3 className="text-xl font-semibold mb-4 text-center">{selectedCountry}</h3>
            <div className="grid grid-cols-1 gap-4">
              {properties.map((property) => (
                <div key={property.id} className="border border-gray-300 p-4 rounded">
                  <h4 className="text-lg font-semibold mb-2">{property.name}</h4>
                  <p className="mb-2">{property.description}</p>
                  <button onClick={() => handleReservarClick(property)} className="mt-2 bg-alternative-300 text-alternative-200 hover:bg-gray-200 hover:text-alternative-200 px-4 py-2 rounded-md">
                    Reservar
                  </button>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      <div className="max-w-screen-lg mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Actualizar Información</h2>
        <form onSubmit={handleUpdateSubmit}>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="email">
              Correo Electrónico
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="email"
              type="email"
              placeholder="Correo Electrónico"
              name="email"
              value={updateData.email}
              onChange={handleUpdateChange}
            />
          </div>
          <div className="mb-6">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="password">
              Contraseña
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="password"
              type="password"
              placeholder="******************"
              name="password"
              value={updateData.password}
              onChange={handleUpdateChange}
            />
          </div>
          <div className="flex items-center justify-between">
            <button
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              type="submit"
            >
              Actualizar
            </button>
            <button
              className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              type="button"
              onClick={handleDeleteUser}
            >
              Eliminar Cuenta
            </button>
          </div>
          {updateError && <p className="text-red-500 text-xs italic mt-4">{updateError}</p>}
          {updateMessage && <p className="text-green-500 text-xs italic mt-4">{updateMessage}</p>}
        </form>
      </div>
    </div>
  );
};

export default HomepageCliente;

