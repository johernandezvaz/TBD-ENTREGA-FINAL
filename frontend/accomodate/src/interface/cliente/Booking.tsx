import { useEffect, useState } from 'react';
import { useParams, Navigate } from 'react-router-dom';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';

interface Property {
  id: number;
  name: string;
  description: string;
  direccion: string;
  precio: number;
  nombre_ciudad: string;
  anfitrion: string;
}

interface Reservation {
  idAlojamiento: number | undefined;
  fechaInicio: string;
  fechaFin: string;
}

const Booking: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const [property, setProperty] = useState<Property | null>(null);
  const [availability, setAvailability] = useState<string[]>([]);
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showPopup, setShowPopup] = useState(false);
  const [reservationPrice, setReservationPrice] = useState<number | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const propertyResponse = await fetch(`http://localhost:5000/property/${id}`);
        if (!propertyResponse.ok) {
          throw new Error('Error al obtener los detalles de la propiedad');
        }
        const propertyData = await propertyResponse.json();
        setProperty(propertyData);

        const availabilityResponse = await fetch(`http://localhost:5000/property/${id}/availability`);
        if (!availabilityResponse.ok) {
          throw new Error('Error al obtener la disponibilidad');
        }
        const availabilityData = await availabilityResponse.json();
        setAvailability(availabilityData.availability);

        setLoading(false);
      } catch (error) {
        if (error instanceof Error) {
          setError(error.message);
        } else {
          console.error('Error:', error);
        }
      }
    };

    fetchData();
  }, [id]);

  const handleReservarClick = () => {
    setShowPopup(true);
  };

  const handleSubmitReservation = async () => {
    if (!startDate || !endDate) {
      alert('Por favor selecciona las fechas de inicio y fin de la estancia.');
      return;
    }

    const reservation: Reservation = {
      idAlojamiento: property?.id_alojamiento,
      fechaInicio: startDate.toISOString().split('T')[0],
      fechaFin: endDate.toISOString().split('T')[0],
    };

    


    try {
      const response = await fetch('http://localhost:5000/calculate-reservation-price', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          id_alojamiento: reservation.idAlojamiento,
          fecha_inicio: reservation.fechaInicio,
          fecha_fin: reservation.fechaFin,
        }),
      });
      if (!response.ok) {
        throw new Error('Error al calcular el precio de la reserva');
      }
      const data = await response.json();
      setReservationPrice(data.price);

      // Aquí puedes proceder a confirmar la reserva si lo deseas
      console.log(confirmarReserva)
      confirmarReserva(reservation);
    } catch (error) {
      console.error('Error al calcular el precio de la reserva:', error);
    }
  };

  const confirmarReserva = (reservation: Reservation) => {
    if (reservation.fechaInicio && reservation.fechaFin) {
      fetch('http://localhost:5000/confirmar-reserva', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify(reservation),
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('Error al confirmar la reserva');
          }
          return response.json();
        })
        .then(data => {
          console.log('Reserva confirmada:', data);
          Navigate({ to: '/clientes' });
        })
        .catch(error => {
          console.error('Error al confirmar la reserva:', error);
        });
    }
  };

  if (loading) {
    return <div>Cargando...</div>;
  }

  if (error) {
    return <div>{error}</div>;
  }

  if (!property) {
    return <div>Propiedad no encontrada</div>;
  }

  const filterDates = (date: Date) => {
    const dateString = date.toISOString().split('T')[0];
    return !availability.includes(dateString);
  };
  console.log(handleSubmitReservation);
  return (
    <div className="max-w-4xl mx-auto p-4">
      <h1 className="text-3xl font-semibold mb-4">{property.name}</h1>
      <div className="bg-white shadow-lg rounded-lg overflow-hidden">
        <div className="p-6">
          <div className="mb-4">
            <h2 className="text-xl font-semibold">Descripción</h2>
            <p className="text-gray-700">{property.description}</p>
          </div>
          <div className="mb-4">
            <h2 className="text-xl font-semibold">Dirección</h2>
            <p className="text-gray-700">{property.direccion}</p>
          </div>
          <div className="mb-4">
            <h2 className="text-xl font-semibold">Precio por noche</h2>
            <p className="text-gray-700">${property.precio}</p>
          </div>
          <div className="mb-4">
            <h2 className="text-xl font-semibold">Ciudad</h2>
            <p className="text-gray-700">{property.nombre_ciudad}</p>
          </div>
          <div className="mb-4">
            <h2 className="text-xl font-semibold">Anfitrión</h2>
            <p className="text-gray-700">{property.anfitrion}</p>
          </div>
          <button onClick={handleReservarClick} className="bg-blue-500 text-white px-6 py-3 rounded-md mt-4 hover:bg-blue-600">
            Reservar Ahora
          </button>
        </div>
      </div>

      {showPopup && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h2 className="text-xl font-semibold mb-4">Selecciona tus fechas</h2>
            <div className="flex space-x-4 mb-4">
              <div>
                <label className="block text-gray-700">Fecha de inicio</label>
                <DatePicker
                  selected={startDate}
                  onChange={(date) => setStartDate(date)}
                  selectsStart
                  startDate={startDate}
                  endDate={endDate}
                  filterDate={filterDates}
                  className="border border-gray-300 p-2 rounded-md"
                />
              </div>
              <div>
                <label className="block text-gray-700">Fecha de fin</label>
                <DatePicker
                  selected={endDate}
                  onChange={(date) => setEndDate(date)}
                  selectsEnd
                  startDate={startDate}
                  endDate={endDate}
                  filterDate={filterDates}
                  className="border border-gray-300 p-2 rounded-md"
                  minDate={startDate}
                />
              </div>
            </div>
            <div className="mb-4">
              <h2 className="text-xl font-semibold">Precio de la reserva: ${reservationPrice !== null ? reservationPrice : 'Calculando...'}</h2>
            </div>
            <div className="flex justify-end space-x-4">
              <button
                onClick={() => setShowPopup(false)}
                className="bg-red-500 text-white px-6 py-3 rounded-md hover:bg-red-600"
              >
                Cancelar
              </button>
              <button
                onClick={handleSubmitReservation}
                className="bg-blue-500 text-white px-6 py-3 rounded-md hover:bg-blue-600"
              >
                Confirmar Reserva
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Booking;
