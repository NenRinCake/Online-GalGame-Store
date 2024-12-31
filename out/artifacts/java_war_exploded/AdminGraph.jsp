<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2023.12.20
  Time: 下午 07:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Servlet.*" %>
<%@ page import="Object.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理员</title>
    <link rel="icon" href="Picture/NenRinCake.PNG" type="image/x-icon">
    <!-- 引入 Chart.js 库 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: rgb(200, 200, 200);
        }

        button {
            font-family: Arial, sans-serif;
            font-size: 30px; /* 设置按钮中文字大小 */
            background: radial-gradient(circle, rgba(128, 128, 128, 0.8), rgba(256, 256, 256, 0.8)); /* 径向渐变色背景并半透明 */
            border-radius: 8px;
            padding: 15px 25px; /* 设置按钮的内边距 */
            margin: 20px 50px;
        }

        #pieChartContainer {
            width: 500px; /* 设置容器宽度 */
            margin: 0 auto; /* 实现水平居中 */
        }

    </style>

</head>
<body>

<%
    int goodCount = 0;
    Goods[] goods = null;
    try{
        goods = GoodsListServlet.retrieveGoods();
        goodCount = goods.length;
        if(goodCount > 10){
            goodCount = 10;
        }
    }catch (Exception e){
        e.printStackTrace();
    }

    // 创建用于存储横坐标和纵坐标数据的数组
    String[] labels = new String[goodCount];
    int[] sellNums = new int[goodCount];

    // 填充标签和数据数组
    for (int i = 0; i < goodCount; i++) {
        labels[i] = goods[i].getName();
        sellNums[i] = goods[i].getSellNum();
    }

    // 将 Java 数组数据转换为 JavaScript 变量
    StringBuilder labelBuilder = new StringBuilder("[");
    StringBuilder sellNumBuilder = new StringBuilder("[");
    for (int i = 0; i < goodCount; i++) {
        labelBuilder.append("'").append(labels[i]).append("'");
        sellNumBuilder.append(sellNums[i]);
        if (i < goodCount - 1) {
            labelBuilder.append(",");
            sellNumBuilder.append(",");
        }
    }
    labelBuilder.append("]");
    sellNumBuilder.append("]");

    String labelsJS = labelBuilder.toString();
    String sellNumsJS = sellNumBuilder.toString();
%>

<%
    // 这里是模拟数据，请根据实际情况使用你的购买记录数组
    Bought[] boughts = null;
    try {
        boughts = BoughtListServlet.boughtGoods();
    } catch (Exception e) {
        throw new RuntimeException(e);
    }

    // 调用统计购买量的方法，得到每分钟的购买量数组
    TimeAndNum[] minuteSales1 = BoughtListServlet.getMinuteSales(boughts);

    // 创建用于存储横坐标和纵坐标数据的数组
    String[] labels1 = new String[minuteSales1.length];
    int[] salesData1 = new int[minuteSales1.length];

    // 填充标签和数据数组
    for (int i = 0; i < 12; i++) {
        labels1[i] = minuteSales1[i].getTime().toString(); // 使用时间戳作为标签，你可以根据需要格式化输出
        salesData1[i] = minuteSales1[i].getNum();
    }

    // 将 Java 数组数据转换为 JavaScript 变量
    StringBuilder labelBuilder1 = new StringBuilder("[");
    StringBuilder salesDataBuilder1 = new StringBuilder("[");
    for (int i = 0; i < 12; i++) {
        labelBuilder1.append("'").append(labels1[i]).append("'");
        salesDataBuilder1.append(salesData1[i]);
        if (i < 12 - 1) {
            labelBuilder1.append(",");
            salesDataBuilder1.append(",");
        }
    }
    labelBuilder1.append("]");
    salesDataBuilder1.append("]");

    String labelsJS1 = labelBuilder1.toString();
    String salesDataJS1 = salesDataBuilder1.toString();
%>

