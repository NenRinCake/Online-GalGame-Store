<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 03:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page import="Object.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>热销榜单</title>
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
            width: 480px;
            height: 400px;
            margin-bottom: 20px;
            margin-right: 20px;
            position: relative;
            perspective: 1000px; /* 添加透视效果，用于3D变换 */
        }
        .card-body {
            text-align: center; /* 文字居中 */
        }
        .card-body h5 {
            margin-top: 20px;
            font-size: 30px; /* 调整标题文字大小 */
        }
        .card-body p {
            font-size: 16px; /* 调整段落文字大小 */
        }
        .card-inner {
            width: 100%;
            height: 100%;
            position: absolute;
            transition: transform 1s;
            transform-style: preserve-3d; /* 保留3D变换效果 */
            backface-visibility: hidden; /* 隐藏反面 */
        }
        .front-face,
        .back-face {
            width: 100%;
            height: 100%;
            position: absolute;
            backface-visibility: hidden; /* 隐藏反面 */
        }
        /* 悬停时的效果 */
        .card:hover .card-inner {
            transform: rotateY(180deg);
        }
        /* 反面样式 */
        .back-face {
            transform: rotateY(180deg);
        }
        table {
            margin-left: auto;
            margin-right: auto;
            margin-top: 20px;
            border-spacing: 200px;
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

<%
    int goodCount = 0;
    Goods[] goods = null;
    try{
        goods = GoodsListServlet.retrieveGoods();
        goodCount = goods.length;
        if(goodCount > 6){
            goodCount = 6;
        }
    }catch (Exception e){
        e.printStackTrace();
    }

%>

<table>
    <tr>
        <td>
            <div class="card">
                <div class="card-inner">
                    <div class="front-face">
                        <!-- 正面内容 -->
                        <img src="<%= goods[0].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%= goods[0].getName()%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <div class="back-face">
                        <!-- 反面内容 -->
                        <img src="<%= goods[0].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"></h5>
                            <p class="card-text"><%= goods[0].getNote()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class="card">
                <div class="card-inner">
                    <div class="front-face">
                        <!-- 正面内容 -->
                        <img src="<%= goods[1].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%= goods[1].getName()%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <div class="back-face">
                        <!-- 反面内容 -->
                        <img src="<%= goods[1].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"></h5>
                            <p class="card-text"><%= goods[1].getNote()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class="card">
                <div class="card-inner">
                    <div class="front-face">
                        <!-- 正面内容 -->
                        <img src="<%= goods[2].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%= goods[2].getName()%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <div class="back-face">
                        <!-- 反面内容 -->
                        <img src="<%= goods[2].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"></h5>
                            <p class="card-text"><%= goods[2].getNote()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="card">
                <div class="card-inner">
                    <div class="front-face">
                        <!-- 正面内容 -->
                        <img src="<%= goods[3].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%= goods[3].getName()%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <div class="back-face">
                        <!-- 反面内容 -->
                        <img src="<%= goods[3].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"></h5>
                            <p class="card-text"><%= goods[3].getNote()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class="card">
                <div class="card-inner">
                    <div class="front-face">
                        <!-- 正面内容 -->
                        <img src="<%= goods[4].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%= goods[4].getName()%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <div class="back-face">
                        <!-- 反面内容 -->
                        <img src="<%= goods[4].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"></h5>
                            <p class="card-text"><%= goods[4].getNote()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class="card">
                <div class="card-inner">
                    <div class="front-face">
                        <!-- 正面内容 -->
                        <img src="<%= goods[5].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%= goods[5].getName()%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <div class="back-face">
                        <!-- 反面内容 -->
                        <img src="<%= goods[5].getPath()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"></h5>
                            <p class="card-text"><%= goods[5].getNote()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>

</body>
</html>
