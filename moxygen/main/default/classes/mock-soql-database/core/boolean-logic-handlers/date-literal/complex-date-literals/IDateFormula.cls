/**
 * @description Interface for date formulas to transform date values for complex date literals 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public interface IDateFormula {
    /**
     * @description Applies a formula to a date value 
     * @param days `Integer`
     * @return  `Integer`
     */
    Integer apply(Integer days);
}