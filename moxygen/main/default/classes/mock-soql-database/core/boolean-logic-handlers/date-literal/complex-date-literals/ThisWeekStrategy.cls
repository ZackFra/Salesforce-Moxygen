/**
 * @description A class to resolve the THIS_WEEK token 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public inherited sharing class ThisWeekStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the LAST_WEEK token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().toStartOfWeek());
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}