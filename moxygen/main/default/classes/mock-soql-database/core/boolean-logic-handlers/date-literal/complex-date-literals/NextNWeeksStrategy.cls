/**
 * @description Strategy for resolving the NEXT_N_WEEKS token 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public with sharing class NextNWeeksStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Pass in the Weeks formula to transform the N value
     */
    public NextNWeeksStrategy() {
        super(new DateFormulas.Weeks());
    }

    /**
     * @description Resolve using the start of the current week as the base
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        return resolve(GMT.today().toStartOfWeek());
    }
}