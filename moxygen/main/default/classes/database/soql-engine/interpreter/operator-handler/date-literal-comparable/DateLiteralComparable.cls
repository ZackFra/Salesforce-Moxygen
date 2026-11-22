/**
 * @description Abstract class for date literal comparison
 * @author Zackary Frazier
 * @since 12/28/2024
 * @group Soql Engine
 */
public abstract class DateLiteralComparable {
    /**
     * @description The token for the date literal
     */
    public String token { get; private set; }

    /**
     * @description The number in variable date literals
     */
    public Integer n {
        get {
            return Integer.valueOf(this.token.split(':')[1]);
        }
    }

    /**
     * @description Whether the date literal is greater than the field value
     * @param fieldValue Date or Datetime value
     * @return  Whether fieldValue is greater than the date literal
     */
    public abstract Boolean isGreaterThan(Object fieldValue);

    /**
     * @description Whether the date literal is less than the field value
     * @param fieldValue Date or Datetime value
     * @return Whether fieldValue is less than the date literal
     */
    public abstract Boolean isLessThan(Object fieldValue);

    /**
     * @description A Date stays on its calendar day. A DateTime uses the running user's date for that instant.
     * @param value Date or Datetime field value
     * @return GMT midnight of the calendar day SOQL date literals compare
     */
    protected Datetime literalDateTime(Object value) {
        if (value instanceof Date) {
            return Datetime.newInstanceGmt(
                (Date) value,
                Time.newInstance(0, 0, 0, 0)
            );
        }
        return Datetime.newInstanceGmt(
            ((Datetime) value).date(),
            Time.newInstance(0, 0, 0, 0)
        );
    }

    /**
     * @description Whether the date literal is equal to the field value
     * @param fieldValue Date or Datetime value
     * @return Whether fieldValue is equal to the date literal
     */
    public Boolean isEqual(Object fieldValue) {
        return !isGreaterThan(fieldValue) && !isLessThan(fieldValue);
    }

    /**
     * @description Whether the date literal is greater than or equal to the field value
     * @param fieldValue Date or Datetime value
     * @return Whether fieldValue is greater than or equal to the date literal
     */
    public Boolean isGreaterThanOrEqual(Object fieldValue) {
        return isGreaterThan(fieldValue) || isEqual(fieldValue);
    }

    /**
     * @description Whether the date literal is less than or equal to the field value
     * @param fieldValue Date or Datetime value
     * @return Whether fieldValue is less than or equal to the date literal
     */
    public Boolean isLessThanOrEqual(Object fieldValue) {
        return isLessThan(fieldValue) || isEqual(fieldValue);
    }

    /**
     * @description Whether the date literal is not equal to the field value
     * @param fieldValue Date or Datetime value
     * @return  Whether fieldValue is not equal to the date literal
     */
    public Boolean isNotEqual(Object fieldValue) {
        return !isEqual(fieldValue);
    }

    /**
     * @description Sets the token for the date literal
     * @param token Parsed token
     * @return  This instance of DateLiteralComparable
     */
    public DateLiteralComparable withToken(String token) {
        this.token = token;
        return this;
    }
}
