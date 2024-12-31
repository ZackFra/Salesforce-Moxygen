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
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Exception was thrown');
    }

    @isTest
    static void ensureValidCalendarDateIsReturned() {
        Datetime startOfThisCalendarQuarter = Gmt.startOfThisCalendarQuarter();
        List<Datetime> validQuarterDates = new List<Datetime> {
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 1, 1),
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 4, 1),
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 7, 1),
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 10, 1)
        };

        Boolean foundDate = false;
        for(Datetime validQuarterDate : validQuarterDates) {
            if(validQuarterDate.month() == startOfThisCalendarQuarter.month()) {
                foundDate = true;
                break;
            }
        }
        Assert.isTrue(foundDate, 'Start of this calendar quarter is not a valid quarter date');
    }
}