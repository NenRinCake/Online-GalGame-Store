package Object;

public class Consume {

    public int genderNum = 0;
    public double score = 0;
    public Consume(int genderNum, int score) {
        this.genderNum = genderNum;
        this.score = score;
    }

    public int getGenderNum() {
        return genderNum;
    }

    public void setGenderNum(int genderNum) {
        this.genderNum = genderNum;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public void addScore(int cost){
        score += cost;
    }
}
