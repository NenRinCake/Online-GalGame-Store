package Object;

public class User {
    String userName;
    String gender;
    String phone;
    String address;
    int score;

    // Constructors, Getters, and Setters

    public User() {
        // 默认构造函数
    }

    public User(String userName, String gender, String phone, String address, int score) {
        this.userName = userName;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
        this.score = score;
    }

    // Getters and Setters for each field

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
