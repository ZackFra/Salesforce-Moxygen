@isTest
private class EqualityHandlerTest {
    @IsTest
    static void ensureYesterdayIsEqualToYesterdayForDateTime() {
        EqualityHandler handler = new EqualityHandler();
        DateTime dt = GMT.now().addDays(-1);
        String yesterdayAsString = Common.dateTimeToSoqlString(dt);

        Boolean result;
        Test.startTest();
        try {
            result = handler.handle(dt, yesterdayAsString);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    dt +
                    ' and ' +
                    yesterdayAsString
            );
        }
        Test.stopTest();

        Assert.isTrue(
            result,
            'Expected true but got ' +
                result +
                ' for ' +
                dt +
                ' and ' +
                yesterdayAsString
        );
    }

    @IsTest
    static void ensureYesterdayIsEqualToYesterdayForDate() {
        EqualityHandler handler = new EqualityHandler();
        Date dt = GMT.today().addDays(-1);
        String yesterdayAsString = Common.dateToSoqlString(dt);

        Boolean result;
        Test.startTest();
        try {
            result = handler.handle(dt, yesterdayAsString);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    dt +
                    ' and ' +
                    yesterdayAsString
            );
        }
        Test.stopTest();

        Assert.isTrue(
            result,
            'Expected true but got ' +
                result +
                ' for ' +
                dt +
                ' and ' +
                yesterdayAsString
        );
    }

    @isTest
    static void ensureTodayIsEqualToTodayForDateTime() {
        EqualityHandler handler = new EqualityHandler();
        DateTime dt = GMT.now();
        String todayAsString = Common.dateTimeToSoqlString(dt);

        Boolean result;
        Test.startTest();
        try {
            result = handler.handle(dt, todayAsString);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    dt +
                    ' and ' +
                    todayAsString
            );
        }
        Test.stopTest();

        Assert.isTrue(
            result,
            'Expected true but got ' +
                result +
                ' for ' +
                dt +
                ' and ' +
                todayAsString
        );
    }

    @IsTest
    static void ensureTodayIsEqualForDate() {
        EqualityHandler handler = new EqualityHandler();
        Date dt = GMT.today();
        String todayAsString = Common.dateToSoqlString(dt);

        Boolean result;
        Test.startTest();
        try {
            result = handler.handle(dt, todayAsString);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    dt +
                    ' and ' +
                    todayAsString
            );
        }
        Test.stopTest();

        Assert.isTrue(
            result,
            'Expected true but got ' +
                result +
                ' for ' +
                dt +
                ' and ' +
                todayAsString
        );
    }

    @isTest
    static void ensureThisWeekWorksWithRange() {
        EqualityHandler handler = new EqualityHandler();
        Date startOfWeek = GMT.today().toStartOfWeek();
        for (Integer i = 0; i < 6; i++) {
            DateLiteral fieldValue = new DateLiteral.Builder()
                .setFieldValue(Token.THIS_WEEK_LITERAL)
                .build();
            Date testedDate = startOfWeek.addDays(i);
            DateTime testedDateTime = Gmt.dateTime(testedDate);

            Boolean result = handler.handle(testedDate, fieldValue);
            Assert.isTrue(
                result,
                'Expected true but got ' +
                    result +
                    ' for ' +
                    testedDate +
                    ' and ' +
                    Token.THIS_WEEK_LITERAL
            );

            result = handler.handle(testedDateTime, fieldValue);
            Assert.isTrue(
                result,
                'Expected true but got ' +
                    result +
                    ' for ' +
                    testedDateTime +
                    ' and ' +
                    Token.THIS_WEEK_LITERAL
            );
        }
    }

    @isTest
    static void ensureTodayWorksWithDateAndDateTime() {
        Date today = GMT.today();
        DateTime now = Gmt.now();

        EqualityHandler handler = new EqualityHandler();
        DateLiteral todayLiteral = new DateLiteral.Builder()
            .setFieldValue(Token.TODAY_LITERAL)
            .build();

        Boolean result = handler.handle(today, todayLiteral);
        Assert.isTrue(
            result,
            'Expected true but got ' +
                result +
                ' for ' +
                today +
                ' and ' +
                Token.TODAY_LITERAL
        );
        result = handler.handle(now, todayLiteral);
        Assert.isTrue(
            result,
            'Expected true but got ' +
                result +
                ' for ' +
                now +
                ' and ' +
                Token.TODAY_LITERAL
        );
    }
}
