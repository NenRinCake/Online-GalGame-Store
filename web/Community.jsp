<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 02:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page import="Object.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>社区</title>
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

        .scroll-area {
            overflow-y: auto; /* 允许垂直滚动 */
            height: 700px; /* 设置滚动区域的高度 */
            margin-top: 20px; /* 设置滚动区域与上方的间距 */
            padding: 10px; /* 可选的内边距 */
            background-color: rgba(255, 255, 255, 0.4);
            border-radius: 10px;
            flex-direction: column; /* 垂直布局 */
            align-items: center; /* 水平居中 */
        }

        .card {
            font-family: '华康方圆体W7', Arial, sans-serif;
            background-color: rgba(0, 0, 0, 0.6); /* 更改卡片的背景颜色 */
            margin-top: 20px;
            margin-left: 35px;
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
            width: 1330px;
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

        .like-button.search-button:hover {
            background-color: rgb(2, 72, 147); /* 更改为悬停时的深灰色 */
        }

        .search-button1 {
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
        .search-button1:hover {
            background-color: #0056b3; /* 更改为悬停时的背景颜色 */
        }

        .like-button.search-button1:hover {
            background-color: rgb(2, 72, 147); /* 更改为悬停时的深灰色 */
        }

        /* WebKit（Chrome、Safari）浏览器 */
        ::-webkit-scrollbar {
            width: 12px; /* 设置滚动条宽度 */
        }
        /* 轨道 */
        ::-webkit-scrollbar-track {
            border-radius: 10px; /* 设置滚动条轨道的圆角 */
            background-color: rgba(0, 0, 0, 0.1); /* 设置滚动条轨道的背景色 */
        }
        /* 滑块 */
        ::-webkit-scrollbar-thumb {
            border-radius: 10px; /* 设置滚动条滑块的圆角 */
            background-color: rgba(0, 0, 0, 0.5); /* 设置滚动条滑块的背景色 */
        }

        .panel {
            display: none;
            font-family: '华康方圆体W7', Arial, sans-serif;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 500px;
            padding: 20px;
            background-color: rgba(125, 125, 125, 0.7);
            border: 1px solid rgba(125, 125, 125, 0.7);
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 9999;
        }
        .panel-heading {
            font-size: 35px;
            margin-bottom: 10px;
            color: #ffffff;
            text-align: center;
        }
        .panel-content {
            font-size: 30px;
            line-height: 1.5;
            color: #ffffff;
        }
        #hitokoto {
            text-align: center; /* 居中显示 */
            margin-bottom: 10px;
        }
        #from {
            margin-left: 200px; /* 使 from 文字右对齐 */
        }

    </style>

    <script>
        // 检查是否存在 failMsg 属性值，并显示为弹窗
        window.onload = function() {
            var failMsg = '<%= request.getAttribute("failMsg") %>';
            if (failMsg && failMsg.trim() !== '' && failMsg.trim() !== 'null') {
                alert(failMsg);
            }

            // 获取滚动区域的 DOM 元素
            var scrollArea = document.querySelector('.scroll-area');

            // 将滚动条滚动到底部
            scrollArea.scrollTop = scrollArea.scrollHeight;

            setTimeout(function() {
                document.body.classList.add('loaded');
            }, 100);
        };

        let pressTimer;

        function startPress() {
            pressTimer = setTimeout(() => {
                // 在这里触发长按事件，可以做一些操作
                showPanel();
                // 你可以在这里执行需要的操作，比如跳转到Servlet
            }, 1000); // 1000毫秒（1秒）后执行操作
        }

        function stopPress() {
            clearTimeout(pressTimer);
            return false;
        }

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

<div id="panel" class="panel">
    <div class="panel-heading">Hitokoto</div>
    <div class="panel-content">
        <div id="hitokoto"></div>
        <div id="from"></div>
    </div>
</div>

<%
    String username = (String) session.getAttribute("userName");
    int cardCount = 0;
    int cnt = 0;
    Message[] messages = null;
    try{
        messages = CommunityServlet.community();
        cardCount = messages.length;
    }catch (Exception e){
        e.printStackTrace();
    }

%>

<div class="scroll-area">
    <!-- 这里是滚动栏的内容 -->
    <% for (int i = 0; i < cardCount; i++) { %>
        <%-- 动态生成列 --%>
        <% for (int j = 0; j < 1; j++) { %>
            <div class="card" style="position: relative; width: 1400px; height: 250px; color: white;">
                <img src="Picture/NenRinCake.PNG" class="card-img-left" alt="..." style="width: 150px; height: 150px; position: absolute; left: 0; top: 0; margin-left: 20px; margin-top: 20px;">
                <h5 class="card-title" style="position: absolute; width: 13%; text-align: center; bottom: 10px; font-size: 35px;"><%= messages[cnt].getUserName()%></h5>
                <div class="card-body" style="width: 87%; position: absolute; right: 0; top: 0;">
                    <p class="card-text" style="font-size: 30px;">
                        <%= messages[cnt].getNote()%>
                        <% if(messages[cnt].getUserName().equals("NenRinCake")) { %>
                        <a href="Shop.jsp"> 点此查看更多信息</a>
                        <% }else if(messages[cnt].getNote().startsWith("【用户分享】")) {%>
                        <a href="Shop.jsp"> 点此查看更多信息</a>
                        <% }%>
                    </p>
                </div>
                <form action="LikeServlet" method="post">
                    <input type="hidden" name="time" value="<%= messages[cnt].getTime() %>">
                    <button class="like-button search-button1" style="width: 250px;height: 45px; position: absolute; right: 500px; bottom: 10px; font-size: 20px; padding: 1px 1px;"><%= messages[cnt].getLike()%>人赞同了这条评论</button>
                </form>
                <div>
                    <p class="card-text" style="position: absolute; bottom: 10px; right: 20px; font-size: 30px;">发送时间: <%= messages[cnt].getTime()%></p>
                </div>
            </div>
        <%  cnt++;%>
        <% } %>
        <%-- 这里确保内部循环结束后，结束表格的行 --%>
    <% } %>

</div>

<div class="search-bar">
    <form action="SendServlet" method="post">
        <input type="text" class="search-input" name="search-input" placeholder="在这里发送你的想法">
        <button onmousedown="startPress()" onmouseup="return stopPress()" type="submit" class="search-button"><i class="fas fa-search" ></i>发送</button>
    </form>
</div>

<script>
    function getHitokoto() {

        fetch(`https://v1.hitokoto.cn/?c=k`)
            .then(response => response.json())
            .then(data => {
                document.getElementById('hitokoto').innerText = data.hitokoto;
                document.getElementById('from').innerText = ' —— ' + data.from;
                document.getElementById('panel').style.display = 'block'; // 当内容加载完成后显示面板

                setTimeout(function() {
                    document.getElementById('panel').style.display = 'none';
                }, 5000);
            })
            .catch(error => console.error('Error:', error));
    }

    function showPanel() {
        getHitokoto();
    }

    var toggleFormLinks = document.querySelectorAll('.search-button');
    // 对每个链接添加点击事件监听器
    toggleFormLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            const input = document.querySelector('input[name="search-input"]'); // 替换 "inputFieldName" 为你的输入框名称

            if (input.value.trim() === '') {
                e.preventDefault(); // 阻止默认行为
                // 这里可以添加其他操作，比如显示提示信息等
            }
        });
    });

</script>

</body>
</html>