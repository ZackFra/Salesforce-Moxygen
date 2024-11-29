/**
 * @description A class to resolve the THIS_WEEK token 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public inherited sharing class ThisWeekStrategy implements IComplexDateLiteralStrategy {
    /**
     * @description Resolve the LAST_WEEK token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     */
    public DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().toStartOfWeek());
        Date newRecordFieldValue = null;
        if(fieldType== Schema.DisplayType.DATETIME) {
            newRecordFieldValue = (Date) GMT.date((DateTime) recordFieldValue);
        }
        return new DateLiteral.Builder()
            .setFieldValue(fieldValue)
            .setNewRecordFieldValue(newRecordFieldValue)
            .build();
    }
}