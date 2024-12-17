/**
 * @description Strategy for resolving the complex date literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public abstract class ComplexDateLiteralStrategy {

    protected DateLiteralOptions options;
    protected IDateFormula dateFormula;

    /**
     * @description Retunrs the date formula used for this strategy 
     * @return  `IDateFormula`
     */
    public IDateFormula getDateFormula() {
        return dateFormula;
    }

    /**
     * @description Constructor
     */
    public ComplexDateLiteralStrategy() {
        this.dateFormula = null;
    }

    /**
     * @description Constructor for date formulas
     * @param dateFormula `IDateFormula`
     */
    public ComplexDateLiteralStrategy(IDateFormula dateFormula) {
        this.dateFormula = dateFormula;
    }

    /**
     * @description Public facing method, resolves the complex date literal
     * @param fieldType `Schema.DisplayType` Date|Datetime
     * @param recordFieldValue `Object` The record field value
     * @return  `abstract DateLiteral`
     */
    public abstract DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue);

    protected DateLiteral resolveWithDateFormula() {
        IDateFormula dateFormula = getDateFormula();
        String token = (String) options.getFieldValue();
        List<String> groups = token.split(':');
        String dayValue = groups[1];
        Integer days = dateFormula.apply(Integer.valueOf(dayValue));
        String fieldValue = formatDate(days);
        return resolve(fieldValue, options.getFieldType(), options.getRecordFieldValue());
    }

    private String formatDate(Integer days) {
        return Common.dateToSoqlString(GMT.today().addDays(days));
    }

    protected DateLiteral resolve() {
        if(getDateFormula() != null) {
            return resolveWithDateFormula();
        }
        return resolve((String) options.getFieldValue(), options.getFieldType(), options.getRecordFieldValue());
    }

    /**
     * @description Resolve the date literal
     * @param fieldValue `String` Soql date string
     * @param fieldType `Schema.DisplayType` Date|Datetime
     * @param recordFieldValue `Object` The record field value
     * @return  `DateLiteral`
     */
    protected DateLiteral resolve(String fieldValue, Schema.DisplayType fieldType, Object recordFieldValue) {
        Date newRecordFieldValue = null;
        if(fieldType== Schema.DisplayType.DATETIME) {
            newRecordFieldValue = (Date) GMT.date((DateTime) recordFieldValue);
        }
        return new DateLiteral.Builder()
            .setFieldValue(fieldValue)
            .setNewRecordFieldValue(newRecordFieldValue)
            .build();
    }

    /**
     * @description Set the options for the strategy
     * @param options `DateLiteralOptions`
     * @return  `ComplexDateLiteralStrategy`
     */
    public ComplexDateLiteralStrategy setOptions(DateLiteralOptions options) {
        this.options = options;
        return this;
    }
}