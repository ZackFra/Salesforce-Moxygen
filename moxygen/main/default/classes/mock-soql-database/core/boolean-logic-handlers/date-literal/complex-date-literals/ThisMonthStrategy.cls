/**
 * @description A class to resolve the THIS_MONTH token 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class ThisMonthStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the THIS_MONTH token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().toStartOfMonth());
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}