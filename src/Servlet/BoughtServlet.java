package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import Object.*;

@WebServlet(name = "BoughtServlet", urlPatterns = "/BoughtServlet")
public class BoughtServlet {

    public static Bought[] boughtGoods(String userName) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Bought[] boughtArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM bought where userName = '" + userName + "'"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM bought where userName = '" + userName + "'";
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

}

