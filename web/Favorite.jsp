<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 03:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page import="Object.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的收藏</title>
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

        .card {
            font-family: '华康方圆体W7', Arial, sans-serif;
            background-color: rgb(255, 255, 255, 0.6); /* 更改卡片的背景颜色 */
            margin-bottom: 20px;
            margin-right: 10px;
            transition: transform 0.3s ease-out !important;
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
        table.animate-table {
            transform: translateX(+100%); /* 将表格放在左侧 */
        }
        /* 动画效果 - 表格移动到正确位置 */
        @keyframes slideFromLeft {
            from {
                transform: translateX(+100%);
            }
            to {
                transform: translateX(0);
            }
        }
        table.animate-table {
            animation: slideFromLeft 1s forwards;
        }
    </style>

    <script>
        // 检查是否存在 Msg 属性值，并显示为弹窗
        window.onload = function() {
            var Msg = '<%= request.getAttribute("Msg") %>';
            if (Msg && Msg.trim() !== '' && Msg.trim() !== 'null') {
                alert(Msg);
            }

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

<%
    String username = (String) session.getAttribute("userName");
    int cardCount = 0;
    int cnt = 0;
    Favorite[] favorites = null;
    try{
        favorites = FavoriteServlet.favoriteGoods(username);
        cardCount = favorites.length;
    }catch (Exception e){
        e.printStackTrace();
    }

%>

<table class="animate-table">


    <% for (int i = 0; i < cardCount; i++) { %>
    <tr>
        <%-- 动态生成列 --%>
        <% for (int j = 0; j < 1; j++) { %>
        <td>
            <div class="card" style="position: relative; width: 1500px; height: 300px;">
                <img src="<%= favorites[cnt].getPath() %>" class="card-img-left" alt="..." style="width: 38%; height: 100%; position: absolute; left: 0; top: 0;">
                <div class="card-body" style="width: 60%; position: absolute; right: 0; top: 0;">
                    <h5 class="card-title"><%= favorites[cnt].getName() %></h5>
                    <p class="card-text"><%= favorites[cnt].getNote() %></p>
                </div>
                <div>
                    <form action="DeleteFavoriteServlet" method="post">
                        <input type="hidden" name="name" value="<%= favorites[cnt].getName() %>">
                        <input type="hidden" name="note" value="<%= favorites[cnt].getNote() %>">
                        <input type="hidden" name="path" value="<%= favorites[cnt].getPath() %>">
                        <button type="submit" class="btn btn-primary" style="position: absolute; bottom: 10px; right: 10px;">取消收藏</button>
                    </form>
                    <form action="BuyServlet" method="post">
                        <input type="hidden" name="name" value="<%= favorites[cnt].getName() %>">
                        <input type="hidden" name="note" value="<%= favorites[cnt].getNote() %>">
                        <input type="hidden" name="path" value="<%= favorites[cnt].getPath() %>">
                        <input type="hidden" name="cost" value="-1">
                        <button type="submit" class="btn btn-primary" style="position: absolute; bottom: 10px; right: 150px;">点此购买 </button>
                    </form>
                </div>
            </div>

        </td>
        <%  cnt++;%>
        <% } %>
        <%-- 这里确保内部循环结束后，结束表格的行 --%>
    </tr>
    <% } %>
</table>

</body>
</html>