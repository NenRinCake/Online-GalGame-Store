package Object;

public class Favorite {
    String userName;
    String name;
    String note;
    String path;

    // Constructors
    public Favorite() {
        // 默认构造函数
    }

    public Favorite(String userName, String name, String note, String path) {
        this.userName = userName;
        this.name = name;
        this.note = note;
        this.path = path;
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
}
