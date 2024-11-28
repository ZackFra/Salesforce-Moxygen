public with sharing class DateLiteral {
    private String fieldValue;
    private Date recordFieldValue;

    private DateLiteral(String fieldValue, Date recordFieldValue) {
        this.fieldValue = fieldValue;
        this.recordFieldValue = recordFieldValue;
    }

    public Object getFieldValue() {
        return fieldValue;
    }

    public Object getRecordFieldValue() {
        if(!hasNewRecordFieldValue()) {
            throw new ValidationException('Record field value is null');
        }
        return recordFieldValue;
    }

    public Boolean hasNewRecordFieldValue() {
        return recordFieldValue != null;
    }

    static final Map<String, Integer> DAYS_BY_LITERAL = new Map<String, Integer>{
        Token.TODAY_LITERAL => 0,
        Token.YESTERDAY_LITERAL => -1,
        Token.TOMORROW_LITERAL => 1
    };

    public static DateLiteral resolve(DateLiteralOptions options) {
        Schema.DisplayType fieldType = options.getFieldType();
        Boolean isDate = (fieldType == Schema.DisplayType.DATE);
        Boolean isDateTime = (fieldType == Schema.DisplayType.DATETIME);
        
        if(!isDate && !isDateTime) {
            throw new QueryException('Invalid field type for date literal');
        }


        Set<String> dateLiterals = DAYS_BY_LITERAL.keySet();
        Object fieldValue = options.getFieldValue();
        for(String dateLiteralToken : dateLiterals) {
            if(fieldValue != dateLiteralToken) {
                continue;
            }

            Integer daysToAdjustBy = DAYS_BY_LITERAL.get(dateLiteralToken);
            String newFieldValue = Common.dateToSoqlString(GMT.today().addDays(daysToAdjustBy));
            Object newRecordFieldValue = null;

            Object recordFieldValue = options.getRecordFieldValue();
            if(isDateTime && recordFieldValue != null) {
                newRecordFieldValue = (Object) GMT.date((DateTime) recordFieldValue);
            }
            return new DateLiteral(newFieldValue, (Date) newRecordFieldValue);
        }
        throw new QueryException('Invalid or unsupported date literal: ' + fieldValue);
    }
}