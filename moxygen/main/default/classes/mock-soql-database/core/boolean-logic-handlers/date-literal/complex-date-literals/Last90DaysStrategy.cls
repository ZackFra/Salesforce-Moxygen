/**
 * @description Strategy for resolving the LAST_90_DAYS token 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public with sharing class Last90DaysStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the LAST_90_DAYS token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(Gmt.today().addDays(-90));
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}