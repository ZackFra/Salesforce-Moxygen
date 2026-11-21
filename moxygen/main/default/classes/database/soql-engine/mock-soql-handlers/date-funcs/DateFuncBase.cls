/**
 * @description Shared date and datetime normalization for SOQL date functions
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public abstract with sharing class DateFuncBase implements IDateFunc {
    /**
     * @description Calculate the date function value
     * @param value Date or Datetime value
     * @return Calculated value, or null when the input is null
     */
    public abstract Object calculate(Object value);

    protected Date gmtDate(Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof Date) {
            return (Date) value;
        }
        if (value instanceof DateTime) {
            return ((DateTime) value).dateGmt();
        }
        throw new QueryException('Invalid value type for date function');
    }

    /**
     * @description Sunday-based day of week used by SOQL. Sunday is 1 and Saturday is 7.
     * @param value `Date`
     * @return  `Integer`
     */
    protected Integer sundayBasedDayOfWeek(Date value) {
        Date knownSunday = Date.newInstance(1900, 1, 7);
        Integer days = knownSunday.daysBetween(value);
        Integer day = Math.mod(days, 7);
        if (day < 0) {
            day += 7;
        }
        return day + 1;
    }
}
