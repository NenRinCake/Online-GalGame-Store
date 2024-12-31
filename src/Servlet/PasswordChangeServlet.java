package Servlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "PasswordChangeServlet",urlPatterns = "/PasswordChangeServlet")
public class PasswordChangeServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String samePassword = req.getParameter("samePassword");
        if(oldPassword!=null && newPassword!=null && samePassword!= null){

            String sql = "select userName,password from user where userName = '" + req.getSession().getAttribute("userName") + "' and password = '" + oldPassword + "'";

            String sql1 = "update user set password = '" + newPassword + "' where userName = '" + req.getSession().getAttribute("userName") + "'" ;
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = GetConnection.getConnection();
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if(rs.next()){

                }else{
                    req.setAttribute("failMsg", "旧密码不正确");
                    req.getRequestDispatcher("/User.jsp").forward(req, resp);
                    return ;
                }
                if(newPassword.equals(samePassword)){
                }else{
                    req.setAttribute("failMsg1", "两次密码不一致");
                    req.getRequestDispatcher("/User.jsp").forward(req, resp);
                    return ;
                }
                ps = con.prepareStatement(sql1);
                ps.executeUpdate();
                req.getRequestDispatcher("/User.jsp").forward(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            try {
                GetConnection.close(rs,ps,con);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
}
