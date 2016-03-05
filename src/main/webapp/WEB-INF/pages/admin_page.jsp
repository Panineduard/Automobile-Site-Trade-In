<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.modelClass.AuthorizedDealers" %>
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
  <script>
    function chng()
    {
      if(userfile.value.substring(userfile.value.lastIndexOf('.')+1,userfile.value.length).toLowerCase()!='txt')
      {
        alert('Необходимо выбрать файл file.txt');
        var usFile=document.getElementById('userfile');
        document.getElementById('file').removeChild(usFile);
        document.getElementById('file').outerHTML =  '<input type="file" id="userfile" name="files[0]"  onChange="chng()" > <br>';
      };
    }
  </script>
  <meta charset="UTF-8" />
  <title>Панель администратора</title>
  <meta name="Description" content="" />
  <meta name="Keywords"  content="" />

  <link rel="stylesheet" type="text/css" media="screen,print" href="/res/css/style_admin_page.css" />
</head>

<body>
<h2>${msg}</h2>
<br>
<li><a title="На главную" href="/">На главную</a></li>
<li><a  href="/update_dealers_list">Обновить список диллеров</a></li>
<li><a  href="/update_authorized_dealers_list">Обновить список разрешонных диллеров</a></li>

<br>

  <table>
    <caption>Дилеры:</caption>
    <tr>
      <th class="number">№пп</th>
      <th><button>От</button></th>
      <th>Дилер</th>
      <th>Номер Дилера</th>
      <th>Количество автомобилей</th>
      <th>Действия</th>
    </tr>
    <%
      List<Dealer>dealers=(List<Dealer>) request.getAttribute("dealers");
      if(dealers!=null){
        int count=1;
       outer:for (Dealer dealer:dealers){
         if(dealer.getNumberDealer().equals("administrator")){continue outer;}
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
<br><br><br>
<p>Добавить/изменить список моделей</p>
<form:form action="/updateModelByBrand" method="post" modelAttribute="uploadForm" enctype="multipart/form-data">
  <p>МАРКА<br>
    <select id="id_make1" class="form-control" name="Brand">
      <option value="" selected="selected">выберите марку</option>

      <option value="Acura">Acura </option>
      <option value="Alfa_Romeo">Alfa Romeo </option>
      <option value="Audi"class="cat-top">Audi </option>
      <option value="BMW"class="cat-top">BMW </option>
      <option value="Chevrolet"class="cat-top">Chevrolet</option>
      <option value="Citroen"class="cat-top">Citroen</option>
      <option value="Daewoo"class="cat-top">Daewoo</option>
      <option value="Fiat"class="cat-top">Fiat </option>
      <option value="Ford"class="cat-top">Ford </option>
      <option value="Honda"class="cat-top">Honda </option>
      <option value="Hyundai"class="cat-top">Hyundai </option>
      <option value="Infiniti"class="cat-top">Infiniti </option>
      <option value="KIA"class="cat-top">KIA </option>
      <option value="Mazda"class="cat-top">Mazda</option>
      <option value="Mercedes"class="cat-top">Mercedes</option>
      <option value="Mitsubishi"class="cat-top">Mitsubishi</option>
      <option value="Nissan"class="cat-top">Nissan</option>
      <option value="Opel"class="cat-top">Opel</option>
      <option value="Peugeot"class="cat-top">Peugeot</option>
      <option value="Porsche">Porsche </option>
      <option value="Renault"class="cat-top">Renault</option>
      <option value="Seat">Seat </option>
      <option value="Skoda"class="cat-top">Skoda </option>
      <option value="Subaru"class="cat-top">Subaru </option>
      <option value="Suzuki"class="cat-top">Suzuki </option>
      <option value="Toyota"class="cat-top">Toyota</option>
      <option value="Volkswagen"class="cat-top">Volkswagen</option>
      <option value="Volvo"class="cat-top">Volvo</option>
      <option value="ВАЗ"class="cat-top">ВАЗ </option>
      <option value="ГАЗ"class="cat-top">ГАЗ </option>
      <option value="ЗАЗ"class="cat-top">ЗАЗ </option>

    </select><br>
    Новая модель:
    <br>только *.txt<br>
    <tr>
      <td>
        <div id="file">
        <input type="file" id="userfile" name="files[0]"  onChange="chng()" > <br>
        </div>
        </td>
      </tr>
    <input type="submit"  value="отправить " >
  </p>
</form:form>
<br><br><br>
<table>
  <caption>Номера легальных дилеров:</caption>
  <tr>
    <th class="number">№пп</th>
    <th>Номер Диллера</th>
    <th>Действия</th>
  </tr>
  <%
    List<AuthorizedDealers>authorizedDealerses=(List<AuthorizedDealers>) request.getAttribute("authorized_dealers");
    if(authorizedDealerses!=null){
      for (AuthorizedDealers authorizedDealer :authorizedDealerses){
  %>
  <tr>
    <td><%=authorizedDealer.getId()%></td>
    <td><%=authorizedDealer.getDealer_number()%></td>
    <td>
      <p>
      <form action="/deleteAuthorizedDealer" method="post">
        <input type="hidden" name="idDealer" value="<%=EncoderId.encodId(authorizedDealer.getDealer_number())%>">
        <button type="submit">Удалить</button>
      </form>
      </p>

    </td>
  </tr>
  <% }
    }%>
</table>
<p>
<form action="/addDealerNumber" method="post">
  <p>Дбавить номер диллера для доступа к сайту
    <br>
    <input name="dealer_number" type="text" size="10">
    <input type="submit" value="Отправить">
  </p>
</form>
</p>
<form action="/deleteOldCars" method="post">
  <p>Удалить давно не обнавленные авто
    <br>
    <input name="month" type="text" placeholder="количество месяцев" pattern="^[ 0-9]+$" size="20">
    <input type="submit" value="Отправить">
  </p>
</form>
</body>



</html>