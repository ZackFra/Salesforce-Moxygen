@isTest
private class GmtTest {

    /**
     * @description Short of, "do these 1-line functions return the 1 line I exepect", not much to test,
     *              so lets just make sure no exceptions are thrown for now.
     */
    @isTest
    static void ensureNoExceptionsAreThrown() {
        Boolean isExceptionThrown = false;
        Date d = System.now().dateGmt();
        DateTime dt = System.now();
        Test.startTest();
        try {
            Gmt.now();
            Gmt.today();
            Gmt.date(dt);
            Gmt.dateTime(d);
            Gmt.calendarQuarter();
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Exception was thrown');
    }
}