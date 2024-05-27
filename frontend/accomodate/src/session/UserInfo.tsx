import { useEffect, useState } from 'react';

const UserInfo: React.FC = () => {
  const [userInfo, setUserInfo] = useState<{ user_id: number; user_name: string; user_role: string } | null>(null);
  const [error, setError] = useState('');

  useEffect(() => {
    fetch('http://localhost:5000/user-info', {
      method: 'GET',
      credentials: 'include', // Asegura que las cookies de sesión se envíen y reciban
    })
      .then(response => response.json())
      .then(data => {
        if (data.error) {
          setError(data.error);
        } else {
          setUserInfo(data);
        }
      })
      .catch(() => setError('Error fetching user info'));
  }, []);

  if (error) {
    return <div>{error}</div>;
  }

  if (!userInfo) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      <h1>Welcome, {userInfo.user_name}</h1>
      <p>Role: {userInfo.user_role}</p>
    </div>
  );
};

export default UserInfo;
