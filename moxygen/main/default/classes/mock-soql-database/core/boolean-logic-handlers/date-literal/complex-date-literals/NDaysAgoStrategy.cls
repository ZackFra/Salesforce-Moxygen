/**
 * @description Strategy for the N_DAYS_AGO token
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public inherited sharing class NDaysAgoStrategy extends ComplexDateLiteralStrategy {

    public NDaysAgoStrategy() {
        super(new DateFormulas.Invert());
    }
    
    /**
     * @description Resolve the N_DAYS_AGO token
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return  `DateLiteral`
     */
    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        return resolve();
    }
}