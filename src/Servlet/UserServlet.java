package Servlet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Object.*;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;

@WebServlet(name="UserServlet",urlPatterns = "/UserServlet")
public class UserServlet {
    public static User login(String username) throws Exception{
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = GetConnection.getConnection();
            String sql = "SELECT * FROM user_inf WHERE userName = '" + username + "'";
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserName(rs.getString("userName"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setScore(rs.getInt("score"));
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
        return user;
    }
}
