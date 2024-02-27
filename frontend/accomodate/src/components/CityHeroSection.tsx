// CityHeroSection.tsx

import React from 'react';

interface City {
  name: string;
  image: string;
}

interface CityHeroSectionProps {
  cities: City[];
}

const CityHeroSection: React.FC<CityHeroSectionProps> = ({ cities }) => {
  const buttonText = "Ver alojamientos"; // Texto fijo para el botón

  return (
    <section className="bg-secondary-100 text-white py-10">
      <div className="container mx-auto">
        <h2 className="text-3xl font-semibold mb-4 text-secondary-200">¿Cuál será tu próximo destino?</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {cities.map((city, index) => (
            <div key={index} className="bg-secondary-300 rounded-lg overflow-hidden shadow-md">
              <div style={{ height: '200px' }}>
                <img src={`/${city.image}`} alt={city.name} className="w-full h-full object-cover" />
              </div>
              <div className="p-4">
                <h3 className="text-lg font-semibold mb-2 text-secondary-100">{city.name}</h3>
                <a href="#" className="inline-block py-2 px-4 bg-transparent border border-secondary-100 text-secondary-100 rounded-lg hover:bg-secondary-100 hover:text-secondary-200 transition duration-300">{buttonText}</a>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

export default CityHeroSection;
