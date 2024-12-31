package Object;

public class Goods {
    String name;
    int prices;
    int sellNum;
    String note;
    String path;
    Double discount;

    // Constructors
    public Goods() {
        // 默认构造函数
    }

    public Goods(String name, int prices, int sellNum, String note, String path, Double discount) {
        this.name = name;
        this.prices = prices;
        this.sellNum = sellNum;
        this.note = note;
        this.path = path;
        this.discount = discount;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrices() {
        return prices;
    }

    public void setPrices(int prices) {
        this.prices = prices;
    }

    public int getSellNum() {
        return sellNum;
    }

    public void setSellNum(int sellNum) {
        this.sellNum = sellNum;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPath() { return path; }

    public void setPath(String path) { this.path = path; }

    public Double getDiscount() { return discount; }

    public void setDiscount(Double discount) { this.discount = discount; }
}
