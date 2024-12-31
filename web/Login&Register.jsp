<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.18
  Time: 下午 02:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录 & 注册</title>
    <link rel="icon" href="Picture/NenRinCake.PNG" type="image/x-icon">
    <style>
        /* CSS 样式 */
        body {
            font-family: '华康方圆体W7', Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('Picture/Koishi.jpg'); /* 更改图片路径 */
            background-size: cover; /* 以覆盖方式填充整个屏幕 */
            background-position: center; /* 居中显示 */
        }
        .container {
            text-align: center;
        }
        form {
            background-color: rgba(255, 255, 255, 0.6); /* 背景半透明 */
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        h2 {
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            font-family: '华康方圆体W7', Arial, sans-serif; /* 设置字体 */
            width: calc(100% - 22px);
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            letter-spacing: 2px;
        }
        input[type="submit"] {
            font-family: '华康方圆体W7', Arial, sans-serif; /* 设置字体 */
            font-size: 15px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
        }
        p {
            margin-top: 15px;
            font-size: 16px;
        }
        p a {
            color: #66ccff;
            text-decoration: none;
        }
        p a:hover {
            text-decoration: underline;
        }
        .hidden {
            display: none;
        }
        .activeForm {
            background: linear-gradient(to bottom, rgba(34, 232, 12, 0.4), rgba(255, 255, 255, 0.6)); /* 垂直渐变色背景 */
        }
        #loginForm {
            backdrop-filter: blur(1px);
        }
        #registerForm {
            backdrop-filter: blur(1px);
            background: linear-gradient(to bottom, rgba(34, 232, 12, 0.4), rgba(255, 255, 255, 0.6)); /* 垂直渐变色背景 */
        }
        .toggleFormLink {
            font-size: 16px;
        }

        form {
            transition: all 0.3s ease-in-out; /* 添加过渡动画 */
        }
        form:hover {
            transform: scale(1.05); /* 放大表单 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* 添加阴影 */
        }

        #panel {
            position: fixed;
            right: -400px; /* 隐藏面板，初始时不可见 */
            top: 72%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 5px;
            transition: right 0.3s ease-in-out; /* 添加过渡动画 */
            width: 330px;
            height: 20px;
            display: flex; justify-content: center; align-items: center; text-align: center;
        }
        #panel p {
            letter-spacing: 2px; /* 设置字间距为 2 像素 */
        }
        #panel1 {
            position: fixed;
            left: -400px; /* 初始隐藏，从左侧移出 */
            top: 28%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 5px;
            transition: left 0.3s ease-in-out; /* 添加过渡动画 */
            width: 330px;
            height: 20px;
            display: flex; justify-content: center; align-items: center; text-align: center;
        }
        #panel1 p {
            letter-spacing: 2px; /* 设置字间距为 2 像素 */
        }

    </style>

    <script>
        // 检查是否存在 failMsg 属性值，并显示为弹窗
        window.onload = function() {
            var failMsg = '<%= request.getAttribute("failMsg") %>';
            var failMsg1 = '<%= request.getAttribute("failMsg1") %>';
            var Msg = '<%= request.getAttribute("Msg") %>'
            if (failMsg && failMsg.trim() !== '' && failMsg.trim() !== 'null') {
                alert(failMsg);
            }
            if (Msg && Msg.trim() !== '' && Msg.trim() !== 'null') {
                alert(Msg);
            }
            if (failMsg1 && failMsg1.trim() !== '' && failMsg1.trim() !== 'null') {
                alert(failMsg1);
            }
        };
    </script>

</head>
<body>

<div id="panel">
    <!-- 面板内容 -->
    <p>Copyright &copy; 2023 NenRinCake.</p>
</div>

<div id="panel1">
    <!-- 面板内容 -->
    <p>致力成为最好的GalGame游戏网站</p>
</div>

<div class="container">
    <!-- 登录表单 -->
    <form action="LoginServlet" class="activeForm" id="loginForm" method="post">
        <h2>登录</h2>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="登录">
        <p>没有账号? <a href="#" class="toggleFormLink">在此注册</a></p>
    </form>

    <!-- 注册表单 -->
    <form action="RegisterServlet" class="hidden" id="registerForm" method="post">
        <h2>注册</h2>
        <input type="text" name="newUsername" placeholder="Username" required>
        <input type="password" name="newPassword" placeholder="Password" required>
        <input type="submit" value="注册">
        <p>已有帐号? <a href="#" class="toggleFormLink">在此登录</a></p>
    </form>
</div>

<script>
    // 获取所有带有 toggleFormLink 类名的链接
    var toggleFormLinks = document.querySelectorAll('.toggleFormLink');
    // 对每个链接添加点击事件监听器
    toggleFormLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault(); // 阻止默认行为

            // 获取当前链接所在的父表单
            var parentForm = this.closest('form');

            // 获取相邻的表单（登录表单或注册表单）
            var siblingForm = parentForm.nextElementSibling || parentForm.previousElementSibling;

            // 隐藏当前表单，显示相邻的表单
            parentForm.classList.add('hidden');
            siblingForm.classList.remove('hidden');
        });
    });

    var panel = document.getElementById('panel');
    var forms = document.querySelectorAll('form');

    forms.forEach(function(form) {
        form.addEventListener('mouseover', function() {
            panel.style.right = '630px'; // 当鼠标移动到 form 上时，面板从右侧移到登录和注册面板上方
        });

        form.addEventListener('mouseout', function() {
            panel.style.right = '-630px'; // 鼠标移出时，面板移回右侧
        });
    });

    var panel1 = document.getElementById('panel1');

    forms.forEach(function(form) {
        form.addEventListener('mouseover', function() {
            panel1.style.left = '630px'; // 当鼠标移动到 form 上时，面板从右侧移到登录和注册面板上方
        });

        form.addEventListener('mouseout', function() {
            panel1.style.left = '-630px'; // 鼠标移出时，面板移回左侧
        });
    });

</script>

</body>
</html>