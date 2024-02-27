// TestimonialsSection.tsx

import React from 'react';
import { Testimonial } from '../data/TestimonialsData';

interface TestimonialsSectionProps {
  testimonials: Testimonial[];
}

const TestimonialsSection: React.FC<TestimonialsSectionProps> = ({ testimonials }) => {
  return (
    <section className="py-10 bg-secondary-100">
      <div className="container mx-auto">
        <h2 className="text-3xl font-semibold mb-10 text-center">¿Qué tienen que decir nuestros clientes?</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 ">
          {testimonials.map((testimonial) => (
            <div key={testimonial.name} className="border rounded-lg shadow-md p-4 bg-secondary-300">
              <div className="overflow-hidden rounded-full mb-4">
                <img
                  src={`/${testimonial.image}`}
                  alt={testimonial.name}
                  className="w-full h-1/2 rounded-sm"
                />
              </div>
              <h3 className="text-lg font-bold mb-2 text-secondary-100">{testimonial.name}</h3>
              <p className="text-primary">{testimonial.text}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default TestimonialsSection;
