package lab2;

public class Validator {
    public Validator() {
    }
    public static boolean validate(String x1, String y1, String r1) {
        int x = Integer.parseInt(x1);
        float y = Float.parseFloat(y1);
        float r = Float.parseFloat(r1);
        return (x >= -4 && x <= 4) && (y >= -5 && y <= 3) && (r >= 1 && r <= 3);
    }
}
