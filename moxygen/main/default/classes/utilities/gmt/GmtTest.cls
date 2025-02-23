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
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Exception was thrown');
    }

    @isTest
    static void ensureValidCalendarDateIsReturned() {
        Datetime startOfThisCalendarQuarter = Gmt.startOfThisCalendarQuarter();
        List<Datetime> validQuarterDates = new List<Datetime>{
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 1, 1),
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 4, 1),
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 7, 1),
            Datetime.newInstanceGmt(startOfThisCalendarQuarter.year(), 10, 1)
        };

        Boolean foundDate = false;
        for (Datetime validQuarterDate : validQuarterDates) {
            if (
                validQuarterDate.month() == startOfThisCalendarQuarter.month()
            ) {
                foundDate = true;
                break;
            }
        }
        Assert.isTrue(
            foundDate,
            'Start of this calendar quarter is not a valid quarter date'
        );
    }

    @IsTest
    static void ensureStartOfThisFiscalYearReturnsCorrectValue() {
        Test.startTest();
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Test.stopTest();

        Organization org = OrganizationSingleton.getInstance();
        Integer orgFiscalMonth = org.FiscalYearStartMonth;
        Date possibleStartOfThisFiscalYear = Date.newInstance(
            Gmt.today().year(),
            orgFiscalMonth,
            1
        );
        if (possibleStartOfThisFiscalYear > Gmt.today()) {
            Date expectedStartOfThisFiscalYear = possibleStartOfThisFiscalYear.addYears(
                -1
            );
            Assert.areEqual(
                expectedStartOfThisFiscalYear,
                startOfThisFiscalYear,
                'Start of this fiscal year is not correct'
            );
        } else {
            Assert.areEqual(
                possibleStartOfThisFiscalYear,
                startOfThisFiscalYear,
                'Start of this fiscal year is not correct'
            );
        }
    }

    @isTest
    static void ensureStartOfThisFiscalQuarterReturnsCorrectValue() {
        Test.startTest();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Test.stopTest();

        Assert.isTrue(
            Gmt.today() >= startOfThisFiscalQuarter,
            'Start of this fiscal quarter is not correct'
        );

        Assert.isTrue(
            Gmt.today() < startOfThisFiscalQuarter.addMonths(3),
            'Start of this fiscal quarter is not correct'
        );
    }
}
