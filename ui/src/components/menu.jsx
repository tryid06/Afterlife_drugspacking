import { useState } from "react";
import { NuiEvent } from "../hooks/NuiEvent";
import weightscale from "../assets/weightscale.png";
import icon from "../assets/weighticon.png";
import image from "../assets/bullet.png"
import { nuicallback } from "../utils/nuicallback";
const Menu = () => {
    const [Data, setData] = useState(false);
    const [Counter, setCounter] = useState(false);
    
    NuiEvent('SendData',(data) => setData(data));
    

    return (
        Data &&
        <>
        <div className="menu">
            <div className="weight">
                <p>{Data[Counter] ? Data[Counter].weight: '0'}</p>
                <p  className="kg">kg</p>
            </div>
            <div className="items">
                {Data.map((data,index) => (
                <div onClick={() => nuicallback('ReturnData',data.id)} onMouseEnter={() => setCounter(index)}>
                    <img src={data.image} alt="" />
                    <span>{data.label}</span>
                </div>
                ))}
                
                 

            </div>

            <img className="icon" src={icon} alt="" />
            
        </div>
        </>
    )
}

export default Menu;