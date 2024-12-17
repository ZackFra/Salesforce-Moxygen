/**
 * @description Strategy for resolving the NEXT_N_DAYS token 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public with sharing class NextNDaysStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the NEXT_N_DAYS token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String token = (String) options.getFieldValue();
        List<String> groups = token.split(':');
        String dayValue = groups[1];
        Integer days = Integer.valueOf(dayValue);
        String fieldValue = Common.dateToSoqlString(GMT.today().addDays(days));
        return resolve(fieldValue, options.getFieldType(), options.getRecordFieldValue());
    }
}