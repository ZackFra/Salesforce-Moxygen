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

    /**
     * @description Multiplies the day value by 7
     */
    public class Weeks implements IDateFormula {
        /**
         * @description Apply the weeks formula
         * @param dayValue `Integer`
         * @return  `Integer`
         */
        public Integer apply(Integer dayValue) {
            return dayValue * 7;
        }
    }

    /**
     * @description Multiplies the day value by -7
     */
    public class InvertWeeks implements IDateFormula {
        /**
         * @description Apply the invert weeks formula
         * @param dayValue `Integer`
         * @return  `Integer`
         */
        public Integer apply(Integer dayValue) {
            return -dayValue * 7;
        }
    }

    /**
     * @description Returns the days between the current date and the date value, subtracting months
     */
    public class MonthsAgo implements IDateFormula {
        /**
         * @description Apply the months ago formula
         * @param monthValue `Integer`
         * @return  `Integer`
         */
        public Integer apply(Integer monthValue) {
            return Gmt.today().daysBetween(Gmt.today().addMonths(-monthValue));
        }
    }
}