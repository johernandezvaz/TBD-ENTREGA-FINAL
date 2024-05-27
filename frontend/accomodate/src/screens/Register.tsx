/* eslint-disable @typescript-eslint/no-explicit-any */
import { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';

interface Country {
  id: number;
  name: string;
}

const Register: React.FC = () => {
  const [redirectToLogin] = useState(false);
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    address: '',
    country: '',
    city: '',
    role: '',
    password: '' // Añadido para la contraseña
  });
  const [countries, setCountries] = useState<Country[]>([]);
  const [formError, setFormError] = useState('');

  useEffect(() => {
    // Fetch países disponibles al cargar el componente
    fetch('http://localhost:5000/countries')
      .then(response => {
        if (!response.ok) {
          throw new Error('Error al obtener países');
        }
        return response.json();
      })
      .then((data: Country[]) => setCountries(data))
      .catch(error => console.error('Error fetching countries:', error));
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value, type } = e.target;
    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? (e.target as HTMLInputElement).checked ? value : '' : value
    });
  };

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const { firstName, lastName, email, address, city, country } = formData;
    if (!firstName || !lastName || !email || !address || !city || !country) {
      setFormError('Por favor complete todos los campos');
      return;
    }
    // Aquí puedes manejar la lógica de envío del formulario
    console.log('Formulario enviado:', formData);
  };

  if (redirectToLogin) {
    return <Navigate to="/iniciar-sesion" />;
  }

  return (
    <div className="container mx-auto mt-8">
      <div className="max-w-md mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Registrarse</h2>
        {formError && <p className="text-red-500 text-xs italic mb-4">{formError}</p>}
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="firstName">
              Nombre
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="firstName"
              type="text"
              placeholder="Nombre"
              name="firstName"
              value={formData.firstName}
              onChange={handleChange}
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="lastName">
              Apellido
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="lastName"
              type="text"
              placeholder="Apellido"
              name="lastName"
              value={formData.lastName}
              onChange={handleChange}
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="email">
              Correo electrónico
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="email"
              type="email"
              placeholder="Correo electrónico"
              name="email"
              value={formData.email}
              onChange={handleChange}
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="address">
              Dirección
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="address"
              type="text"
              placeholder="Dirección"
              name="address"
              value={formData.address}
              onChange={handleChange}
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="city">
              Ciudad
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="city"
              type="text"
              placeholder="Ciudad"
              name="city"
              value={formData.city}
              onChange={handleChange}
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="country">
              País
            </label>
            <select
              className="shadow appearance-none border rounded w-full py-2 px-3 text-black leading-tight focus:outline-none focus:shadow-outline"
              id="country"
              name="country"
              value={formData.country}
              onChange={handleChange}
            >
              <option value="">Seleccionar país</option>
              {countries.map((country: any) => (
                <option key={country.id} value={country.id}>{country.name}</option>
              ))}
            </select>
          </div>
          <div className="mb-4">
            <span className="block text-gray-700 text-sm font-bold mb-2">Tipo de usuario</span>
            <label className="block text-gray-700 text-sm mb-2">
              <input
                type="checkbox"
                name="role"
                value="Arrendatario"
                checked={formData.role === 'Arrendatario'}
                onChange={handleChange}
              />
              Arrendatario
            </label>
            <label className="block text-gray-700 text-sm">
              <input
                type="checkbox"
                name="role"
                value="Cliente"
                checked={formData.role === 'Cliente'}
                onChange={handleChange}
              />
              Cliente
            </label>
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
              value={formData.password}
              onChange={handleChange}
            />
          </div>
          <div className="flex items-center justify-between">
            <button
              className="bg-secondary-200 hover:bg-blue-400 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              type="submit"
            >
              Registrarse
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Register;

