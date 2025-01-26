@isTest
private class TodayComparableTest {
    static DateTime now = Gmt.now();
    static DateTime tomorrowDatetime = Gmt.today().addDays(1);
    static DateTime yesterdayDatetime = Gmt.today().addDays(-1);

    static Date today = Gmt.today();
    static Date tomorrowDate = today.addDays(1);
    static Date yesterdayDate = today.addDays(-1);

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isFalse(
            todayComparator.isLessThan(now),
            'Now should not be less than TODAY'
        );
        Assert.isFalse(
            todayComparator.isLessThan(today),
            'Today should not be less than TODAY'
        );
        Assert.isTrue(
            todayComparator.isLessThan(yesterdayDatetime),
            'Yesterday should be less than TODAY'
        );
        Assert.isFalse(
            todayComparator.isLessThan(tomorrowDatetime),
            'Tomorrow should not be less than TODAY'
        );
        Assert.isTrue(
            todayComparator.isLessThan(yesterdayDate),
            'Yesterday should be less than TODAY'
        );
        Assert.isFalse(
            todayComparator.isLessThan(tomorrowDate),
            'Tomorrow should not be less than TODAY'
        );
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isFalse(
            todayComparator.isGreaterThan(now),
            'Now should not be greater than TODAY'
        );
        Assert.isFalse(
            todayComparator.isGreaterThan(today),
            'Today should not be greater than TODAY'
        );
        Assert.isFalse(
            todayComparator.isGreaterThan(yesterdayDatetime),
            'Yesterday should not be greater than TODAY'
        );
        Assert.isTrue(
            todayComparator.isGreaterThan(tomorrowDatetime),
            'Tomorrow should be greater than TODAY'
        );
        Assert.isFalse(
            todayComparator.isGreaterThan(yesterdayDate),
            'Yesterday should not be greater than TODAY'
        );
        Assert.isTrue(
            todayComparator.isGreaterThan(tomorrowDate),
            'Tomorrow should be greater than TODAY'
        );
    }
}
