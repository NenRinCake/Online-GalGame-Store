package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import Object.*;

@WebServlet(name = "FavoriteListServlet", urlPatterns = "/FavoriteListServlet")
public class FavoriteListServlet {

    public static Favorite[] favorites( ) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Favorite[] favoriteArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM favorite"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM favorite";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            ArrayList<Favorite> favoriteList = new ArrayList<>();
            while (rs.next()) {
                Favorite favorite = new Favorite();
                favorite.setUserName(rs.getString("userName"));
                favorite.setName(rs.getString("name"));

                favoriteList.add(favorite);
            }

            // 将 FavoriteList 转换为数组
            favoriteArray = new Favorite[count];
            favoriteArray = favoriteList.toArray(favoriteArray);

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
        return favoriteArray;
    }

    public static F[] getFavoriteNum() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<F> favoritesList = new ArrayList<>();

        try {
            conn = GetConnection.getConnection();
            String sql = "SELECT name, COUNT(*) as count FROM favorite GROUP BY name";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                int count = rs.getInt("count");
                F favorite = new F(name, count);
                favoritesList.add(favorite);
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

        return favoritesList.toArray(new F[0]);
    }

}

