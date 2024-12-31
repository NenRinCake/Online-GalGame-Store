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

@WebServlet(name = "GoodDeleteServlet",urlPatterns = "/GoodDeleteServlet")
public class GoodDeleteServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String name = req.getParameter("name");
        if(name!=null){
            String sql1 = "delete from goods where name = '" + name + "'";
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
