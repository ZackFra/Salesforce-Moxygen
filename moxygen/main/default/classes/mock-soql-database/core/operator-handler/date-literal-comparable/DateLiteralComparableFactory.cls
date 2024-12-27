public with sharing class DateLiteralComparableFactory {
    static final Map<String, Type> COMPARABLE_BY_TOKEN = new Map<String, Type> {
        Token.TODAY_LITERAL => TodayComparable.class,
        Token.YESTERDAY_LITERAL => YesterdayComparable.class,
        Token.TOMORROW_LITERAL => TomorrowComparable.class,
        Token.THIS_WEEK_LITERAL => ThisWeekComparable.class,
        Token.LAST_WEEK_LITERAL => LastWeekComparable.class
    };

    public static DateLiteralComparable create(DateLiteral dateLiteral) {
        Type comparableType = COMPARABLE_BY_TOKEN.get(dateLiteral.getFieldValue());
        if(comparableType == null) {
            throw new ValidationException('Unexpected date literal ' + dateLiteral.getFieldValue());
        }
        return ((DateLiteralComparable) comparableType.newInstance()).withToken(dateLiteral.getFieldValue());
    }
}