/**
 * @description Strategy for resolving the complex date literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public abstract class ComplexDateLiteralStrategy {

    protected DateLiteralOptions options;

    /**
     * @description Public facing method, resolves the complex date literal
     * @param fieldType `Schema.DisplayType` Date|Datetime
     * @param recordFieldValue `Object` The record field value
     * @return  `abstract DateLiteral`
     */
    public abstract DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue);

    /**
     * @description Resolve the date literal
     * @param fieldValue `String` Soql date string
     * @param fieldType `Schema.DisplayType` Date|Datetime
     * @param recordFieldValue `Object` The record field value
     * @return  `DateLiteral`
     */
    protected DateLiteral resolve(String fieldValue, Schema.DisplayType fieldType, Object recordFieldValue) {
        Date newRecordFieldValue = null;
        if(fieldType== Schema.DisplayType.DATETIME) {
            newRecordFieldValue = (Date) GMT.date((DateTime) recordFieldValue);
        }
        return new DateLiteral.Builder()
            .setFieldValue(fieldValue)
            .setNewRecordFieldValue(newRecordFieldValue)
            .build();
    }

    /**
     * @description Set the options for the strategy
     * @param options `DateLiteralOptions`
     * @return  `ComplexDateLiteralStrategy`
     */
    public ComplexDateLiteralStrategy setOptions(DateLiteralOptions options) {
        this.options = options;
        return this;
    }
}