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
     * @description Whether the date literal is equal to the field value
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public virtual Boolean isEqual(DateTime fieldValue) {
        return !isGreaterThan(fieldValue) && !isLessThan(fieldValue);
    }
    /**
     * @description Whether the date literal is greater than the field value
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public abstract Boolean isGreaterThan(DateTime fieldValue);
    /**
     * @description Whether the date literal is less than the field value
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public abstract Boolean isLessThan(DateTime fieldValue);
    /**
     * @description Whether the date literal is greater than or equal to the field value
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public Boolean isGreaterThanOrEqual(DateTime fieldValue) {
        return isGreaterThan(fieldValue) || isEqual(fieldValue);
    }

    /**
     * @description Whether the date literal is less than or equal to the field value
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public Boolean isLessThanOrEqual(DateTime fieldValue) {
        return isLessThan(fieldValue) || isEqual(fieldValue);
    }

    /**
     * @description Whether the date literal is not equal to the field value
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public Boolean isNotEqual(DateTime fieldValue) {
        return !isEqual(fieldValue);
    }

    /**
     * @description Sets the token for the date literal
     * @param token `String`
     * @return  `DateLiteralComparable`
     */
    public DateLiteralComparable withToken(String token) {
        this.token = token;
        return this;
    }
}
