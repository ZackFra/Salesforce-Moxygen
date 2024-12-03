/**
 * @description Strategy for resolving the LAST_N_DAYS token 
 * @author Zackary Frazier
 * @since 12/2/2024
 */
public inherited sharing class LastNDaysStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Resolve the LAST_N_DAYS token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String token = (String) options.getFieldValue();
        List<String> groups = token.split(':');
        String dayValue = groups[1];
        Integer days = Integer.valueOf(dayValue);
        String fieldValue = Common.dateToSoqlString(GMT.today().addDays(-(days+1)));
        return resolve(fieldValue, options.getFieldType(), options.getRecordFieldValue());
    }
}