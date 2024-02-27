import './App.css'
import CityHeroSection from './components/CityHeroSection'
import ContactForm from './components/ContactForm';
import Footer from './components/Footer';
import Header from './components/Header'
import TestimonialsSection from './components/TestimonialsSection';
import TravelWithUsSection from './components/TravelWithUsSection';
import testimonialsData from './data/TestimonialsData';

function App() {
  const cities = [
    { name: 'Berlin', image: './citiy-1.jpg' },
    { name: 'Dublin', image: './citiy-2.jpg' },
    { name: 'Zurich', image: './citiy-3.jpg' },
    { name: 'USA', image: './citiy-4.jpg' },
    { name: 'Francia', image: './citiy-5.jpg' },
    { name: 'México', image: './citiy-6.jpg' },
  ];

  const text = "Eiusmod consequat eiusmod pariatur et est reprehenderit ullamco incididunt adipisicing laborum. Minim officia sint ullamco sunt laboris. Incididunt proident in voluptate veniam nulla proident qui ex laboris. Elit irure est qui qui esse aliquip deserunt consequat cillum commodo.";

  return (
    <>
      <Header />
      <CityHeroSection cities={cities} />
      <TravelWithUsSection title={'¿Porque reservar con nostros?'} text={text} imageUrl={'./travel.jpg  '} />
      <TestimonialsSection testimonials={testimonialsData} />
      <ContactForm />
      <Footer />
    </>
  )
}

export default App
