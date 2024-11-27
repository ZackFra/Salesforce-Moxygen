@isTest
private class WhereParserTest {

    @isTest
    static void ensureTodayCanBeParsedByWhereParser() {
        WhereParser parser = new WhereParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('WHERE CreatedDate = TODAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');
    }

    @isTest
    static void ensureYesterdayCanBeParsedByWhereParser() {
        WhereParser parser = new WhereParser();
        Exception ex;

        Test.startTest();
        try {
            Intermediary intermediary = parser.parse('WHERE CreatedDate = YESTERDAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');
    }

    @isTest
    static void ensureTomorrowCanBeParsedByWhereParser() {
        WhereParser parser = new WhereParser();
        Exception ex;

        Test.startTest();
        try {
            Intermediary intermediary = parser.parse('WHERE CreatedDate = TOMORROW');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');
    }
}