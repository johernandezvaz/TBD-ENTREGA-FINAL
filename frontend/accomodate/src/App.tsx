import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
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

function App() {
  const paises = [
    { name: 'Berlin', image: './citiy-1.jpg' },
    { name: 'Irlanda', image: './citiy-2.jpg' },
    { name: 'Suiza', image: './citiy-3.jpg' },
    { name: 'Estados Unidos', image: './citiy-4.jpg' },
    { name: 'Francia', image: './citiy-5.jpg' },
    { name: 'México', image: './citiy-6.jpg' },
  ];

  const text =
    'Eiusmod consequat eiusmod pariatur et est reprehenderit ullamco incididunt adipisicing laborum. Minim officia sint ullamco sunt laboris. Incididunt proident in voluptate veniam nulla proident qui ex laboris. Elit irure est qui qui esse aliquip deserunt consequat cillum commodo.';

  return (
    <Router>
      <Header />
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
        <Route path="/iniciar-sesion" element={<Login />} />
        <Route path="/registrarse" element={<Register />} />
      </Routes>
    </Router>
  );
}

export default App;
