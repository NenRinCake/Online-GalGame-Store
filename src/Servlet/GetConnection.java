package Servlet;

import java.sql.*;

public class GetConnection {

    public static Connection getConnection() throws Exception{
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/sys";
        String user = "root";
        String password = "0721"; // 修改为你的数据库密码
        Connection con = DriverManager.getConnection(url, user, password);
        Statement stmt = con.createStatement();

        try {
            stmt.executeUpdate("create database nrc");
        }
		catch(SQLException e) {
            //System.out.println(e);
        }
        stmt.close();
        con.close();
        url = "jdbc:mysql://localhost:3306/nrc";
        con = DriverManager.getConnection(url, user, password);
        return con;
    }

    public static void close(ResultSet res,PreparedStatement ps,Connection con) throws Exception{
        if(res!=null){
            res.close();
        }
        if(ps!=null){
            ps.close();
        }
        if(con!=null){
            con.close();
        }
    }

}
