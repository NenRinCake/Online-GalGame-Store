<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 03:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page import="Object.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>搜索结果</title>
    <link rel="icon" href="Picture/NenRinCake.PNG" type="image/x-icon">
    <link rel="stylesheet" href="bootstrap.css">
    <style>
        *{
            list-style: none;
            padding: 0;
            margin: 0;
            text-decoration: none;
        }
        body{
            display: grid;
            grid-template-rows: auto 1fr;
            justify-content: center;
            margin-top: 10px;
            height: 80vh;
            background-image: url('Picture/backgound.jpg'); /* 更改图片路径 */
            background-size: cover; /* 以覆盖方式填充整个屏幕 */
            opacity: 0; /* 页面初始状态为不可见 */
            transition: opacity 0.5s ease-in-out; /* 使用过渡效果 */
        }
        .loaded {
            opacity: 1; /* 页面加载后变为可见 */
        }
        .nav{
            width: 1500px;
            height: 100px;
            position: relative;
            top: 0;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            background-color: rgb(102, 204, 255, 0.6);
        }
        .nav ul{
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            right: 5%;
        }
        .nav ul .nav-box{
            position: absolute;
            bottom: 0;
            left: 0;
            /* 如果导航栏就六个导航，那么每个导航的宽度都是整个导航
            的六分之一 */
            width: calc((100% / 8)*1);
            height: 10px;
            border-radius: 2px;
            transition: .5s;
        }
        .nav ul li{
            width: 100%;
            text-align: center;
        }
        .nav ul li a{
            color: rgb(255, 255, 255);
            font-family: '华康方圆体W7', Arial, sans-serif;
            text-decoration: none;
            font-size: 25px;
            display: block;
            width: 100%;
            height: 100%;
            line-height: 70px;
        }
        .nav ul li:first-child a {
            /* 设置第一个标签内部链接的样式（文字大小） */
            font-size: 30px; /* 例如，将字体大小设置为 24px */
            color: rgb(255, 255, 255);
            text-decoration: none;
            line-height: 1.5; /* 设置行高为字体大小的1.5倍，即1.5倍行距 */
            word-wrap: break-word;
            text-align: center;
        }
        .nav ul li:nth-child(2):hover~.nav-box{
            left: calc(100% / 8 *1);
            background-color: rgb(250, 190, 250);
        }
        .nav ul li:nth-child(3):hover~.nav-box{
            left: calc(100% / 8 *2);
            background-color: red;
        }
        .nav ul li:nth-child(4):hover~.nav-box{
            left: calc(100% / 8 *3);
            background-color: #d18df8;
        }
        .nav ul li:nth-child(5):hover~.nav-box{
            left: calc(100% / 8 *4);
            background-color: #ffb1b1;
        }
        .nav ul li:nth-child(6):hover~.nav-box{
            left: calc(100% / 8 *5);
            background-color: #8da1f8;
        }
        .nav ul li:nth-child(7):hover~.nav-box{
            left: calc(100% / 8 *6);
            background-color: #7df88e;
        }
        .nav ul li:nth-child(8):hover~.nav-box{
            left: calc(100% / 8 *7);
            background-color: rgba(12, 128, 254);
        }

        .search-bar {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 30px;
            display: flex;
            justify-content: center;
            margin-top: 20px;
            letter-spacing: 2px;
        }
        .search-input {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 25px;
            width: 1300px;
            height: 77px;
            padding: 8px 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
            outline: none;
            letter-spacing: 2px;
        }
        .search-button {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 25px;
            margin-left: 10px;
            padding: 8px 15px;
            border-radius: 5px;
            border: none;
            height: 77px;
            width: 137px;
            background-color: #007bff;
            color: #fff;
            transition: background-color 0.3s ease;
            cursor: pointer;
            outline: none;
            letter-spacing: 2px;
        }
        .search-button:hover {
            background-color: #0056b3; /* 更改为悬停时的背景颜色 */
        }

        .card {
            font-family: '华康方圆体W7', Arial, sans-serif;
            background-color: rgb(255, 255, 255, 0.6); /* 更改卡片的背景颜色 */
            margin-bottom: 20px;
            margin-right: 10px;
            transition: transform 0.3s ease-out !important;
        }
        .card-text {
            margin-top: 8px;
            font-size: 16px;
            line-height: 1.5;
        }
        .card:hover {
            transform: scale(1.05) !important;
            box-shadow: 0px 0px 15px 5px rgba(0, 0, 0, 0.3) !important; /* 添加阴影效果 */
        }
        table {
            margin-left: auto;
            margin-right: auto;
            margin-top: 20px;
            border-spacing: 200px;
        }

        .pagination li {
            background-color: rgb(255, 255, 255, 0.6);
            list-style: none;
            display: inline-block;
            border-radius: 5px; /* 圆角矩形的边框半径 */
            overflow: hidden; /* 使边角处显示为圆角 */
        }

    </style>

    <script>
        window.onload = function() {
            setTimeout(function() {
                document.body.classList.add('loaded');
            }, 100);
        };
    </script>
