/**
 * @description Interface for date functions
 * @author Zackary Frazier
 * @since 1/17/2025
 * @group Date Functions
 */
public interface IDateFunc {
    /**
     * @description Calculate the date function value for a given date or datetime value
     * @param dateOrDateTime Date or Datetime value to calculate the date function value of
     * @return  The date function value of the date or datetime value
     */
    Integer calculate(Object dateOrDateTime);
}
