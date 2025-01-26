@isTest
private class YesterdayComparableTest {
    static DateTime now = Gmt.now();
    static DateTime tomorrowDatetime = Gmt.today().addDays(1);
    static DateTime yesterdayDatetime = Gmt.today().addDays(-1);

    static Date today = Gmt.today();
    static Date tomorrowDate = today.addDays(1);
    static Date yesterdayDate = today.addDays(-1);

    static DateTime oneWeekAgoDatetime = now.addDays(-7);
    static Date oneWeekAgoNowDate = today.addDays(-7);

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isTrue(
            yesterdayComparator.isGreaterThan(now),
            'Now should be greater than YESTERDAY'
        );
        Assert.isTrue(
            yesterdayComparator.isGreaterThan(today),
            'Today should be greater than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isGreaterThan(yesterdayDatetime),
            'Yesterday should not be greater than YESTERDAY'
        );
        Assert.isTrue(
            yesterdayComparator.isGreaterThan(tomorrowDatetime),
            'Tomorrow should be greater than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isGreaterThan(yesterdayDate),
            'Yesterday should not be greater than YESTERDAY'
        );
        Assert.isTrue(
            yesterdayComparator.isGreaterThan(tomorrowDate),
            'Tomorrow should be greater than YESTERDAY'
        );
    }

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isFalse(
            yesterdayComparator.isLessThan(now),
            'Now should not be less than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isLessThan(today),
            'Today should not be less than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isLessThan(yesterdayDatetime),
            'Yesterday should not be less than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isLessThan(tomorrowDatetime),
            'Tomorrow should not be less than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isLessThan(yesterdayDate),
            'Yesterday should not be less than YESTERDAY'
        );
        Assert.isFalse(
            yesterdayComparator.isLessThan(tomorrowDate),
            'Tomorrow should not be less than YESTERDAY'
        );
        Assert.isTrue(
            yesterdayComparator.isLessThan(oneWeekAgoDatetime),
            'One week ago should be less than YESTERDAY'
        );
        Assert.isTrue(
            yesterdayComparator.isLessThan(oneWeekAgoNowDate),
            'One week ago should be less than YESTERDAY'
        );
    }
}
