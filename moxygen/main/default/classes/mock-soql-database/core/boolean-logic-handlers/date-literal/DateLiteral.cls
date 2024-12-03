/**
 * @description Represents the value and new record field value for a date literal
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public inherited sharing virtual class DateLiteral {
    String fieldValue;
    Date recordFieldValue;

    static final Map<String, Integer> DAYS_BY_LITERAL = new Map<String, Integer>{
        Token.TODAY_LITERAL => 0,
        Token.YESTERDAY_LITERAL => -1,
        Token.TOMORROW_LITERAL => 1
    };

    protected DateLiteral(String fieldValue, Date recordFieldValue) {
        this.fieldValue = fieldValue;
        this.recordFieldValue = recordFieldValue;
    }

    /**
     * @description Returns the field value, as a soql string
     * @return  `Object`
     */
    public String getFieldValue() {
        return fieldValue;
    }

    /**
     * @description Returns the record field value 
     * @return  `Date`
     * @exception ValidationException if the record field value is null
     */
    public Date getRecordFieldValue() {
        if(!hasNewRecordFieldValue()) {
            throw new ValidationException('Record field value is null');
        }
        return recordFieldValue;
    }

    /**
     * @description Returns whether the record field value is null 
     * @return  `Boolean`
     */
    public Boolean hasNewRecordFieldValue() {
        return recordFieldValue != null;
    }

    /**
     * @description Resolves a date literal from the given options
     * @param options `DateLiteralOptions`
     * @return  `DateLiteral`
     * @exception ValidationException if the field type is not a date or datetime
     */
    public static DateLiteral resolve(DateLiteralOptions options) {
        Schema.DisplayType fieldType = options.getFieldType();
        Boolean isDate = (fieldType == Schema.DisplayType.DATE);
        Boolean isDateTime = (fieldType == Schema.DisplayType.DATETIME);
        
        if(!isDate && !isDateTime) {
            throw new ValidationException('Invalid field type for date literal');
        }

        String fieldValue = (String) options.getFieldValue();
        if(isSimple(fieldValue)) {
            return buildSimpleDateLiteral(options, fieldValue);
        }

        return buildComplexDateLiteral(options, fieldValue);
    }

    /**
     * @description Builder for the DateLiteral class
     */
    public class Builder implements IBuilder {
        String fieldValue;
        Object recordFieldValue;

        /**
         * @description Set the field value
         * @param fieldValue `String`
         * @return  `Builder`
         */
        public Builder setFieldValue(String fieldValue) {
            this.fieldValue = fieldValue;
            return this;
        }

        /**
         * @description Set the new record field value
         * @param recordFieldValue `Object`
         * @return  `Builder`
         */
        public Builder setNewRecordFieldValue(Object recordFieldValue) {
            this.recordFieldValue = recordFieldValue;
            return this;
        }

        /**
         * @description Build the DateLiteral 
         * @return  `DateLiteral`
         */
        public DateLiteral build() {
            return new DateLiteral(fieldValue, (Date) recordFieldValue);
        }
    }

    private static Boolean isSimple(String token) {
        return DAYS_BY_LITERAL.containsKey(token);
    }

    private static DateLiteral buildComplexDateLiteral(DateLiteralOptions options, String token) {
        return ComplexDateLiteralFactory.getStrategy(token)
            .setOptions(options)
            .resolve(options.getFieldType(), options.getRecordFieldValue());
    }

    private static DateLiteral buildSimpleDateLiteral(DateLiteralOptions options, String dateLiteralToken) {
        Integer daysToAdjustBy = DAYS_BY_LITERAL.get(dateLiteralToken);
        String newFieldValue = Common.dateToSoqlString(GMT.today().addDays(daysToAdjustBy));
        Object newRecordFieldValue = null;
        Object recordFieldValue = options.getRecordFieldValue();
        Boolean isDateTime = (options.getFieldType() == Schema.DisplayType.DATETIME);
        if(isDateTime && recordFieldValue != null) {
            newRecordFieldValue = (Object) GMT.date((DateTime) recordFieldValue);
        }
        return new DateLiteral(newFieldValue, (Date) newRecordFieldValue);
    } 
}