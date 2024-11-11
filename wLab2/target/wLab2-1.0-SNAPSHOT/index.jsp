<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content ="ie=edge">
    <link rel="stylesheet" href="stylesheets.css">
</head>
<body>
<header>
    <h1> Веб-программирование, Лабораторная работа №2, Вариант - 409328 </h1>
    <h1> Альметов Тимур Айдарович </h1>
</header>
<div class = "flex-container">
    <div class="item">
        <h3 style="border: 2px solid black;border-radius: 5px;"> Граф </h3>
        <div class="coordinate-system">
            <svg id="mySVG1" width="400" height="400">
                <line x1="200" x2="200" y1="15" y2="390" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="10" x2="385" y1="200" y2="200" stroke="black" stroke-width="3"/>
                <polygon points="385,193 385,207 395,200" stroke="black" stroke-witdh="3"/>
                <polygon points="193,15 207,15 200,5" stroke="black" stroke-witdh="3"/>
                <line x1="193" x2="207" y1="270" y2="270" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="193" x2="207" y1="340" y2="340" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="193" x2="207" y1="130" y2="130" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="193" x2="207" y1="60" y2="60" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="60" x2="60" y1="193" y2="207" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="130" x2="130" y1="193" y2="207" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="340" x2="340" y1="193" y2="207" stroke="black" fill="transparent" stroke-width="3"/>
                <line x1="270" x2="270" y1="193" y2="207" stroke="black" fill="transparent" stroke-width="3"/>
                <polygon points="200,200 340,200 200,60" fill="rgba(0, 0, 255, 0.5)" stroke="black" stroke-width="1"/>
                <path d="M 200, 200 L 270,200 A 70,70 0 0,1 200,270 L 200,200" fill="rgba(0, 0, 255, 0.5)" stroke="black" stroke-width="1"/>
                <rect x="60" y="200" height="70" width="140" fill="rgba(0, 0, 255, 0.5)" stroke="black" stroke-width="1"/>
                <text x="210" y="20" font-family="Arial" font-size="18" fill="black">Y</text>
                <text x="385" y="190" font-family="Arial" font-size="18" fill="black">X</text>
                <text x="55" y="190" font-family="Arial" font-size="18" fill="black">R</text>
                <text x="125" y="190" font-family="Arial" font-size="18" fill="black">R/2</text>
                <text x="265" y="190" font-family="Arial" font-size="18" fill="black">R/2</text>
                <text x="335" y="190" font-family="Arial" font-size="18" fill="black">R</text>
                <text x="210" y="55" font-family="Arial" font-size="18" fill="black">R</text>
                <text x="210" y="125" font-family="Arial" font-size="18" fill="black">R/2</text>
                <text x="210" y="265" font-family="Arial" font-size="18" fill="black">R/2</text>
                <text x="210" y="335" font-family="Arial" font-size="18" fill="black">R</text>
            </svg>
        </div>
    </div>
    <div class="item">
        <form id="form1">
            <h3 style="border: 2px solid black; border-radius: 5px;"> Ввод значений </h3>
            <div id="X-Value">
                <h3> Введите X </h3>
                <label>
                    <input type="checkbox" name="x-value" value="-4"> -4
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="-3"> -3
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="-2"> -2
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="-1"> -1
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="0" > 0
                </label><br>
                <label>
                    <input type="checkbox" name="x-value" value="1" > 1
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="2" > 2
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="3" > 3
                </label>
                <label>
                    <input type="checkbox" name="x-value" value="4" > 4
                </label>
                <div id="error-message-x" style="color: red;"></div>
            </div>
            <label for="Y-value">
                <h3> Введите Y </h3>
                <input id="y-value" type="text">
            </label>
            <div id="error-message-y" style="color: red;"></div>
            <div id="R-value">
                <h3> Выберите R </h3>
                <label>
                    <input type="checkbox" name="r-value" value="1"> 1
                </label>
                <label>
                    <input type="checkbox" name="r-value" value="1.5"> 1.5
                </label>
                <label>
                    <input type="checkbox" name="r-value" value="2"> 2
                </label>
                <label>
                    <input type="checkbox" name="r-value" value="2.5"> 2.5
                </label>
                <label>
                    <input type="checkbox" name="r-value" value="3" > 3
                </label>
            </div>
            <div id="error-message-r" style="color: red;"></div>
            <button id="getButton" type="submit">Проверить</button>
        </form>
    </div>
</div>
<footer>
    <%
        String serializedRequests = request.getParameter("requests");
        List<String[]> requestDetails = new ArrayList<>();
        List<String[]> points = new ArrayList<>();
        if (serializedRequests != null && !serializedRequests.isEmpty()) {
            List<String> requests = Arrays.asList(serializedRequests.split(";"));
            for (String requestData : requests) {
                String[] parts = requestData.split(",");
                String[] parts1 = new String[6];
                for (int i=0; i<parts1.length; i++) {
                    String[] keyValue = parts[i].split("=");
                    parts1[i] = keyValue[1];
                }
                requestDetails.add(parts1);
                String[] point = {parts1[0],parts1[1],parts1[2],parts1[3]};
                points.add(point);
            }
        }
    %>
    <table id="table_results">
        <tr>
            <th><h4>X</h4></th>
            <th><h4>Y</h4></th>
            <th><h4>R</h4></th>
            <th><h4>Ответ</h4></th>
            <th><h4>Время выполнения (наносекунды)</h4></th>
            <th><h4>Время на сервере</h4></th>
        </tr>
        <%
            for(int i=requestDetails.size()-1; i>-1; i--){
                String[] details = requestDetails.get(i);
                if (details.length == 6) {
        %>
        <tr>
            <td><%= details[0] %></td>
            <td><%= details[1] %></td>
            <td><%= details[2] %></td>
            <td style="color: <%= "hit".equals(details[3]) ? "green" : "red" %>;"><%= details[3] %></td>
            <td><%= details[4] %></td>
            <td><%= details[5] %></td>
        </tr>
        <%
            }
            }
        %>
    </table>
</footer>
    <script src = "my-script-lab2.js" charset="UTF-8" type="text/javascript"></script>
<script>
    const points1 = [
        <% for (String[] point : points) { %>
        { x: <%= point[0] %>, y: <%= point[1] %>, r: <%= point[2] %>, result: "<%= point[3] %>"},
        <% } %>
    ];
    console.log("Полученные точки:");
    rValueCurrent = points1[points1.length-1].r;
    for (let i=0; i<points1.length;i++){
        let point = points1[i];
        if (i<points1.length-1) {
            doPoint(point.x, point.y, rValueCurrent, point.result, false);
        }else{
            doPoint(point.x, point.y, rValueCurrent, point.result, true);
        }
    }
</script>
</body>
</html>
