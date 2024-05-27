import React, { useState } from 'react';
import { Navigate } from 'react-router-dom';

const Login: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [redirectToDashboard, setRedirectToDashboard] = useState(false);
  const [userRole, setUserRole] = useState<string | null>(null); // Añadir estado para el rol del usuario

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (!email || !password) {
      setError('Por favor, proporcione correo electrónico y contraseña');
      return;
    }

    const loginData = {
      email: email,
      password: password,
    };

    try {
      const response = await fetch('http://localhost:5000/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(loginData),
        credentials: 'include' // Asegura que las cookies de sesión se envíen y reciban
      });

      const result = await response.json();
      if (response.status === 200) {
        console.log('Inicio de sesión exitoso:', result);
        setUserRole(result.user.role); // Establecer el rol del usuario
        setRedirectToDashboard(true); // Establecer la redirección al dashboard
      } else {
        setError(result.error || 'Error en el inicio de sesión');
      }
    } catch (error) {
      setError('Error en el inicio de sesión');
    }
  };

  if (redirectToDashboard) {
    if (userRole === 'Cliente') {
      return <Navigate to="/cliente" />;
    } else if (userRole === 'Arrendatario') {
      return <Navigate to="/arrendatario" />;
    }
  }

  return (
    <div className="container mx-auto mt-8">
      <div className="max-w-md mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <h2 className="text-center text-2xl font-semibold mb-4">Iniciar Sesión</h2>
        {error && (
          <div className="mb-4 p-2 bg-red-500 text-white text-center rounded">
            {error}
          </div>
        )}
        <form onSubmit={handleSubmit}>
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
              value={email}
              onChange={(e) => setEmail(e.target.value)}
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
              placeholder="Contraseña"
              name="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </div>
          <div className="flex items-center justify-between">
            <button
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              type="submit"
            >
              Iniciar Sesión
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;
