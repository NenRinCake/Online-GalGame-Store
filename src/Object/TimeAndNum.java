package Object;

import java.sql.Timestamp;

public class TimeAndNum implements Comparable<TimeAndNum>{
    private int num;
    private Timestamp time;

    public TimeAndNum(int num, Timestamp time){
        this.num = num;
        this.time = time;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public int compareTo(TimeAndNum other) {
        return this.time.compareTo(other.time);
    }
}
