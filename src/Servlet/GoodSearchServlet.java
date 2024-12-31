package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Object.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name="GoodSearchServlet",urlPatterns = "/GoodSearchServlet")
public class GoodSearchServlet extends HttpServlet {
    public static Goods[] goodsRearch = null;
    public static String search = null;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        search = req.getParameter("search-input");
        HttpSession session = req.getSession();
        session.setAttribute("searchValue", search);
        try {
            goodsRearch = rearchGoods(search);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        req.getRequestDispatcher("/Search.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

    public static Goods[] rearchGoods(String search) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Goods[] goodsArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM goods WHERE name LIKE '%" + search + "%'"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM goods WHERE name LIKE '%" + search + "%'";
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
