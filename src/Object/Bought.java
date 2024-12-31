package Object;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Bought {
    private String userName;
    private String name;
    private String note;
    private String path;
    private Timestamp time;

    // Constructors
    public Bought() {
        // 默认构造函数
    }

    public Bought(String userName, String name, String note, String path, Timestamp time) {
        this.userName = userName;
        this.name = name;
        this.note = note;
        this.path = path;
        this.time = time;
    }

    // Getters and Setters
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
}

