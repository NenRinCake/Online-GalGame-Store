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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import Object.*;

@WebServlet(name = "BuyServlet",urlPatterns = "/BuyServlet")
public class BuyServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String username = (String) req.getSession().getAttribute("userName");
        String name = req.getParameter("name");
        String note = req.getParameter("note");
        String path = req.getParameter("path");
        String cost = req.getParameter("cost");
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 格式化当前时间以显示秒数
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);

        if(cost.equals("-1")){
            cost = "20";
        }

        String sql1 = "insert into bought (userName, name, note, path, time) values ('" + username + "','" + name + "','" + note + "','" + path + "','" + formattedDateTime + "')";
        String sql2 = "UPDATE goods SET sellNum = sellNum + 1 WHERE name = '" + name + "'";
        String sql3 = "UPDATE user_inf SET score = score + " + cost + " WHERE userName = '" + username + "'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = GetConnection.getConnection();
            ps = conn.prepareStatement(sql1);
            ps.executeUpdate();
            ps = conn.prepareStatement(sql2);
            ps.executeUpdate();
            ps = conn.prepareStatement(sql3);
            ps.executeUpdate();

            req.setAttribute("Msg", "购买成功，具体细节请到已购商品下查看");
            req.getRequestDispatcher("/Shop.jsp").forward(req, resp);


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
        this.doPost(req, resp);
    }
}
