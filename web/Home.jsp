<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 02:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="icon" href="Picture/NenRinCake.PNG" type="image/x-icon">
    <style>
        *{
            list-style: none;
            padding: 0;
            margin: 0;
            text-decoration: none;
        }
        body{
            opacity: 0; /* 页面初始状态为不可见 */
            transition: opacity 0.5s ease-in-out; /* 使用过渡效果 */
            display: grid;
            grid-template-rows: auto 1fr;
            justify-content: center;
            margin-top: 10px;
            height: 80vh;
            background-image: url('Picture/backgound.jpg'); /* 更改图片路径 */
            background-size: cover; /* 以覆盖方式填充整个屏幕 */
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

        .image-slider {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px; /* 可根据需要调整上边距 */
        }
        .image-slider img {
            width: 1500px;
            height: 850px;
            object-fit: cover;
            position: absolute;
            top: 130px;
            margin: 0 auto;
            opacity: 0;
            transition: opacity 2s ease-in-out, box-shadow 0.3s ease-in-out; /* 添加阴影的过渡效果 */
            box-shadow: 1px 5px 15px rgba(0, 0, 0, 0.5); /* 阴影效果 */
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
<br>
<div class="image-slider">
    <img src="Picture/hot1.png" alt="Image 1" onclick="goToPage()">
    <img src="Picture/hot2.png" alt="Image 2" onclick="goToPage()">
    <img src="Picture/hot3.png" alt="Image 3" onclick="goToPage()">
    <img src="Picture/hot4.png" alt="Image 4" onclick="goToPage()">
    <img src="Picture/hot5.png" alt="Image 5" onclick="goToPage()">
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const images = document.querySelectorAll('.image-slider img');
        let index = 4;

        // 设置页面加载时第一张图片显示
        images[index].style.opacity = '1';

        setInterval(() => {
            images[index].style.opacity = '0';

            index++;
            if (index === images.length) {
                index = 0;
            }

            images[index].style.opacity = '1';
        }, 5000);

    });

    function goToPage() {
        window.location.href = 'Hot.jsp'; // 跳转至指定页面
    }

</script>
</body>
</html>