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
        } catch(Exception e) {
            Assert.fail('Expected no exception but got ' + e.getMessage() + ' for ' + dt + ' and ' + yesterdayAsString);
        }
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' for ' + dt + ' and ' + yesterdayAsString);
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
        } catch(Exception e) {
            Assert.fail('Expected no exception but got ' + e.getMessage() + ' for ' + dt + ' and ' + yesterdayAsString);
        }
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' for ' + dt + ' and ' + yesterdayAsString);
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
        } catch(Exception e) {
            Assert.fail('Expected no exception but got ' + e.getMessage() + ' for ' + dt + ' and ' + todayAsString);
        }
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' for ' + dt + ' and ' + todayAsString);
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
        } catch(Exception e) {
            Assert.fail('Expected no exception but got ' + e.getMessage() + ' for ' + dt + ' and ' + todayAsString);
        }
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' for ' + dt + ' and ' + todayAsString);
    }
}