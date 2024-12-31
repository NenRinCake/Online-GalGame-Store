package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;
import Object.*;

@WebServlet(name = "ConsumeServlet", urlPatterns = "/ConsumeServlet")
public class ConsumeServlet {

    public static Consume[] consumers( ) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User[] userArray = null;
        Consume[] consumeArray = new Consume[2];
        consumeArray[0] = new Consume(0,0);
        consumeArray[1] = new Consume(0,0);

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM user_inf where gender = '男'"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            consumeArray[0].genderNum = rs.getInt(1); // 获取表中记录总数

            sqlCount = "SELECT COUNT(*) FROM user_inf where gender = '女'";
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            consumeArray[1].genderNum = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM user_inf where gender = '男'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                consumeArray[0].addScore(rs.getInt("score"));
            }

            sql = "SELECT * FROM user_inf where gender = '女'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                consumeArray[1].addScore(rs.getInt("score"));
            }

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
        return consumeArray;
    }

}

