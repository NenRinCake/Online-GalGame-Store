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

@WebServlet(name = "RegisterServlet",urlPatterns = "/RegisterServlet")
public class RegisterServlet extends HttpServlet  {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String newusername = req.getParameter("newUsername");
        String newpassword = req.getParameter("newPassword");

        String sql1 = "select userName from user where userName = '" + newusername + "'";
        String sql2 = "insert into user (userName,password,identify) values ('" + newusername + "','" + newpassword + "','user')";
        String sql3 = "insert into user_inf (userName, gender, phone, address, score) values ('" + newusername + "','null','null','null',0)";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = GetConnection.getConnection();
            ps = con.prepareStatement(sql1);
            rs = ps.executeQuery();
            if(rs.next()){
                req.setAttribute("failMsg", "用户名已存在");
                req.getRequestDispatcher("/Login&Register.jsp").forward(req, resp);
            }
            else{
                ps = con.prepareStatement(sql2);
                ps.executeUpdate();
                ps = con.prepareStatement(sql3);
                ps.executeUpdate();
                req.setAttribute("Msg", "注册成功");
                req.getRequestDispatcher("/Login&Register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        try {
            GetConnection.close(rs,ps,con);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

}