<%
    int favoriteCount = 0;
    F[] favorites = null;
    try {
        favorites = FavoriteListServlet.getFavoriteNum();
        favoriteCount = favorites.length;
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 创建用于存储横坐标和纵坐标数据的数组
    String[] labels2 = new String[favoriteCount];
    int[] favoriteNums = new int[favoriteCount];

    // 填充标签和数据数组
    for (int i = 0; i < favoriteCount; i++) {
        labels2[i] = favorites[i].getName();
        favoriteNums[i] = favorites[i].getCount(); // 假设有获取收藏数量的方法 getFavoriteNum()
    }

    // 将 Java 数组数据转换为 JavaScript 变量
    StringBuilder labelBuilder2 = new StringBuilder("[");
    StringBuilder favoriteNumBuilder2 = new StringBuilder("[");
    for (int i = 0; i < favoriteCount; i++) {
        labelBuilder2.append("'").append(labels2[i]).append("'");
        favoriteNumBuilder2.append(favoriteNums[i]);
        if (i < favoriteCount - 1) {
            labelBuilder2.append(",");
            favoriteNumBuilder2.append(",");
        }
    }
    labelBuilder2.append("]");
    favoriteNumBuilder2.append("]");

    String labelsJS2 = labelBuilder2.toString();
    String favoriteNumsJS2 = favoriteNumBuilder2.toString();
%>

<%
    Consume[] consumes = null;
    try {
        consumes = ConsumeServlet.consumers();
    } catch (Exception e) {
        throw new RuntimeException(e);
    }

    // 计算男性和女性用户的平均消费
    double maleAverage = consumes[0].getScore() / consumes[0].getGenderNum();
    double femaleAverage = consumes[1].getScore() / consumes[1].getGenderNum();
%>

<div style="width: 1600px; height: 600px;">
    <canvas id="myBarChart" width="1600" height="300"></canvas>
    <canvas id="favoriteChart" width="1600" height="300"></canvas>
    <canvas id="myLineChart" width="1600" height="300"></canvas>
    <div id="pieChartContainer" style="text-align: center;"> <!-- 新增的 div 容器 -->
        <canvas id="pieChart" width="500" height="500"></canvas> <!-- 将扇形图放置在新的 div 内 -->
    </div>
    <div style="display: flex; justify-content: center; margin-top: 20px;">
        <button onclick="redirectToTable()">切换至表</button>
    </div>
</div>

<script>
    // 数据
    var data = {
        labels: <%= labelsJS %>,
        datasets: [{
            label: "购买量",
            backgroundColor: 'rgb(102,204,255,0.7)',
            borderColor: 'rgba(54, 162, 235, 1)',
            data: <%= sellNumsJS %> // 填充数据
        }]
    };

    // 配置项
    var options = {
        indexAxis: 'y', // 将横坐标标签横向显示
        scales: {
            x: {
                beginAtZero: true
            }
        }
    };

    // 获取 canvas 元素
    var ctx = document.getElementById('myBarChart').getContext('2d');

    // 创建条形图
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
    });

    var ctx1 = document.getElementById('myLineChart').getContext('2d');

    var myChart1 = new Chart(ctx1, {
        type: 'line',
        data: {
            labels: <%= labelsJS1 %>,
            datasets: [{
                label: '购买量',
                data: <%= salesDataJS1 %>,
                borderColor: 'rgb(102,204,255,0.8)',
                backgroundColor: 'transparent',
                pointRadius: 5,
                pointHoverRadius: 8,
                pointBackgroundColor: 'rgba(54, 162, 235, 0.8)',
                pointHoverBackgroundColor: 'rgba(54, 162, 235, 1)'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                x: {
                    display: true,
                    title: {
                        display: true,
                        text: '时间'
                    }
                },
                y: {
                    display: true,
                    title: {
                        display: true,
                        text: '购买量'
                    },
                    beginAtZero: true
                }
            }
        }
    });

    var data3 = {
        labels: <%= labelsJS2 %>,
        datasets: [{
            label: "收藏数量",
            backgroundColor: 'rgb(102,204,255,0.7)',
            borderColor: 'rgba(54, 162, 235, 1)',
            data: <%= favoriteNumsJS2 %> // 填充数据
        }]
    };

    // 配置项
    var options3 = {
        indexAxis: 'y', // 将横坐标标签横向显示
        scales: {
            x: {
                beginAtZero: true
            }
        }
    };

    // 获取 canvas 元素
    var ctx3 = document.getElementById('favoriteChart').getContext('2d');

    // 创建条形图
    var myChart3 = new Chart(ctx3, {
        type: 'bar',
        data: data3,
        options: options3
    });

    var maleAverage = <%= maleAverage %>;
    var femaleAverage = <%= femaleAverage %>;

    // 获取画布元素
    var ctx = document.getElementById('pieChart').getContext('2d');

    // 创建扇形图并设置 3D 效果
    var myPieChart = new Chart(ctx, {
        type: 'doughnut', // 使用圆环图 (doughnut) 类型
        data: {
            labels: ['男性', '女性'],
            datasets: [{
                data: [maleAverage, femaleAverage],
                backgroundColor: [
                    'rgb(102,204,255,0.8)',
                    'rgba(255, 99, 132, 0.5)',
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 99, 132, 1)',
                ],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                doughnutlabel: {
                    labels: [{
                        text: '平均消费',
                        font: {
                            size: '20'
                        }
                    }]
                },
                legend: {
                    display: true,
                    position: 'bottom'
                },
                title: {
                    display: true,
                    text: '用户平均消费'
                },
                animation: {
                    animateScale: true,
                    animateRotate: true
                }
            }
        }
    });

    function redirectToTable() {
        // 使用 window.location.href 进行页面跳转
        window.location.href = 'AdminTable.jsp';
    }

</script>
</body>
</html>
