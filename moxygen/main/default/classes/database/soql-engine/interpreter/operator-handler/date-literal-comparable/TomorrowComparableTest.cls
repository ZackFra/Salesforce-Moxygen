@isTest
private class TomorrowComparableTest {
    static DateTime now = Gmt.now();
    static DateTime tomorrowDatetime = Gmt.today().addDays(1);
    static DateTime yesterdayDatetime = Gmt.today().addDays(-1);

    static Date today = Gmt.today();
    static Date tomorrowDate = today.addDays(1);
    static Date yesterdayDate = today.addDays(-1);

    static DateTime oneWeekFromNowDateTime = now.addDays(7);
    static Date oneWeekFromNowDate = today.addDays(7);

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isTrue(
            tomorrowComparator.isLessThan(now),
            'Now should be less than TOMORROW'
        );
        Assert.isTrue(
            tomorrowComparator.isLessThan(today),
            'Today should be less than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isLessThan(tomorrowDatetime),
            'Tomorrow should not be less than TOMORROW'
        );
        Assert.isTrue(
            tomorrowComparator.isLessThan(yesterdayDatetime),
            'Yesterday should be less than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isLessThan(tomorrowDate),
            'Tomorrow should not be less than TOMORROW'
        );
        Assert.isTrue(
            tomorrowComparator.isLessThan(yesterdayDate),
            'Yesterday should not less than TOMORROW'
        );
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isFalse(
            tomorrowComparator.isGreaterThan(now),
            'Now should not be greater than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isGreaterThan(today),
            'Today should not be greater than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isGreaterThan(tomorrowDatetime),
            'Tomorrow should not be greater than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isGreaterThan(yesterdayDatetime),
            'Yesterday should not be greater than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isGreaterThan(tomorrowDate),
            'Tomorrow should not be greater than TOMORROW'
        );
        Assert.isFalse(
            tomorrowComparator.isGreaterThan(yesterdayDate),
            'Yesterday should not be greater than TOMORROW'
        );
    }
}