</head>
<body>
<div class="nav">
    <ul>
        <li><a href="#">凝新聚华<br>推向世界</a> </li>
        <li><a href="Home.jsp">首    页</a></li>
        <li><a href="Shop.jsp">购物商城</a></li>
        <li><a href="Hot.jsp">热销榜单</a></li>
        <li><a href="Favorite.jsp">我的收藏</a></li>
        <li><a href="Bought.jsp">已购商品</a></li>
        <li><a href="Community.jsp">社    区</a></li>
        <li><a href="User.jsp">个人中心</a></li>
        <div class="nav-box"></div>
    </ul>
</div>

<div class="search-bar">
    <form action="GoodSearchServlet" method="post">
        <input type="text" class="search-input" name="search-input" value="${sessionScope.searchValue}" placeholder="在这里输入您想要的商品...">
        <button class="search-button"><i class="fas fa-search"></i>搜索</button>
    </form>
</div>

<%
    int cardCount = 0;
    int cnt = 0;
    Goods[] goods = null;
    try{
        goods = GoodSearchServlet.goodsRearch;
        cardCount = goods.length;
    }catch (Exception e){
        e.printStackTrace();
    }

%>

<table>

    <% int rowCount = (cardCount + 2) / 3; %>
    <% DecimalFormat df = new DecimalFormat("#.0");%>
    <%-- 根据卡片数量计算行数和列数 --%>

    <% for (int i = 0; i < rowCount; i++) { %>
    <tr>
        <%-- 动态生成列 --%>
        <% for (int j = 0; j < 3; j++) { %>
        <% int cardIndex = i * 3 + j; %>
        <% if (cardIndex < cardCount) { %>
        <td>
            <div class="card" style="width: 480px; height: 540px">
                <img src="<%= goods[cnt].getPath() %>" class="card-img-top" alt="...">
                <div class="card-body">
                        <h5 class="card-title"><%= goods[cnt].getName() %>
                            <% if(goods[cnt].getDiscount() < 1) {%>
                            <span style="background-color: green; color: white; padding: 5px; border-radius: 5px;">折扣</span>
                            <% }%>
                        <p class="card-text"><%= goods[cnt].getNote() %></p>
                        <form action="BuyServlet" method="post">
                            <input type="hidden" name="name" value="<%= goods[cnt].getName() %>">
                            <input type="hidden" name="note" value="<%= goods[cnt].getNote() %>">
                            <input type="hidden" name="path" value="<%= goods[cnt].getPath() %>">
                            <input type="hidden" name="cost" value="<%= (int)(goods[cnt].getPrices()*goods[cnt].getDiscount()) %>">
                            <button type="submit" class="btn btn-primary" style="position: absolute; bottom: 10px; left: 10px;">点此购买 <%= df.format(goods[cnt].getPrices()*goods[cnt].getDiscount()) %>¥</button>
                        </form>
                        <form action="AddFavoriteServlet" method="post">
                            <input type="hidden" name="name" value="<%= goods[cnt].getName() %>">
                            <input type="hidden" name="note" value="<%= goods[cnt].getNote() %>">
                            <input type="hidden" name="path" value="<%= goods[cnt].getPath() %>">
                            <button type="submit" class="btn btn-primary" style="width: 130px; height: 38px; position: absolute; bottom: 10px; right: 10px;">加入收藏</button>
                        </form>
                </div>
            </div>
        </td>
        <% } else { %>

        <% } cnt++;%>
        <% } %>
        <%-- 这里确保内部循环结束后，结束表格的行 --%>
    </tr>
    <% } %>
</table>

</body>
</html>