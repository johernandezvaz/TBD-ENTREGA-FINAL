import { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import './App.css';
import CityHeroSection from './components/CityHeroSection';
import ContactForm from './components/ContactForm';
import Footer from './components/Footer';
import Header from './components/Header';
import TestimonialsSection from './components/TestimonialsSection';
import TravelWithUsSection from './components/TravelWithUsSection';
import testimonialsData from './data/TestimonialsData';
import Login from './screens/Login';
import Register from './screens/Register';
import HomepageCliente from './interface/HomepageCliente';
import HomepageArrendatario from './interface/HomepageArrendatario';
import AddPropertyForm from './interface/arrendatario/AddPropertyForm';
import Booking from './interface/cliente/Booking';

function App() {
  const [loggedIn, setLoggedIn] = useState(false);
  const [role, setRole] = useState<string | undefined>(undefined);

  useEffect(() => {
    // Recuperar el estado de autenticación de localStorage cuando el componente se monta
    const storedLoggedIn = localStorage.getItem('loggedIn') === 'true';
    const storedRole = localStorage.getItem('role');
    if (storedLoggedIn && storedRole) {
      setLoggedIn(storedLoggedIn);
      setRole(storedRole);
    }
  }, []);

  const paises = [
    { name: 'Alemania', image: './citiy-1.jpg' },
    { name: 'Irlanda', image: './citiy-2.jpg' },
    { name: 'Suiza', image: './citiy-3.jpg' },
    { name: 'Estados Unidos', image: './citiy-4.jpg' },
    { name: 'Francia', image: './citiy-5.jpg' },
    { name: 'México', image: './citiy-6.jpg' },
  ];

  const text =
    'Eiusmod consequat eiusmod pariatur et est reprehenderit ullamco incididunt adipisicing laborum. Minim officia sint ullamco sunt laboris. Incididunt proident in voluptate veniam nulla proident qui ex laboris. Elit irure est qui qui esse aliquip deserunt consequat cillum commodo.';

    const handleLogin = (userRole: string) => {
      setLoggedIn(true);
      setRole(userRole);
      // Guardar el estado de autenticación en localStorage
      localStorage.setItem('loggedIn', 'true');
      localStorage.setItem('role', userRole);
    };

    const handleLogout = () => {
      setLoggedIn(false);
      setRole(undefined);
      // Eliminar el estado de autenticación de localStorage
      localStorage.removeItem('loggedIn');
      localStorage.removeItem('role');
    };

  return (
    <Router>
      <Header loggedIn={loggedIn} onLogout={handleLogout} role={role} />
      <Routes>
        <Route path="/" element={
          <>
            <CityHeroSection cities={paises} />
            <TravelWithUsSection title={'¿Porque reservar con nosotros?'} text={text} imageUrl={'./travel.jpg  '} />
            <TestimonialsSection testimonials={testimonialsData} />
            <ContactForm />
            <Footer />
          </>
        } />
        <Route path="/iniciar-sesion" element={<Login onLogin={handleLogin} />} />
        <Route path="/registrarse" element={<Register />} />
        <Route path="/cliente" element={loggedIn && role === 'Cliente' ? <HomepageCliente /> : <Navigate to="/iniciar-sesion" />} />
        <Route path="/arrendatario" element={loggedIn && role === 'Arrendatario' ? <HomepageArrendatario /> : <Navigate to="/iniciar-sesion" />} />
        <Route path="/add-property" element={<AddPropertyForm />} />
        <Route path="/reserva/:id" element={<Booking />} />
      </Routes>
    </Router>
  );
}

export default App;
