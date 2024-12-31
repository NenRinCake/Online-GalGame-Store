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
import Object.*;

@WebServlet(name = "LoginServlet",urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if(username.equals("NenRinCake") && password.equals("0721")){
            req.getRequestDispatcher("/AdminTable.jsp").forward(req, resp);
            return ;
        }


        String sql1 = "select userName,password from user where userName = '" + username + "' and password = '" + password + "'";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = GetConnection.getConnection();
            ps = con.prepareStatement(sql1);
            rs = ps.executeQuery();
            if(rs.next()){
                String exist = (String) req.getSession().getAttribute("userName");
                if(exist != null){
                    req.setAttribute("failMsg1", "当前已有用户在使用");
                    req.getRequestDispatcher("/Login&Register.jsp").forward(req, resp);
                }else{
                    req.getSession().setAttribute("userName", username);
                    req.getRequestDispatcher("/Loading.jsp").forward(req, resp);
                }
            }
            else{
                req.setAttribute("failMsg", "用户名或者密码错误");
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
