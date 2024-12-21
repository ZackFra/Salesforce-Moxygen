/**
 * @description Strategy for handling the LAST_N_WEEKS date literal 
 * @author Zackary Frazier
 * @since 12/21/2024
 */
public inherited sharing class LastNWeeksStrategy extends ComplexDateLiteralStrategy {
    /**
     * @description Set the formula to invert weeks
     */
    public LastNWeeksStrategy() {
        super(new DateFormulas.InvertWeeks());
    }

    /**
     * @description Resolve the LAST_N_WEEKS date literal
     * @param fieldType `Schema.DisplayType` - Deprecated
     * @param recordFieldValue `Object` - Deprecated
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        return resolve();
    }
}