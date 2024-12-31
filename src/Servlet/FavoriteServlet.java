package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Object.*;

@WebServlet(name = "FavoriteServlet", urlPatterns = "/FavoriteServlet")
public class FavoriteServlet {

    public static Favorite[] favoriteGoods(String userName) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Favorite[] favoriteArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM favorite where userName = '" + userName + "'"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM favorite where userName = '" + userName + "'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            ArrayList<Favorite> favoriteList = new ArrayList<>();
            while (rs.next()) {
                Favorite favorite = new Favorite();
                favorite.setUserName(rs.getString("userName"));
                favorite.setName(rs.getString("name"));
                favorite.setNote(rs.getString("note"));
                favorite.setPath(rs.getString("path"));
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

}
