import React, { useEffect, useState } from 'react';
import Modal from 'react-modal';
import { Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';


interface Property {
  id: number;
  name: string;
  description: string;
  city: string;
  address: string;
}

interface Estadisticas {
  numero_total_reservas: number;
  ingresos_generados: number;
  promedio_duracion_estancia: number;
}

const HomepageArrendatario: React.FC = () => {
  const [properties, setProperties] = useState<Property[]>([]);
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [estadisticas, setEstadisticas] = useState<Estadisticas | null>(null);
  const [fechaInicio, setFechaInicio] = useState<string>('');
  const [fechaFin, setFechaFin] = useState<string>('');
  const navigate = useNavigate();

  
  // Estado para actualización de usuario
  const [updateData, setUpdateData] = useState({
    email: '',
    password: ''
  });
  const [updateError, setUpdateError] = useState<string | null>(null);
  const [updateMessage, setUpdateMessage] = useState<string | null>(null);

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

  const fetchEstadisticas = async () => {
    try {
      const response = await fetch(`http://localhost:5000/estadisticas-reservas?fecha_inicio=${fechaInicio}&fecha_fin=${fechaFin}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
      });

      if (!response.ok) {
        throw new Error('Error al obtener las estadísticas');
      }

      const result = await response.json();
      setEstadisticas(result);
    } catch (error) {
      setError('Error al obtener las estadísticas');
    }
  };

  if (error) {
    return <div>{error}</div>;
  }

  const handlePropertyClick = (property: Property) => {
    setSelectedProperty(property);
  };

  const closeModal = () => {
    setSelectedProperty(null);
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
        // Redirigir al usuario a la página de inicio de sesión u otra acción apropiada
    navigate(`/iniciar-sesion`);

      } else {
        setUpdateError('Error al eliminar la cuenta');
      }
    } catch (error) {
      setUpdateError('Error al eliminar la cuenta');
    }
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
        
        <div className="mt-8">
          <h3 className="text-center text-2xl font-semibold mb-4">Estadísticas de Reservas</h3>
          <div className="flex justify-center mb-4">
            <input
              type="date"
              value={fechaInicio}
              onChange={(e) => setFechaInicio(e.target.value)}
              className="border rounded p-2 mr-2"
            />
            <input
              type="date"
              value={fechaFin}
              onChange={(e) => setFechaFin(e.target.value)}
              className="border rounded p-2"
            />
            <button
              onClick={fetchEstadisticas}
              className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded ml-2"
            >
              Obtener Estadísticas
            </button>
          </div>

          {estadisticas && (
            <div className="text-center">
              <p>Total de Reservas: {estadisticas.numero_total_reservas}</p>
              <p>Ingresos Generados: ${estadisticas.ingresos_generados.toFixed(2)}</p>
              <p>Promedio de Duración de Estancia: {estadisticas.promedio_duracion_estancia.toFixed(2)} días</p>
            </div>
          )}
        </div>
        
        {/* Formulario de Actualización */}
        <div className="mt-8">
          <h3 className="text-center text-2xl font-semibold mb-4">Actualizar Información de Usuario</h3>
          <form onSubmit={handleUpdateSubmit} className="max-w-md mx-auto">
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
            <div className="mb-4">
              <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="password">
                Contraseña
              </label>
              <input
                className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                id="password"
                type="password"
                placeholder="Contraseña"
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
            </div>
            {updateMessage && <p className="text-green-500 mt-4">{updateMessage}</p>}
            {updateError && <p className="text-red-500 mt-4">{updateError}</p>}
          </form>
        </div>

        {/* Botón de Eliminación */}
        <div className="mt-8 text-center">
          <button
            onClick={handleDeleteUser}
            className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          >
            Eliminar Cuenta
          </button>
          {updateError && <p className="text-red-500 mt-4">{updateError}</p>}
        </div>
      </div>
    </div>
  );
};

export default HomepageArrendatario;
