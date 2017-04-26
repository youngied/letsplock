package beans;
public class BlockData {
    private String position;
    private String rotation;
    private String color;
    private int type;

    public BlockData(String position, String rotation, String color, int type) {
        this.position = position;
        this.rotation = rotation;
        this.color = color;
        this.type = type;
    }
    public BlockData() {
    	
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getRotation() {
        return rotation;
    }

    public void setRotation(String rotation) {
        this.rotation = rotation;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}