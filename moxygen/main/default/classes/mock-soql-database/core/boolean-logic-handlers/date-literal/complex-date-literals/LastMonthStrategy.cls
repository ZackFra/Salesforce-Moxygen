/**
 * @description Strategy for resolving the LAST_MONTH token 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class LastMonthStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the LAST_MONTH token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(Gmt.today().addMonths(-1).toStartOfMonth());
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}