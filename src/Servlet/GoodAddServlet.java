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

@WebServlet(name = "GoodAddServlet",urlPatterns = "/GoodAddServlet")
public class GoodAddServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String name = req.getParameter("name");
        String price = req.getParameter("price");
        String discount = req.getParameter("discount");
        if(name!=null && price!=null && discount!= null){
            String sql1 = "INSERT INTO goods (name, prices, sellNum, note, path, discount) VALUES ('" + name + "','" + price + "',0,'富强、民主、文明、和谐、自由、平等、公正、法治、爱国、敬业、诚信、友善','Picture/Koishi.jpg','" + discount + "')";
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                con = GetConnection.getConnection();
                ps = con.prepareStatement(sql1);
                ps.executeUpdate();
                req.getRequestDispatcher("/AdminTable.jsp").forward(req, resp);
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
