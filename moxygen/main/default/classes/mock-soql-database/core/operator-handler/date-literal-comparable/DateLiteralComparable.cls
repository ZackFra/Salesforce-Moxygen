public abstract class DateLiteralComparable {

    public String token {get; private set;}
    public abstract Boolean isEqual(DateTime fieldValue);
    
    public DateLiteralComparable withToken(String token) {
        this.token = token;
        return this;
    }
}