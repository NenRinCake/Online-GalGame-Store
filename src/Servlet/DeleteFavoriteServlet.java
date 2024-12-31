package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Object.*;

@WebServlet(name="DeleteFavoriteServlet",urlPatterns = "/DeleteFavoriteServlet")
public class DeleteFavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String username = (String) req.getSession().getAttribute("userName");
        String name = req.getParameter("name");
        String note = req.getParameter("note");
        String path = req.getParameter("path");

        String sql1 = "delete from favorite where userName = '" + username + "' and name = '" + name + "'";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = GetConnection.getConnection();
            ps = conn.prepareStatement(sql1);
            ps.executeUpdate();
            req.setAttribute("Msg", "已取消收藏");
            req.getRequestDispatcher("/Favorite.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }


}
