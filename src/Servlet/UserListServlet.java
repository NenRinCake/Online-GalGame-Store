package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import Object.*;

@WebServlet(name = "BoughtListServlet", urlPatterns = "/BoughtListServlet")
public class UserListServlet {

    public static User[] users( ) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User[] userArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM user_inf"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM user_inf";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            ArrayList<User> userList = new ArrayList<>();
            while (rs.next()) {
                User user = new User();
                user.setUserName(rs.getString("userName"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setScore(rs.getInt("score"));

                userList.add(user);
            }

            // 将 FavoriteList 转换为数组
            userArray = new User[count];
            userArray = userList.toArray(userArray);

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
        return userArray;
    }

}

