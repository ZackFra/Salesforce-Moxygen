/**
 * @description Given a token, this class will return the appropriate strategy for the token
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class ComplexDateLiteralFactory {
    static final Map<String, Type> STRATEGY_BY_TOKEN = new Map<String, Type>{
        Token.LAST_WEEK_LITERAL => LastWeekStrategy.class,
        token.THIS_WEEK_LITERAL => ThisWeekStrategy.class,
        token.NEXT_WEEK_LITERAL => NextWeekStrategy.class,
        token.THIS_WEEK_LITERAL => ThisWeekStrategy.class,
        token.LAST_MONTH_LITERAL => LastMonthStrategy.class,
        token.THIS_MONTH_LITERAL => ThisMonthStrategy.class,
        token.NEXT_MONTH_LITERAL => NextMonthStrategy.class,
        token.LAST_90_DAYS_LITERAL => Last90DaysStrategy.class
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
        Type strategyType = STRATEGY_BY_TOKEN.get(token);
        if(strategyType == null) {
            throw new ValidationException('Invalid or unsupported date literal: ' + token);
        }
        ComplexDateLiteralStrategy strategy = (ComplexDateLiteralStrategy) strategyType.newInstance();
        return strategy;
    }
}