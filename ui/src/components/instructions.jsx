import { useState } from "react"
import { NuiEvent } from "../hooks/NuiEvent";


const Instructions = () =>  {
    const [visible,setVisible] = useState(false);
    NuiEvent('Instructions',(data) => setVisible(data));

    return  (
        visible &&
        <>
        <div className="instructions">

            <div className="key">
                <div>ENTER</div>
                <span>Place</span>
            </div>
            <div className="key">
                <div>BACKSPACE</div>
                <span>Cancel</span>
            </div>
            
        </div>
        </>
    )
}

export default Instructions;