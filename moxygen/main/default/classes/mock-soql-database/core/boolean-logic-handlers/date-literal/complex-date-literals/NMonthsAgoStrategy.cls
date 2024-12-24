/**
 * @description Strategy for handling N_MONTHS_AGO date literals 
 * @author Zackary Frazier
 * @since 12/23/2024
 */
public with sharing class NMonthsAgoStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Constructor, set the MonthsAgo date formula strategy
     */
    public NMonthsAgoStrategy() {
        super(new DateFormulas.MonthsAgo());
    }

    /**
     * @description Resolve the N_MONTHS_AGO token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        return resolve();
    }
}