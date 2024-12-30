/**
 * @description Represents the value and new record field value for a date literal
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public inherited sharing virtual class DateLiteral {
    /**
     * @description The field value to the date literal token
     */
    public String fieldValue {get; protected set;}

    /**
     * @description Builder for the DateLiteral class
     */
    public class Builder implements IBuilder {
        DateLiteral literal = new DateLiteral();

        /**
         * @description Set the field value
         * @param fieldValue `String`
         * @return  `Builder`
         */
        public Builder setFieldValue(String fieldValue) {
            this.literal.fieldValue = fieldValue;
            return this;
        }

        /**
         * @description Build the DateLiteral 
         * @return  `DateLiteral`
         */
        public DateLiteral build() {
            return this.literal;
        }
    }
}