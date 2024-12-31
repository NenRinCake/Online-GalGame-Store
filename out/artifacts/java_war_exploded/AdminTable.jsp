<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.20
  Time: 下午 07:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page import="Object.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员</title>
    <link rel="icon" href="Picture/NenRinCake.PNG" type="image/x-icon">
    <link rel="stylesheet" href="bootstrap.css">
    <style>
        body {
            background-color: rgb(200, 200, 200);
            opacity: 0; /* 页面初始状态为不可见 */
            transition: opacity 0.3s ease-in-out; /* 使用过渡效果 */
        }
        .loaded {
            opacity: 1; /* 页面加载后变为可见 */
        }
        .scrollable-table {
            height: 400px; /* 设置容器的固定高度 */
            width: 700px;
            overflow-y: auto; /* 添加垂直滚动条 */
        }

        button {
            font-family: Arial, sans-serif;
            font-size: 30px; /* 设置按钮中文字大小 */
            background: radial-gradient(circle, rgba(128, 128, 128, 0.8), rgba(256, 256, 256, 0.8)); /* 径向渐变色背景并半透明 */
            border-radius: 8px;
            padding: 15px 25px; /* 设置按钮的内边距 */
            margin: 0 50px;
        }

        .modal {
            font-family: Arial, sans-serif;
            display: none; /* 初始时隐藏模态框 */
            position: fixed; /* 将模态框固定在屏幕上 */
            top: 25%;
            left: 30%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.5);
            width: 600px;
            height:470px;
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
        .modal2 {
            font-family: Arial, sans-serif;
            display: none; /* 初始时隐藏模态框 */
            position: fixed; /* 将模态框固定在屏幕上 */
            top: 30%;
            left: 30%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.5);
            width: 600px;
            height:300px;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            z-index: 1000;
            letter-spacing: 2px;
            animation: modalAppear 0.5s forwards; /* 初始时模态框从右向左出现 */
        }
        .modal2-closed {
            animation: modalDisappear 0.5s forwards; /* 模态框从左向右消失 */
        }
        .modal-content input {
            font-family: Arial, sans-serif;
            width: calc(100% - 22px);
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            font-size: 30px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            letter-spacing: 2px;
        }
        .modal-content {
            background-color: rgba(0, 0, 0, 0);
        }
        .modal-content input[type="submit"] {
            font-family: Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
        }
        .modal-content input[id="exit"] {
            font-family: Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
            text-align: center;
        }
        .modal-content input[id="exit1"] {
            font-family: Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
            text-align: center;
        }
        .modal-content input[id="exit2"] {
            font-family: Arial, sans-serif;
            font-size: 30px;
            background: radial-gradient(circle, rgba(79, 172, 254, 0.8), rgba(0, 242, 254, 0.8)); /* 径向渐变色背景并半透明 */
            color: #fff;
            cursor: pointer;
            text-align: center;
        }

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

        .scrollable-table {
            height: 400px; /* 设置容器的固定高度 */
            width: 700px;
            overflow-y: auto; /* 添加垂直滚动条 */
        }

        .table {
            color: rgb(2, 72, 147); /* 设置表格文字颜色 */
            background-color: rgb(102,204,255,0.5); /* 设置表格背景颜色 */
            border-collapse: collapse; /* 合并边框 */
            border: 2px solid rgba(54, 162, 235, 1); /* 设置表格边框 */
        }
        .table th {
            background-color: rgb(102,204,255,0.5); /* 设置表头背景颜色 */
            border-color: rgba(54, 162, 235, 0.7); /* 设置表头边框颜色 */
            color: rgb(2, 72, 147);
        }
        th, td {
            border: 2px solid rgba(54, 162, 235, 1); /* 设置单元格边框 */
            padding: 8px; /* 设置单元格内边距 */
            text-align: left; /* 文字左对齐 */
        }

        /* WebKit（Chrome、Safari）浏览器 */
        .scrollable-table::-webkit-scrollbar {
            width: 12px; /* 设置滚动条宽度 */
        }
        /* 轨道 */
        .scrollable-table::-webkit-scrollbar-track {
            border-radius: 10px; /* 设置滚动条轨道的圆角 */
            background-color: rgb(102,204,255,0.5); /* 设置滚动条轨道的背景色 */
        }
        /* 滑块 */
        .scrollable-table::-webkit-scrollbar-thumb {
            border-radius: 10px; /* 设置滚动条滑块的圆角 */
            background-color: rgba(54, 162, 235, 0.7); /* 设置滚动条滑块的背景色 */
        }

    </style>

    <script>
        // 检查是否存在 failMsg 属性值，并显示为弹窗
        window.onload = function() {
            setTimeout(function() {
                document.body.classList.add('loaded');
            }, 100);
        };
    </script>
