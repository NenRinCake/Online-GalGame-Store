package Object;

import Servlet.GetConnection;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class HitokotoWithTypeExample {

    public static int findSubstringPosition(String mainString, String substring) {
        return mainString.indexOf(substring);
    }

    public static String getHitokoto(String s){
        int index = findSubstringPosition(s,"\"hitokoto\":\"");
        String ans = "";
        for(int i = index + 12;i<s.length();i++){
            if(s.charAt(i) == '\"'){
                break;
            }
            ans += s.charAt(i);
        }
        return ans;
    }

    public static String getFrom(String s){
        int index = findSubstringPosition(s,"\"from\":\"");
        String ans = "";
        for(int i = index + 8;i<s.length();i++){
            if(s.charAt(i) == '\"'){
                break;
            }
            ans += s.charAt(i);
        }
        return ans;
    }
    public static void handleRequest(String username) throws IOException {


        String s = "";

        LocalDateTime currentDateTime = LocalDateTime.now();

        // 格式化当前时间以显示秒数
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String time = currentDateTime.format(formatter);

        try {
            // 设置要获取的句子类型，例如这里设置为动画（a）、漫画（b）、游戏（c）类别
            String[] sentenceTypes = {"a", "b", "c"};

            StringBuilder urlBuilder = new StringBuilder("https://v1.hitokoto.cn/?");
            // 构建参数字符串，例如：c=a&c=b&c=c
            for (String type : sentenceTypes) {
                urlBuilder.append("c=").append(type).append("&");
            }
            // 去掉末尾的"&"符号
            urlBuilder.deleteCharAt(urlBuilder.length() - 1);

            // 创建 URL 对象
            URL url = new URL(urlBuilder.toString());

            // 创建 HttpURLConnection 实例
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // 设置请求方法
            connection.setRequestMethod("GET");

            // 获取响应代码
            int responseCode = connection.getResponseCode();

            // 读取响应内容
            BufferedReader reader;
            if (responseCode == HttpURLConnection.HTTP_OK) {
                reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            } else {
                reader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }

            StringBuilder resp = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                resp.append(line);
            }
            reader.close();

            // 打印响应内容到控制台
            System.out.println("Response Code: " + responseCode);
            System.out.println("Response Body: " + resp.toString());
            s = resp.toString();
            System.out.println(getHitokoto(s));
            System.out.println(getFrom(s));
            // 关闭连接
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }


    public static void main(String[] args)throws Exception{
        handleRequest("NenRinCake");

    }
}
