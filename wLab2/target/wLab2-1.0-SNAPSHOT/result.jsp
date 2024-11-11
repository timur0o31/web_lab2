<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<String> requests = (List<String>)  application.getAttribute("requests");
    request.setAttribute("requests", requests);
    String serializedRequests = String.join(";",requests);
%>

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
   <div class="flex-container" style="height: 200px;margin:175px">
       <div class="item">
           <div class="table-title"><h3>Результат</h3></div>
            <table id="table_results">
        <tr>
            <th><h4 >X</h4></th>
            <th><h4 >Y</h4></th>
            <th><h4 >R</h4></th>
            <th><h4 >Ответ</h4></th>
        </tr>
        <tr>
            <%
                String result = (String) request.getAttribute("result");
                if ("error".equals(result)) {
            %>
            <td colspan="6" style="color: #9900ff;">ОШИБКА</td>
            <%
            } else {
            %>
            <td><h4><%= request.getAttribute("x") %></h4></td>
            <td><h4><%= request.getAttribute("y") %></h4></td>
            <td><h4><%= request.getAttribute("r") %></h4></td>
            <td style="color: <%= "hit".equals(result) ? "green" : "red" %>;">
                <h4><%= result %></h4>
            </td>
            <%
                }
            %>
            </tr>
    </table>
   </div>
   </div>
    <footer style="display: flex;border-radius: 10px; margin:0px 20px; border: 2px solid black; justify-content: center; align-items: center; height: 50px; background-color: #e0e0e0;">
        <a href="index.jsp?requests=<%= URLEncoder.encode(serializedRequests,"UTF-8")%>" style="color:black; font-size:30px">Вернуться к форме</a>
    </footer>
</body>
</html>