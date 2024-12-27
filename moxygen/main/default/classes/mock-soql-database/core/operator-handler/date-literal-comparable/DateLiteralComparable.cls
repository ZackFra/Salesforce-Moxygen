public abstract class DateLiteralComparable {

    String token;
    public abstract Boolean isEqual(DateTime fieldValue);
    
    public DateLiteralComparable withToken(String token) {
        this.token = token;
        return this;
    }
}