</head>
<body>
<div style="display: flex; justify-content: center;" >

        <%
                    int goodCount = 0;
                    int cnt1 = 0;
                    Goods[] goods = null;
                    try{
                        goods = GoodsListServlet.retrieveGoods();
                        goodCount = goods.length;
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                %>
    <div class="scrollable-table" style="position: absolute; top: 0; left: 100px;">
        <table class="table" style="border: 2px solid black;">
            <thead>
            <tr>
                <th colspan="4" scope="col" style="text-align: center;">商品列表</th>
            </tr>
            <tr>
                <th scope="col">name</th>
                <th scope="col">price</th>
                <th scope="col">sellNum</th>
                <th scope="col">discount</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <% for (int i = 0; i < goodCount; i++) { %>
            <tr>
                <td><%= goods[cnt1].getName()%></td>
                <td><%= goods[cnt1].getPrices()%></td>
                <td><%= goods[cnt1].getSellNum()%></td>
                <td><%= goods[cnt1].getDiscount()%></td>
            </tr>
            <%  cnt1++;%>
            <% } %>
            </tbody>
        </table>
    </div>

        <%
                    int boughtCount = 0;
                    int cnt2 = 0;
                    Bought[] boughts = null;
                    try{
                        boughts = BoughtListServlet.boughtGoods();
                        boughtCount = boughts.length;
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                %>
    <div class="scrollable-table" style="position: absolute; top: 440px; left: 100px;">
        <table class="table" style="border: 2px solid black;">
            <thead>
            <tr>
                <th colspan="4" scope="col" style="text-align: center;">已购列表</th>
            </tr>
            <tr>
                <th scope="col">UserName</th>
                <th scope="col">name</th>
                <th scope="col">time</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <% for (int i = 0; i < boughtCount; i++) { %>
            <tr>
                <td><%= boughts[cnt2].getUserName()%></td>
                <td><%= boughts[cnt2].getName()%></td>
                <td><%= boughts[cnt2].getTime()%></td>
            </tr>
            <%  cnt2++;%>
            <% } %>
            </tbody>
        </table>
    </div>

        <%
                    int userCount = 0;
                    int cnt3 = 0;
                    User[] users = null;
                    try{
                        users = UserListServlet.users();
                        userCount = users.length;
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                %>
    <div class="scrollable-table" style="position: absolute; top: 0; left: 850px;">
        <table class="table" style="border: 2px solid black;">
            <thead>
            <tr>
                <th colspan="5" scope="col" style="text-align: center;">用户列表</th>
            </tr>
            <tr>
                <th scope="col">UserName</th>
                <th scope="col">gender</th>
                <th scope="col">phone</th>
                <th scope="col">address</th>
                <th scope="col">score</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <% for (int i = 0; i < userCount; i++) { %>
            <tr>
                <td><%= users[cnt3].getUserName()%></td>
                <td><%= users[cnt3].getGender()%></td>
                <td><%= users[cnt3].getPhone()%></td>
                <td><%= users[cnt3].getAddress()%></td>
                <td><%= users[cnt3].getScore()%></td>
            </tr>
            <%  cnt3++;%>
            <% } %>
            </tbody>
        </table>
    </div>

        <%
                    int favoriteCount = 0;
                    int cnt4 = 0;
                    Favorite[] favorites = null;
                    try{
                        favorites = FavoriteListServlet.favorites();
                        favoriteCount = favorites.length;
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                %>
    <div class="scrollable-table" style="position: absolute; top: 440px; left: 850px;">
        <table class="table" style="border: 2px solid black;">
            <thead>
            <tr>
                <th colspan="4" scope="col" style="text-align: center;">收藏列表</th>
            </tr>
            <tr>
                <th scope="col">UserName</th>
                <th scope="col">name</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <% for (int i = 0; i < favoriteCount; i++) { %>
            <tr>
                <td><%= favorites[cnt4].getUserName()%></td>
                <td><%= favorites[cnt4].getName()%></td>
            </tr>
            <%  cnt4++;%>
            <% } %>
            </tbody>
        </table>
    </div>


    <div style="display: flex; justify-content: center; margin-top: 860px;">
        <button onclick="openModal()">修改</button>
        <button onclick="openModal1()">上架</button>
        <button onclick="openModal2()">下架</button>
        <button onclick="redirectToGraphPage()">切换至图</button>
    </div>

    <div id="myModal" class="modal">
        <div class="modal-content">
            <form action="GoodChangeServlet" onsubmit="return updateInfo()">
                <input type="text" name="name" placeholder="名称" required>
                <input type="text" name="price" placeholder="价格" required>
                <input type="text" name="discount" placeholder="折扣" required>
                <input type="submit" value="确认修改">
                <input type="button" id="exit" onclick="closeModal()" value="退出">
            </form>
        </div>
    </div>

    <div id="myModal1" class="modal">
        <div class="modal-content">
            <form action="GoodAddServlet" onsubmit="return updateInfo()">
                <input type="text" name="name" placeholder="名称" required>
                <input type="text" name="price" placeholder="价格" required>
                <input type="text" name="discount" placeholder="折扣" required>
                <input type="submit" value="确认上架">
                <input type="button" id="exit1" onclick="closeModal1()" value="退出">
            </form>
        </div>
    </div>

    <div id="myModal2" class="modal2">
        <div class="modal-content">
            <form action="GoodDeleteServlet" onsubmit="return updateInfo()">
                <input type="text" name="name" placeholder="名称" required>
                <input type="submit" value="确认下架">
                <input type="button" id="exit2" onclick="closeModal2()" value="退出">
            </form>
        </div>
    </div>

    <script>

        function redirectToGraphPage() {
            // 使用 window.location.href 进行页面跳转
            window.location.href = 'AdminGraph.jsp';
        }
        function openModal() {
            var modal = document.getElementById('myModal');
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
        function openModal1() {
            var modal = document.getElementById('myModal1');
            modal.classList.remove('modal-closed'); // 移除消失动画类名
            modal.style.display = 'block'; // 显示模态框
        }
        function closeModal1() {
            var modal = document.getElementById('myModal1');
            modal.classList.add('modal-closed'); // 添加消失动画类名
            // 等待动画结束后隐藏模态框
            setTimeout(function () {
                modal.style.display = 'none';
            }, 500); // 等待消失动画时间
        }
        function openModal2() {
            var modal1 = document.getElementById('myModal2');
            modal1.classList.remove('modal2-closed'); // 移除消失动画类名
            modal1.style.display = 'block'; // 显示模态框
        }
        function closeModal2() {
            var modal1 = document.getElementById('myModal2');
            modal1.classList.add('modal2-closed'); // 添加消失动画类名
            // 等待动画结束后隐藏模态框
            setTimeout(function () {
                modal1.style.display = 'none';
            }, 500); // 等待消失动画时间
        }
    </script>

</body>
</html>
