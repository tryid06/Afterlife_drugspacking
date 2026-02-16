import { useEffect, useState } from 'react';
import { NuiEvent } from '../hooks/NuiEvent';
import icon from '../assets/weighticon.png';
import { nuicallback } from '../utils/nuicallback';

const Menu = () => {
  const [Data, setData] = useState([]);
  const [Counter, setCounter] = useState(false);

  NuiEvent('SendData', (data) => setData(data));

  useEffect(() => {
    const handlekey = (e) => {
      if (Data && e.code === 'Escape') {
        setData(false);
        nuicallback('resetnuifocus');
      }
    };

    window.addEventListener('keydown', handlekey);
    return () => window.removeEventListener('keydown', handlekey);
  }, [Data]);

  return (
    Data && (
      <>
        <div className="menu">
          <div className="weight">
            <p>{Data[Counter] ? Data[Counter].weight : '0'}</p>
            <p className="kg">kg</p>
          </div>
          <div className="items">
            {Data.map((data, index) => (
              <div
                key={`${data.label}-${index}`}
                className={data.disabled ? 'disabled-item' : 'item'}
                style={{ opacity: data.disabled ? '0.5' : '1.0' }}
                onClick={() => !data.disabled && (nuicallback('ReturnData', data.id), setCounter(false))}
                onMouseEnter={() => !data.disabled && setCounter(index)}
              >
                <img src={data.image} alt="" />
                <span>{data.label}</span>
              </div>
            ))}
          </div>

          <img className="icon" src={icon} alt="" />
        </div>
      </>
    )
  );
};

export default Menu;
