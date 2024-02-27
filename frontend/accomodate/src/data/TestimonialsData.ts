// TestimonialsData.tsx

export interface Testimonial {
  name: string;
  image: string;
  text: string;
}

const testimonialsData: Testimonial[] = [
  {
    name: 'John Doe',
    image: './headshot-2.jpg',
    text: '¡Excelente experiencia! El servicio fue excepcional y el equipo fue muy amable y servicial. Recomiendo encarecidamente viajar con ellos.',
  },
  {
    name: 'Jane Smith',
    image: './headshot-1.jpg',
    text: 'Increíble viaje con esta empresa. Los guías turísticos fueron expertos y nos brindaron una experiencia inolvidable. Definitivamente volveremos a viajar con ellos en el futuro.',
  },
  {
    name: 'John Doe',
    image: './headshot-3.jpg',
    text: '¡Excelente experiencia! El servicio fue excepcional y el equipo fue muy amable y servicial. Recomiendo encarecidamente viajar con ellos.',
  },
];

export default testimonialsData;
