/**
 * @description Date formulas to transform date values for complex date literals 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public inherited sharing class DateFormulas {
    /**
     * @description Inverts the day value
     */
    public class Invert implements IDateFormula {
        /**
         * @description Apply the invert formula
         * @param dayValue `Integer`
         * @return  `Integer`
         */
        public Integer apply(Integer dayValue) {
            return -dayValue;
        }
    }

    public class Weeks implements IDateFormula {
        public Integer apply(Integer dayValue) {
            return dayValue * 7;
        }
    }
}