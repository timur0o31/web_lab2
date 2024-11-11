document.addEventListener("DOMContentLoaded", function() {
    const checkboxes_x = document.querySelectorAll('input[name="x-value"]');
    const checkboxes_r = document.querySelectorAll('input[name="r-value"]');
    function checkBoxes(checkbox1){
        checkbox1.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            if (this.checked) {
                checkbox1.forEach(box => {
                    if (box !== this) {
                        box.disabled = true;
                    }});
            } else {
                checkbox1.forEach(box => {
                    box.disabled = false;
                });
            }
        });
    });
    }
    checkBoxes(checkboxes_r);
    checkBoxes(checkboxes_x);
    document.getElementById('form1').addEventListener('submit', function(event) {
        event.preventDefault();
        let xValue = null;
        let rValue = null;
        let rCheckedBoxes = document.querySelectorAll('input[name="r-value"]:checked');
        if (!validateR(rCheckedBoxes)) {
            return;
        }
        rValue = parseFloat(rCheckedBoxes[0].value);
        const currentTime = new Date().toLocaleString();
        const xCheckedBoxes = document.querySelectorAll('input[name="x-value"]:checked');
        if (xCheckedBoxes.length > 1) {
            document.getElementById("error-message-x").innerText = "Пожалуйста, выберите только одно значение X.";
            return;
        } else {
            document.getElementById("error-message-x").innerText = "Выберите значение для X.";
            xValue = parseInt(xCheckedBoxes[0].value)
        }
        const yValue = document.getElementById('y-value').value;
        if (!validateArgument(xValue, yValue)) return;
        sendData(xValue,yValue,rValue);
    });
    function sendData(xValue, yValue, rValue) {
        const data = {
            x: xValue,
            y: yValue,
            r: rValue
        };
        let params = new URLSearchParams(data);
        fetch("/wLab2-1.0-SNAPSHOT/controller?" + params.toString(), {
            method: 'GET',
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            }
        })
            .then(response => {
                if (!response.ok)
                    throw new Error('network or server error');
                return response.text();
            })
            .then(html => {
                document.open();
                document.write(html);
                document.close();
            })
            .catch(error => {
                console.error('error:', error);
            });
    }
    document.getElementById("mySVG1").addEventListener('click', function(event){
        let rCheckedBoxes = document.querySelectorAll('input[name="r-value"]:checked');
        if (!validateR(rCheckedBoxes)){
            return false;
        }
        rValue = parseFloat(rCheckedBoxes[0].value);
        let svg = event.currentTarget;
        let rect = svg.getBoundingClientRect();
        let svgX = event.clientX - rect.left;
        let svgY = event.clientY - rect.top;
        let [x,y] = transformSvgToPlane(svgX,svgY,rValue);
        if (!validateArgumentSVG(x,y)){
            return ;
        }
        let xCheckedBoxes = document.querySelectorAll('input[name="x-value"]');
        xCheckedBoxes.forEach(box => box.checked = false);
        for (let i=0;i<xCheckedBoxes.length;i++){
            if (parseInt(xCheckedBoxes[i].value)===Math.round(x)){
                xCheckedBoxes[i].checked=true;
                break;
            }
        }
        document.getElementById('y-value').value=y;
        sendData(Math.round(x), y, rValue);
    })
})
function validateR(rCheckedBoxes){
    document.getElementById('error-message-r').innerHTML = "";
    if (rCheckedBoxes.length < 1){
        document.getElementById("error-message-r").innerText="Пожалуйста, выберите значение для R.";
        return false;
    } else if(rCheckedBoxes.length > 1){
        document.getElementById("error-message-r").innerText = "Пожалуйста, выберите только одно значение для R.";
        return false;
    }else{
        let rValue1 = parseFloat(rCheckedBoxes[0].value);
        document.getElementById("error-message-r").innerText = "";
        return true
    }
}
function validateArgument(xValue, yValue){
    const y = parseFloat(yValue);
    document.getElementById('error-message-x').innerHTML = "";
    document.getElementById('error-message-y').innerHTML = "";
    if(xValue === null){
        document.getElementById('error-message-x').innerHTML = "Значение для X должно быть выбрано!";
        return false;
    }
    if(isNaN(y) || yValue.trim()==="" || /[^0-9.-]/.test(yValue)){
        document.getElementById('error-message-y').innerHTML = "Y должен быть числом!";
        return false;
    }else if(y < -5 || y > 3){
        document.getElementById('error-message-y').innerHTML = "Y должен лежать в пределах [-5; 3]!";
        return false;
    }
    document.getElementById('error-message-x').innerHTML = "";
    document.getElementById('error-message-y').innerHTML = "";
    return true;
}
function validateArgumentSVG(x,y){
    document.getElementById('error-message-x').innerHTML = "";
    document.getElementById('error-message-y').innerHTML = "";
    if(x<-4 || x>4){
        document.getElementById('error-message-x').innerHTML = "Значение для X должно лежать в пределах [-4;4]!";
        return false;
    }
    if(y < -5 || y > 3){
        document.getElementById('error-message-y').innerHTML = "Y должен лежать в пределах [-5; 3]!";
        return false;
    }
    document.getElementById('error-message-x').innerHTML = "";
    document.getElementById('error-message-y').innerHTML = "";
    return true;

}
function doPoint(xValue, yValue, rValue, result, last) {
    const svg = document.getElementById('mySVG1');
    const y = parseFloat(yValue);
    const r = rValue;
    const x = xValue;
    console.log(svg);
    if (!svg) {
        console.error("SVG element not found!");
        return;
    }
    const circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
    const scaledX = x * 70 * 2/r + 200;
    const scaledY = -y * 70 * 2/r + 200;
    circle.setAttribute("cx", scaledX);
    circle.setAttribute("cy", scaledY);
    circle.setAttribute("r", 3);
    if (last){
        if (result==="hit") {
            circle.setAttribute("fill", "lime");
        }else {
            circle.setAttribute("fill", "red");
        }
    }else{
        circle.setAttribute("fill","grey");
    }
    svg.appendChild(circle);
}
function transformSvgToPlane(svgX, svgY, r) {
    let planeX = (svgX - 200) / (140 / r);
    let planeY = (200 - svgY) / (140 / r);
    return [planeX, planeY];
}
