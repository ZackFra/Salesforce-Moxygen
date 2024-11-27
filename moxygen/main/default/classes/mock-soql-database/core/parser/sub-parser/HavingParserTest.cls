@isTest
private class HavingParserTest {

    @isTest
    static void ensureTodayCanByParsedByHavingParser() {
        HavingParser parser = new HavingParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('HAVING CreatedDate < TODAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');

    }

    @isTest
    static void ensureTomorrowCanByParsedByHavingParser() {
        HavingParser parser = new HavingParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('HAVING CreatedDate < TOMORROW');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');

    }

    @isTest
    static void ensureYesterdayCanByParsedByHavingParser() {
        HavingParser parser = new HavingParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('HAVING CreatedDate < YESTERDAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');

    }
}