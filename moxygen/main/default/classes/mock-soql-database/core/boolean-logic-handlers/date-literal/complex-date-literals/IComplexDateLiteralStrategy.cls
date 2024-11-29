/**
 * @description Interface for complex date literals 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public interface IComplexDateLiteralStrategy {
    /**
     * @description Resolve the value of a complex date literal
     * @param fieldType `Schema.DisplayType`
     * @param recordFieldValue `Object`
     * @return `DateLiteral`
     */
    DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue);
}