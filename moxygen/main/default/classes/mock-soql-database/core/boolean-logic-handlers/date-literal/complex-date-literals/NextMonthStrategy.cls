/**
 * @description Strategy for resolving the NEXT_MONTH token 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class NextMonthStrategy extends ComplexDateLiteralStrategy {

    /**
     * @description Resolve the NEXT_MONTH token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().addMonths(1).toStartOfMonth());
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}