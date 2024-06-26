/* eslint-disable @typescript-eslint/no-explicit-any */
import { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';

interface Country {
  id: number;
  name: string;
}


const Register: React.FC = () => {
  const [redirectToLogin, setRedirectToLogin] = useState(false);
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
      .then(response => response.text())  // Leer los datos como texto
      .then(data => {
        // Convertir los datos de texto en un arreglo de objetos
        const parsedData = parseTextData(data);
        setCountries(parsedData);
      })
      .catch(error => console.error('Error fetching countries:', error));
  }, []);


  // Función para analizar los datos de texto
function parseTextData(textData: string): Country[] {
    const rows = textData.split('\n');
    const countries = rows.map(row => {
        const [id, name] = row.split(',').map(item => item.trim());
        return { id: parseInt(id), name: name }; // Convertir id a número usando parseInt
    });
    return countries;
}




  

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value, type } = e.target;
    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? (e.target as HTMLInputElement).checked ? value : '' : value
    });
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const { firstName, lastName, email, address, city, country, role, password } = formData;
    if (!firstName || !lastName || !email || !address || !city || !country || !role || !password) {
      setFormError('Por favor complete todos los campos');
      return;
    }
  
    try {
      const response = await fetch('http://localhost:5000/register', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
      });
  
      const result = await response.json();
      if (response.status === 200) {
        console.log('Formulario enviado:', result);
        // Redirige a la página de inicio de sesión
        setRedirectToLogin(true);
      } else if (response.status === 400 && result.error === 'El correo electrónico ya está en uso') {
        // El correo electrónico ya está en uso, muestra un mensaje de error
        setFormError('El correo electrónico ya está en uso');
      } else {
        // Otro error, muestra el mensaje de error del servidor
        setFormError(result.error || 'Error en el envío del formulario');
      }
    } catch (error) {
      setFormError('Error en el envío del formulario');
    }
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

