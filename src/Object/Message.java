package Object;


import java.sql.Timestamp;

public class Message {
    private String userName;
    private String note;
    private Timestamp time;
    private int like;

    // Constructors
    public Message() {
        // 默认构造函数
    }

    public Message(String userName, String note, Timestamp time, int like) {
        this.userName = userName;
        this.note = note;
        this.time = time;
        this.like = like;
    }

    // Getters and Setters
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public int getLike(){ return like; }

    public void setLike(int like){ this.like = like; }

}
