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

@WebServlet(name = "GoodChangeServlet",urlPatterns = "/GoodChangeServlet")
public class GoodChangeServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String name = req.getParameter("name");
        String price = req.getParameter("price");
        String discount = req.getParameter("discount");
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 格式化当前时间以显示秒数
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String time = currentDateTime.format(formatter);



        double num = Double.parseDouble(discount);



        if(name!=null && price!=null && discount!= null){
            String sql1 = "update goods set prices = '" + price + "',discount = '" + discount + "' where name = '" + name + "'";
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                con = GetConnection.getConnection();
                ps = con.prepareStatement(sql1);
                ps.executeUpdate();
                if(num < 1) {
                    String sql = "insert into message (userName, note, time, `like`) values ('NenRinCake','【折扣通知】 购物商城里有新的折扣商品','" + time + "',0)";
                    try {
                        ps = con.prepareStatement(sql);
                        ps.executeUpdate();
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                }

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
