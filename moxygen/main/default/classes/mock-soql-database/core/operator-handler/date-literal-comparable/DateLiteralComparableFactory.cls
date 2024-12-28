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
        Token.LAST_N_DAYS_LITERAL => LastNDaysComparable.class
    };

    public static DateLiteralComparable create(DateLiteral dateLiteral) {
        String fieldValue = dateLiteral.getFieldValue();
        Type comparableType = COMPARABLE_BY_TOKEN.get(fieldValue);
        if(comparableType == null) {
            throw new ValidationException('Unexpected date literal ' + fieldValue);
        }
        DateLiteralComparable comparable = (DateLiteralComparable) comparableType.newInstance();
        return comparable.withToken(fieldValue);
    }
}