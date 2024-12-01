/**
 * @description Strategy for the NEXT_WEEK token 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class NextWeekStrategy extends ComplexDateLiteralStrategy  {
    /**
     * @description Resolves the NEXT_WEEK token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().addDays(7).toStartOfWeek());
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}