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
    static void ensureEqualWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isTrue(yesterdayComparator.isEqual(yesterdayDatetime), 'Yesterday should be equal to now');
        Assert.isTrue(yesterdayComparator.isEqual(yesterdayDate), 'Yesterday should be equal to today');
        Assert.isFalse(yesterdayComparator.isEqual(now), 'Yesterday should not be equal to now');
        Assert.isFalse(yesterdayComparator.isEqual(today), 'Yesterday should not be equal to today');
        Assert.isFalse(yesterdayComparator.isEqual(tomorrowDatetime), 'Yesterday should not be equal to tomorrow');
        Assert.isFalse(yesterdayComparator.isEqual(tomorrowDate), 'Yesterday should not be equal to tomorrow');
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isTrue(yesterdayComparator.isGreaterThan(now), 'Now should be greater than YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThan(today), 'Today should be greater than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isGreaterThan(yesterdayDatetime), 'Yesterday should not be greater than YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThan(tomorrowDatetime), 'Tomorrow should be greater than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isGreaterThan(yesterdayDate), 'Yesterday should not be greater than YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThan(tomorrowDate), 'Tomorrow should be greater than YESTERDAY');
    }

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isFalse(yesterdayComparator.isLessThan(now), 'Now should not be less than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThan(today), 'Today should not be less than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThan(yesterdayDatetime), 'Yesterday should not be less than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThan(tomorrowDatetime), 'Tomorrow should not be less than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThan(yesterdayDate), 'Yesterday should not be less than YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThan(tomorrowDate), 'Tomorrow should not be less than YESTERDAY');
        Assert.isTrue(yesterdayComparator.isLessThan(oneWeekAgoDatetime), 'One week ago should be less than YESTERDAY');
        Assert.isTrue(yesterdayComparator.isLessThan(oneWeekAgoNowDate), 'One week ago should be less than YESTERDAY');
    }

    @isTest
    static void ensureLessThanOrEqualWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isTrue(yesterdayComparator.isLessThanOrEqual(yesterdayDatetime), 'YESTERDAY should be less than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isLessThanOrEqual(yesterdayDate), 'YESTERDAY should be less than or equal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThanOrEqual(now), 'Now should not be less than or equal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThanOrEqual(today), 'Today should not be less than or equal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThanOrEqual(tomorrowDatetime), 'Tomorrow should not be less than or equal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isLessThanOrEqual(tomorrowDate), 'Tomorrow should not be less than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isLessThanOrEqual(oneWeekAgoDatetime), 'One week ago should be less than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isLessThanOrEqual(oneWeekAgoNowDate), 'One week ago should be less than or equal to YESTERDAY');
    }

    @isTest
    static void ensureGreaterThanOrEqualWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isTrue(yesterdayComparator.isGreaterThanOrEqual(yesterdayDatetime), 'YESTERDAY should be greater than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThanOrEqual(yesterdayDate), 'YESTERDAY should be greater than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThanOrEqual(now), 'Now should be greater than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThanOrEqual(today), 'Today should be greater than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThanOrEqual(tomorrowDatetime), 'Tomorrow should be greater than or equal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isGreaterThanOrEqual(tomorrowDate), 'Tomorrow should be greater than or equal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isGreaterThanOrEqual(oneWeekAgoDatetime), 'One week ago should not be greater than or equal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isGreaterThanOrEqual(oneWeekAgoNowDate), 'One week ago should not be greater than or equal to YESTERDAY');
    }

    @isTest
    static void ensureNotEqualWorks() {
        DateLiteralComparable yesterdayComparator = new YesterdayComparable();
        Assert.isFalse(yesterdayComparator.isNotEqual(yesterdayDatetime), 'YESTERDAY should not be unequal to YESTERDAY');
        Assert.isFalse(yesterdayComparator.isNotEqual(yesterdayDate), 'YESTERDAY should not be unequal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isNotEqual(now), 'Now should be unequal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isNotEqual(today), 'Today should be unequal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isNotEqual(tomorrowDatetime), 'Tomorrow should be unequal to YESTERDAY');
        Assert.isTrue(yesterdayComparator.isNotEqual(tomorrowDate), 'Tomorrow should be unequal to YESTERDAY');
    }
}