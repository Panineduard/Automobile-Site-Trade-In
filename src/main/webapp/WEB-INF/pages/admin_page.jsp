<%@ page import="java.util.List" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.helpers.EncoderId" %>
<%--
  Created by IntelliJ IDEA.
  User: volkswagen1
  Date: 14.02.2016
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
  <meta charset="UTF-8" />
  <title>2016-02-13 1st - js do it</title>
  <meta name="Description" content="" />
  <meta name="Keywords"  content="" />

  <link rel="stylesheet" type="text/css" media="screen,print" href="/res/css/style_admin_page.css" />
</head>

<body>


<li><a  href="/update_dealers_list">Обновить список диллеров</a></li>
<br>

  <table>
    <caption>Диллеры:</caption>
    <tr>
      <th class="number">№пп</th>
      <th><button>От</button></th>
      <th>Диллер</th>
      <th>Номер Диллера</th>
      <th>Количество автомобилей</th>
      <th>Действия</th>
    </tr>
    <%
      List<Dealer>dealers=(List<Dealer>) request.getAttribute("dealers");
      if(dealers!=null){
        int count=1;
       for (Dealer dealer:dealers){
      %>
    <tr>
      <td><%=count%></td>
      <td>
        <input type="checkbox">
      </td>
      <td><%=dealer.getNameDealer()%></td>
      <td><%=dealer.getNumberDealer()%></td>
      <td><%=dealer.getCountOfCar()%></td>
      <td>
        <p>
          <form action="/deleteDealer" method="post">
          <input type="hidden" name="idDealer" value="<%=EncoderId.encodId(dealer.getNumberDealer())%>">
          <button type="submit">Удалить</button>
           </form>
        <form action="/" method="post">
          <input type="hidden" name="idDealer" value="<%=EncoderId.encodId(dealer.getNumberDealer())%>">
          <button type="submit">Блокировать</button>
        </form>


        </p>

      </td>
    </tr>
    <%
       count++; }
    }%>
  </table>
<form action="/addDealerNumber" method="post">
  <p>Дбавить номер диллера для доступа к сайту
    <br>
    <input name="dealer_name" type="text" size="10">
    <input type="submit" value="Отправить">
  </p>
</form>
</body>



</html>