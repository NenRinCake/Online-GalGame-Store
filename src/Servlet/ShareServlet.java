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

@WebServlet(name = "ShareServlet",urlPatterns = "/ShareServlet")
public class ShareServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String username = (String) req.getSession().getAttribute("userName");
        String name = req.getParameter("name");
        String time = req.getParameter("time");
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 格式化当前时间以显示秒数
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String nowTime = currentDateTime.format(formatter);

        String sql1 = "insert into message (userName, note, time, `like`) values ('" + username + "','【用户分享】 我在 " + time + " 时购买了 " + name + "','" + nowTime + "',0)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = GetConnection.getConnection();
            ps = conn.prepareStatement(sql1);
            ps.executeUpdate();
            req.setAttribute("Msg", "分享成功，具体细节请到社区下查看");
            req.getRequestDispatcher("/Bought.jsp").forward(req, resp);


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
