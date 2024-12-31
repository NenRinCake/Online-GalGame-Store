package Servlet;

import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;
import Object.*;

@WebServlet(name = "CommunityServlet", urlPatterns = "/CommunityServlet")
public class CommunityServlet {

    public static Message[] community() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Message[] messageArray = null;

        try {
            conn = GetConnection.getConnection();
            String sqlCount = "SELECT COUNT(*) FROM message"; // 查询表中的记录总数
            pstmt = conn.prepareStatement(sqlCount);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1); // 获取表中记录总数

            String sql = "SELECT * FROM message";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            ArrayList<Message> messageList = new ArrayList<>();
            while (rs.next()) {
                Message message = new Message();
                message.setUserName(rs.getString("userName"));
                message.setNote(rs.getString("note"));
                message.setTime(rs.getTimestamp("time"));
                message.setLike(rs.getInt("like"));

                messageList.add(message);
            }

            // 将 FavoriteList 转换为数组
            messageArray = new Message[count];
            messageArray = messageList.toArray(messageArray);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return messageArray;
    }

}

