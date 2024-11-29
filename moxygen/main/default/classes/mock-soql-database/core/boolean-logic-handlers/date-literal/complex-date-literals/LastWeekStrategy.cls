/**
 * @description Strategy for resolving the LAST_WEEK token 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public inherited sharing class LastWeekStrategy implements IComplexDateLiteralStrategy {
    /**
     * @description Resolve the LAST_WEEK token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return `DateLiteral`
     */
    public DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().addDays(-7).toStartOfWeek());
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