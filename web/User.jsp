<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 03:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="Object.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <link rel="icon" href="Picture/NenRinCake.PNG" type="image/x-icon">
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

        table {
            font-family: '华康方圆体W7', Arial, sans-serif;
            border-collapse: collapse;
            width: 1000px;
            height: 800px; /* 设置表格高度 */
            margin: 50px auto 0;
            font-size: 30px; /* 设置表格中文字大小 */
            table-layout: fixed; /* 固定表格布局 */
            background-color: rgba(255, 255, 255, 0.4);
            letter-spacing: 3px;
            margin-top: 20px;
        }
        table, th, td {
            border: 5px solid rgba(230, 230, 230, 0.6); /* 设定默认表格线并设置透明度 */
            text-align: center; /* 将单元格中的文字居中显示 */
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
        th, td {
            padding: 8px;
            height: 80px;
        }
        img {
            width: 160px;
            height: 160px;
            border-radius: 50%;
        }
        button {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 30px; /* 设置按钮中文字大小 */
            background: radial-gradient(circle, rgba(128, 128, 128, 0.8), rgba(256, 256, 256, 0.8)); /* 径向渐变色背景并半透明 */
            border-radius: 8px;
            padding: 15px 25px; /* 设置按钮的内边距 */
            margin: 0 50px;
        }

        .modal {
            font-family: '华康方圆体W7', Arial, sans-serif;
            display: none; /* 初始时隐藏模态框 */
            position: fixed; /* 将模态框固定在屏幕上 */
            top: 30%;
            left: 40%;
            transform: translate(-200%, -200%);
            background-color: rgba(0, 0, 0, 0.5);
            width: 350px;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            z-index: 1000;
            letter-spacing: 2px;
            animation: modalAppear 0.5s forwards; /* 初始时模态框从右向左出现 */
        }
        .modal-closed {
            animation: modalDisappear 0.5s forwards; /* 模态框从左向右消失 */
        }
        .modal-content input {
            font-family: '华康方圆体W7', Arial, sans-serif;
            width: calc(100% - 22px);
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            font-size: 30px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            letter-spacing: 2px;
        }
        .modal-content input[type="submit"] {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
        }
        .modal-content input[id="exit"] {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
            text-align: center;
        }
        .modal-content input[id="exit1"] {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
            text-align: center;
        }
        /* 模态框出现动画效果 */
        @keyframes modalAppear {
            from {
                transform: translateX(300%);
            }
            to {
                transform: translateX(0);
            }
        }

        /* 模态框消失动画效果 */
        @keyframes modalDisappear {
            from {
                transform: translateX(0%);
            }
            to {
                transform: translateX(300%);
            }
        }

    </style>

    <script>
        window.onload = function() {
            var failMsg = '<%= request.getAttribute("failMsg") %>';
            var failMsg1 = '<%= request.getAttribute("failMsg1") %>'
            if (failMsg && failMsg.trim() !== '' && failMsg.trim() !== 'null') {
                alert(failMsg);
            }
            if (failMsg1 && failMsg1.trim() !== '' && failMsg1.trim() !== 'null') {
                alert(failMsg1);
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

<table class="animate-table">

    <%
        // 假设 username 是从某处获取到的用户名
        String username = (String) session.getAttribute("userName");
        User user = null;

        try {
            // 调用 Servlet 的 login 方法获取 User 对象
            user = UserServlet.login(username);
        } catch (Exception e) {
            e.printStackTrace();
        }

    %>

    <tr>
        <td rowspan="2"><img src="Picture/NenRinCake.PNG" alt="Avatar"></td>
        <th colspan="2">用户名</th>
    </tr>
    <tr>
        <td colspan="2"><%= user.getUserName() %></td>
    </tr>
    <tr>
        <th>性别</th>
        <td id="gender" colspan="2" style="height: 40px;"><%= user.getGender() %></td>
    </tr>
    <tr>
        <th>联系方式</th>
        <td id="phone" colspan="2" class="hide-digits" style="height: 40px;"><%= user.getPhone() %></td>
    </tr>
    <tr>
        <th>收货地址</th>
        <td id="address" colspan="2" style="height: 40px;"><%= user.getAddress() %></td>
    </tr>
    <tr>
        <th>积分余额</th>
        <td colspan="2" style="height: 40px;"><%= user.getScore() %></td>
    </tr>
    <tr>
        <td class="button-cell" colspan="3">
            <button onclick="openModal()">修改信息</button>
            <button onclick="openModal1()">修改密码</button>
            <button onclick="logout()">登出账号</button>
        </td>
    </tr>


</table>

<div id="myModal" class="modal">
    <div class="modal-content">
        <form action="UserChangeServlet" onsubmit="return updateInfo()">
            <input type="text" name="newGender" placeholder="性别" required>
            <input type="text" name="newPhone" placeholder="联系方式" required>
            <input type="text" name="newAddress" placeholder="收货地址" required>
            <input type="submit" value="确认修改">
            <input type="button" id="exit" onclick="closeModal()" value="退出">
        </form>
    </div>
</div>

<div id="myModal1" class="modal">
    <div class="modal-content">
        <form action="PasswordChangeServlet" onsubmit="return updateInfo()">
            <input type="text" name="oldPassword" placeholder="旧密码" required>
            <input type="text" name="newPassword" placeholder="新密码" required>
            <input type="text" name="samePassword" placeholder="再次输入新密码" required>
            <input type="submit" value="确认修改">
            <input type="button" id="exit1" onclick="closeModal1()" value="退出">
        </form>
    </div>
</div>

<script>

    function logout() {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/LogoutServlet", true);
        xhr.send();
        window.location.href = "Login&Register.jsp";
    }

    function openModal() {
        var modal = document.getElementById('myModal');
        modal.classList.remove('modal-closed'); // 移除消失动画类名
        modal.style.display = 'block'; // 显示模态框
    }

    function openModal1() {
        var modal = document.getElementById('myModal1');
        modal.classList.remove('modal-closed'); // 移除消失动画类名
        modal.style.display = 'block'; // 显示模态框
    }

    function closeModal() {
        var modal = document.getElementById('myModal');
        modal.classList.add('modal-closed'); // 添加消失动画类名
        // 等待动画结束后隐藏模态框
        setTimeout(function () {
            modal.style.display = 'none';
        }, 500); // 等待消失动画时间
    }

    function closeModal1() {
        var modal = document.getElementById('myModal1');
        modal.classList.add('modal-closed'); // 添加消失动画类名
        // 等待动画结束后隐藏模态框
        setTimeout(function () {
            modal.style.display = 'none';
        }, 500); // 等待消失动画时间
    }

</script>

</body>
</html>