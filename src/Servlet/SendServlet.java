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

@WebServlet(name = "SendServlet",urlPatterns = "/SendServlet")
public class SendServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String username = (String) req.getSession().getAttribute("userName");
        String input = req.getParameter("search-input");
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 格式化当前时间以显示秒数
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String time = currentDateTime.format(formatter);

        if(input.equals("")){
            req.setAttribute("failMsg", "不要发送空消息");
            req.getRequestDispatcher("/Community.jsp").forward(req, resp);
            return ;
        }

        String sql1 = "insert into message (userName, note, time, `like`) values ('" + username + "','" + input + "','" + time + "',0)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = GetConnection.getConnection();
            ps = conn.prepareStatement(sql1);
            ps.executeUpdate();

            req.getRequestDispatcher("/Community.jsp").forward(req, resp);


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
