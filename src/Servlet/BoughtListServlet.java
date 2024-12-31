package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import Object.*;

@WebServlet(name = "BoughtListServlet", urlPatterns = "/BoughtListServlet")
public class BoughtListServlet {

    public static Bought[] boughtGoods( ) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Bought[] boughtArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM bought"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM bought ORDER BY time ASC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            ArrayList<Bought> boughtList = new ArrayList<>();
            while (rs.next()) {
                Bought bought = new Bought();
                bought.setUserName(rs.getString("userName"));
                bought.setName(rs.getString("name"));
                bought.setNote(rs.getString("note"));
                bought.setPath(rs.getString("path"));
                bought.setTime(rs.getTimestamp("time"));

                boughtList.add(bought);
            }

            // 将 FavoriteList 转换为数组
            boughtArray = new Bought[count];
            boughtArray = boughtList.toArray(boughtArray);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return boughtArray;
    }

    public static TimeAndNum[] getMinuteSales(Bought[] boughts) {
        // 创建一个 HashMap 来存储每分钟的购买量
        Map<Timestamp, Integer> minuteSalesMap = new HashMap<>();

        // 遍历 Bought 数组并统计每分钟的购买量
        for (Bought bought : boughts) {
            Timestamp timestamp = bought.getTime();

            // 取出每分钟的时间戳，忽略秒和毫秒的部分
            Timestamp minuteTimestamp = getMinuteTimestamp(timestamp);

            // 更新每分钟的购买量
            minuteSalesMap.put(minuteTimestamp, minuteSalesMap.getOrDefault(minuteTimestamp, 0) + 1);
        }

        // 将 HashMap 转换为数组
        TimeAndNum[] minuteSalesArray = new TimeAndNum[minuteSalesMap.size()];
        int index = 0;
        for (Map.Entry<Timestamp, Integer> entry : minuteSalesMap.entrySet()) {
            TimeAndNum timeAndNum = new TimeAndNum(entry.getValue(),entry.getKey());
            minuteSalesArray[index++] = timeAndNum;
        }

        Arrays.sort(minuteSalesArray, Collections.reverseOrder());

        return minuteSalesArray;
    }

    // 辅助方法：获取每分钟的时间戳
    private static Timestamp getMinuteTimestamp(Timestamp timestamp) {
        LocalDateTime localDateTime = timestamp.toLocalDateTime();
        localDateTime = localDateTime.withSecond(0).withNano(0);
        return Timestamp.valueOf(localDateTime);
    }

}

