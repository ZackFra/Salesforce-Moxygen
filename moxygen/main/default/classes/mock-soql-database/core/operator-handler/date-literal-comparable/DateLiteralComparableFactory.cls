/**
 * @description Factory class for creating DateLiteralComparable instances
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class DateLiteralComparableFactory {
    static final Map<String, Type> COMPARABLE_BY_TOKEN = new Map<String, Type> {
        Token.TODAY_LITERAL => TodayComparable.class,
        Token.YESTERDAY_LITERAL => YesterdayComparable.class,
        Token.TOMORROW_LITERAL => TomorrowComparable.class,
        Token.THIS_WEEK_LITERAL => ThisWeekComparable.class,
        Token.LAST_WEEK_LITERAL => LastWeekComparable.class,
        Token.NEXT_WEEK_LITERAL => NextWeekComparable.class,
        Token.LAST_MONTH_LITERAL => LastMonthComparable.class,
        Token.THIS_MONTH_LITERAL => ThisMonthComparable.class,
        Token.NEXT_MONTH_LITERAL => NextMonthComparable.class,
        Token.LAST_90_DAYS_LITERAL => Last90DaysComparable.class,
        Token.NEXT_90_DAYS_LITERAL => Next90DaysComparable.class,
        Token.LAST_N_DAYS_LITERAL => LastNDaysComparable.class,
        Token.NEXT_N_DAYS_LITERAL => NextNDaysComparable.class,
        Token.N_DAYS_AGO_LITERAL => NDaysAgoComparable.class,
        Token.NEXT_N_WEEKS_LITERAL => NextNWeeksComparable.class,
        Token.LAST_N_WEEKS_LITERAL => LastNWeeksComparable.class,
        Token.N_MONTHS_AGO_LITERAL => NMonthsAgoComparable.class,
        Token.THIS_QUARTER_LITERAL => ThisQuarterComparable.class,
        Token.LAST_QUARTER_LITERAL => LastQuarterComparable.class,
        Token.NEXT_QUARTER_LITERAL => NextQuarterComparable.class,
        Token.NEXT_N_QUARTERS_LITERAL => NextNQuartersComparable.class,
        Token.NEXT_FISCAL_YEAR_LITERAL => NextFiscalYearComparable.class,
        Token.THIS_YEAR_LITERAL => ThisYearComparable.class,
        Token.THIS_FISCAL_YEAR_LITERAL => ThisFiscalYearComparable.class,
        Token.LAST_N_FISCAL_YEARS_LITERAL => LastNFiscalYearsComparable.class,
        Token.LAST_FISCAL_YEAR_LITERAL => LastFiscalYearComparable.class
    };

    @TestVisible
    private static Set<String> getSupportedTokens() {
        return COMPARABLE_BY_TOKEN.keySet();
    }

    /**
     * @description Creates a DateLiteralComparable instance based on the token value
     * @param dateLiteral `DateLiteral`
     * @return  `DateLiteralComparable`
     * @exception ValidationException
     */
    public static DateLiteralComparable create(DateLiteral dateLiteral) {
        String fieldValue = dateLiteral.fieldValue;
        String tokenValue = fieldValue.split(':')[0];
        
        Type comparableType = COMPARABLE_BY_TOKEN.get(tokenValue);
        if(comparableType == null) {
            throw new ValidationException('Unexpected date literal ' + fieldValue);
        }
        DateLiteralComparable comparable = (DateLiteralComparable) comparableType.newInstance();
        return comparable.withToken(fieldValue);
    }
}