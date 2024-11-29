/**
 * @description Represents the value and new record field value for a date literal
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class DateLiteral {
    String fieldValue;
    Date recordFieldValue;

    static final Map<String, Integer> DAYS_BY_LITERAL = new Map<String, Integer>{
        Token.TODAY_LITERAL => 0,
        Token.YESTERDAY_LITERAL => -1,
        Token.TOMORROW_LITERAL => 1
    };

    private DateLiteral(String fieldValue, Date recordFieldValue) {
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

        String fieldValue = options.getFieldValue();
        if(isSimple(fieldValue)) {
            return buildDateLiteral(options, fieldValue);
        }

        throw new ValidationException('Invalid or unsupported date literal: ' + fieldValue);
    }

    private Boolean isSimple(String token) {
        return DAYS_BY_LITERAL.containsKey(token);
    }

    private static DateLiteral buildDateLiteral(DateLiteralOptions options, String dateLiteralToken) {
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