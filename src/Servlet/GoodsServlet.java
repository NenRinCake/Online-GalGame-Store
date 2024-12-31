package Servlet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Object.Goods;

import javax.servlet.annotation.WebServlet;

@WebServlet(name = "GoodsServlet", urlPatterns = "/GoodsServlet")
public class GoodsServlet {
    public static Goods[] retrieveGoods() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Goods[] goodsArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM goods"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM goods";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            ArrayList<Goods> goodsList = new ArrayList<>();
            while (rs.next()) {
                Goods goods = new Goods();
                goods.setName(rs.getString("name"));
                goods.setPrices(rs.getInt("prices"));
                goods.setSellNum(rs.getInt("sellNum"));
                goods.setNote(rs.getString("note"));
                goods.setPath(rs.getString("path"));
                goods.setDiscount(rs.getDouble("discount"));
                goodsList.add(goods);
            }

            // 将 ArrayList 转换为数组
            goodsArray = new Goods[count];
            goodsArray = goodsList.toArray(goodsArray);

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
        return goodsArray;
    }

}
