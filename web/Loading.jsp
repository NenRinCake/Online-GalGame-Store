<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.23
  Time: 下午 09:46
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
        /* 加载页面样式 */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #ffffff; /* 设置背景颜色 */
        }

        /* 自定义加载动画容器 */
        .loader-container {
            text-align: center;
        }

        /* 调整GIF图像大小 */
        .custom-gif {
            width: 500px; /* 设置GIF图像宽度 */
            height: auto; /* 自适应高度 */
        }

        /* 加载文字的样式 */
        .loading-text {
            font-family: '华康方圆体W7', Arial, sans-serif;
            font-size: 35px; /* 设置加载文字的大小 */
            letter-spacing: 6px; /* 设置加载文字的间距 */
        }

        /* 三个点的动画效果 */
        .loading-dots::after {
            content: ' .'; /* 初始显示一个点 */
            animation: loadingDots 1s infinite; /* 使用loadingDots动画，1秒间隔，无限循环 */
        }

        @keyframes loadingDots {
            0% {
                content: ' .';
            }
            33% {
                content: ' ..';
            }
            66% {
                content: ' ...';
            }
        }
    </style>
</head>
<body>
<div class="loader-container">
    <img class="custom-gif" src="Picture/loading.gif" alt="Custom GIF">
    <p class="loading-text">Loading<span class="loading-dots"></span></p>
</div>

<script>
    // 模拟加载延迟，这里设置为3秒
    setTimeout(function() {
        // 加载完成后，跳转到目标网页，比如 "Home.jsp"
        window.location.href = "Home.jsp";
    }, 3000); // 3000毫秒 = 3秒
</script>
</body>
</html>