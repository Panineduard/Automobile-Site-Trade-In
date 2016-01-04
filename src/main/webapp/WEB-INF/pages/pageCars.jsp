<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 02.01.16
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Результат поиска </title>
</head>
<body>
<%
  List<Car> cars= (List<Car>) request.getAttribute("cars");


for (Car car:cars){
  String path=car.getPhotoPath().get(0);
%>
<p><div><img width="300" height="200" src="/getPhoto?pathPhoto=<%=path%> ">;
  <p><h2>Марка - <%=car.getBrand()%></h2>
    <p><h2>Модель - <%=car.getModel()%></h2>
    <p><h2>Описание - <%=car.getDescription()%></h2>


<%
    }
    %>
</body>
</html>
