// TravelWithUsSection.tsx

import React from 'react';

interface TravelWithUsSectionProps {
  title: string;
  text: string;
  imageUrl: string;
}

const TravelWithUsSection: React.FC<TravelWithUsSectionProps> = ({ title, text, imageUrl }) => {
  return (
    <section className="py-10 bg-secondary-200">
      <div className="container mx-auto flex flex-col md:flex-row items-center">
        <div className="md:w-1/2 md:mr-4">
          <h2 className="text-3xl font-semibold mb-4 ml-4 text-secondary-100">{title}</h2>
          <p className="text-l text-secondary-100 ml-4">{text}</p>
        </div>
        <div className="md:w-1/2 mt-6 md:mt-0">
          <img src={imageUrl} alt="Travel with us" className="w-fit h-auto rounded-lg shadow-md" />
        </div>
      </div>
    </section>
  );
};

export default TravelWithUsSection;
