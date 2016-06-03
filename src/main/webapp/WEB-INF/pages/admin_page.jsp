<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.modelClass.AuthorizedDealers" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="com.modelClass.Letter" %>
<%@ page import="com.setting.Setting" %>
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
  <link rel="shortcut icon" href="/res/img/favicon.ico"/>
  <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
  <script type="text/javascript" src="http://gc.kis.scr.kaspersky-labs.com/1B74BD89-2A22-4B93-B451-1C9E1052A0EC/main.js" charset="UTF-8"></script><script src="http://code.jquery.com/jquery-1.8.3.js"></script>
  <script>
    $(document).ready(function getRegions() {
      $.ajax({
        dataType: 'json',
        url: '/getBrands',
        success: function (jsondata) {
          for(var i=0;i<jsondata.length;i++){
            $('#id_make').append('<option value="'+jsondata[i].brand+'">'+jsondata[i].brand+' </option>');
          }

        }
      });
    });
    function chng3()
    {
      var files=$(".files3");
      if(files.val().substring(files.val().lastIndexOf('.')+1,files.val().length).toLowerCase()!='txt')
      {
        alert('Необходимо выбрать файл file.txt');
        var file=$( ".file3" );
        file.empty();
        file.append('<input type="file" class="files3" name="files[0]"  onChange="chng3()" > <br>')
      };}
    function chng2()
    {
      var files=$(".files2");
      if(files.val().substring(files.val().lastIndexOf('.')+1,files.val().length).toLowerCase()!='txt')
      {
        alert('Необходимо выбрать файл file.txt');
        var file=$( ".file2" );
        file.empty();
        file.append('<input type="file" class="files2" name="files[0]"  onChange="chng2()" > <br>')
      };}
    function chng1()
    {
      var files=$(".files1");
      if(files.val().substring(files.val().lastIndexOf('.')+1,files.val().length).toLowerCase()!='txt')
      {
        alert('Необходимо выбрать файл file.txt');
        var file=$( ".file1" );
        file.empty();
        file.append('<input type="file" class="files1" name="files[0]"  onChange="chng1()" > <br>')
      };}
    function chng()
    {
      var files=$(".files");
      if(files.val().substring(files.val().lastIndexOf('.')+1,files.val().length).toLowerCase()!='txt')
      {
        alert('Необходимо выбрать файл file.txt');
        var file=$( ".file" );
        file.empty();
        file.append('<input type="file" class="files" name="files[0]"  onChange="chng()" > <br>')
      };
    }
  </script>
  <meta charset="UTF-8" />
  <title>Панель администратора</title>
  <meta name="Description" content="" />
  <meta name="Keywords"  content="" />

  <link rel="stylesheet" type="text/css" media="screen,print" href="<%=Setting.getPath()%>/res/css/style_admin_page.css" />
</head>

<body>
<h2>${msg}</h2>
<br>
<li><a title="На главную" href="<%=Setting.getPath()%>/">На главную</a></li>
<li><a  href="<%=Setting.getPath()%>/update_dealers_list">Обновить список диллеров</a></li>
<li><a  href="<%=Setting.getPath()%>/sendEmailToOwnersOldCars">Отправить письма владельцам старых авто</a></li>

<li><a  href="<%=Setting.getPath()%>/update_authorized_dealers_list">Обновить список разрешонных диллеров</a></li>
<li><a  href="<%=Setting.getPath()%>/get_messages">Просмотр сообщений ошибки</a></li>

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
      EncoderId encoderId=new EncoderId();
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
          <form action="<%=Setting.getPath()%>/deleteDealer" method="post">
          <input type="hidden" name="idDealer" value="<%=encoderId.encodId(dealer.getNumberDealer())%>">
          <button type="submit">Удалить</button>
           </form>
        <form action="<%=Setting.getPath()%>/" method="post">
          <input type="hidden" name="idDealer" value="<%=encoderId.encodId(dealer.getNumberDealer())%>">
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
<table>
  <caption>Сообщения</caption>
  <tr>
    <th class="number">№пп</th>
    <th>Email</th>
    <th>Сообщение</th>
    <th>Действия</th>
  </tr>
  <%

    List<Letter>letters=(List<Letter>) request.getAttribute("messages");
    if(letters!=null){
      int count=1;
      for (Letter letter:letters){
  %>
  <tr>
    <td><%=count%></td>
    <td><%=letter.getEmail()%></td>
    <td><%=letter.getMassage()%></td>
    <td>
      <p>
      <form action="<%=Setting.getPath()%>/delete_message" method="get">
        <input type="hidden" name="id" value="<%=encoderId.encodId(letter.getId().toString())%>">
        <input type="hidden" name="all" value="null">
        <button type="submit">Удалить</button>
      </form>
      </p>

    </td>
  </tr>
  <%
        count++; }
    }%>
  <tr>
    <td>----</td>
    <td>----</td>
    <td>----</td>
    <td>
      <p>
      <form action="<%=Setting.getPath()+"/delete_message"%>" method="get">
        <input type="hidden" name="id" value="">
        <input type="hidden" name="all" value="<%=encoderId.encodId("all")%>">
        <button type="submit">Удалить все письма</button>
      </form>
      </p>

    </td>
  </tr>
</table>
<br><br>
<form:form action="/updateBrands" method="post" modelAttribute="uploadForm" enctype="multipart/form-data">
  Список марок
  <br>только *.txt<br>
  <tr>
    <td>
      <div  class="file3">
        <input type="file" class="files3"  name="files[0]"  onChange="chng3()" > <br>
      </div>
    </td>
  </tr>
  <input type="submit"  value="отправить " >
</form:form>
<p>Добавить/изменить список моделей</p>
<form:form action="/updateModelByBrand" method="post" modelAttribute="uploadForm" enctype="multipart/form-data">
  <p>МАРКА<br>
    <select id="id_make" class="form-control" name="Brand">
    </select><br>
    Новая модель:
    <br>только *.txt<br>
    <tr>
      <td>
        <div class="file" >
        <input type="file" class="files"  name="files[0]"  onChange="chng()" > <br>
        </div>
        </td>
      </tr>
    <input type="submit"  value="отправить " >
  </p>
</form:form>
<form:form action="/updateRegions" method="post" modelAttribute="uploadForm" enctype="multipart/form-data">
Регион
<br>только *.txt<br>
<tr>
  <td>
    <div  class="file1">
      <input type="file" class="files1"  name="files[0]"  onChange="chng1()" > <br>
    </div>
  </td>
</tr>
<input type="submit"  value="отправить " >
</form:form>
<form:form action="/updateYears" method="post" modelAttribute="uploadForm" enctype="multipart/form-data">
  Года
  <br>только *.txt<br>
  <tr>
    <td>
      <div  class="file2">
        <input type="file" class="files2"  name="files[0]"  onChange="chng2()" > <br>
      </div>
    </td>
  </tr>
  <input type="submit"  value="отправить " >
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
        <input type="hidden" name="idDealer" value="<%=encoderId.encodId(authorizedDealer.getDealer_number())%>">
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