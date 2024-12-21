/**
 * @description Given a token, this class will return the appropriate strategy for the token
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class ComplexDateLiteralFactory {
    static final Map<String, Type> STRATEGY_BY_TOKEN = new Map<String, Type>{
        Token.LAST_WEEK_LITERAL => LastWeekStrategy.class,
        Token.THIS_WEEK_LITERAL => ThisWeekStrategy.class,
        Token.NEXT_WEEK_LITERAL => NextWeekStrategy.class,
        Token.THIS_WEEK_LITERAL => ThisWeekStrategy.class,
        Token.LAST_MONTH_LITERAL => LastMonthStrategy.class,
        Token.THIS_MONTH_LITERAL => ThisMonthStrategy.class,
        Token.NEXT_MONTH_LITERAL => NextMonthStrategy.class,
        Token.LAST_90_DAYS_LITERAL => Last90DaysStrategy.class,
        Token.NEXT_90_DAYS_LITERAL => Next90DaysStrategy.class,
        Token.LAST_N_DAYS_LITERAL => LastNDaysStrategy.class,
        Token.NEXT_N_DAYS_LITERAL => NextNDaysStrategy.class,
        Token.N_DAYS_AGO_LITERAL => NDaysAgoStrategy.class,
        Token.NEXT_N_WEEKS_LITERAL => NextNWeeksStrategy.class,
        Token.LAST_N_WEEKS_LITERAL => LastNWeeksStrategy.class
    };

    @TestVisible
    private static Set<String> getTokens() {
        return STRATEGY_BY_TOKEN.keySet();
    }

    /**
     * @description Get the strategy for the given token
     * @param token `String`
     * @return  `ComplexDateLiteralStrategy`
     * @exception ValidationException
     */
    public static ComplexDateLiteralStrategy getStrategy(String token) {
        String tkn = token;
        if(token.contains(':')) {
            tkn = token.split(':')[0];
        }
        Type strategyType = STRATEGY_BY_TOKEN.get(tkn);
        if(strategyType == null) {
            throw new ValidationException('Invalid or unsupported date literal: ' + token);
        }
        ComplexDateLiteralStrategy strategy = (ComplexDateLiteralStrategy) strategyType.newInstance();
        return strategy;
    }
}