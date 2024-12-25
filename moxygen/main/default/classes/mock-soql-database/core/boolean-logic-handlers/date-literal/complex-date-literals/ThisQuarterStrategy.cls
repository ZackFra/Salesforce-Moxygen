/**
 * @description Strategy for THIS_QUARTER token 
 * @author Zackary Frazier
 * @since 12/24/2024
 */
public with sharing class ThisQuarterStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the THIS_QUARTER token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.calendarQuarter());
        return resolve(fieldValue, fieldType, recordFieldValue);
    }
}