@isTest
private class TodayComparableTest {

    static DateTime now = Gmt.now();
    static DateTime tomorrowDatetime = Gmt.today().addDays(1);
    static DateTime yesterdayDatetime = Gmt.today().addDays(-1);

    static Date today = Gmt.today();
    static Date tomorrowDate = today.addDays(1);
    static Date yesterdayDate = today.addDays(-1);

    @isTest
    static void ensureEqualsWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isTrue(todayComparator.isEqual(now), 'Today should be equal to now');
        Assert.isTrue(todayComparator.isEqual(today), 'Today should be equal to today');
        Assert.isFalse(todayComparator.isEqual(tomorrowDatetime), 'Today should not be equal to tomorrow');
        Assert.isFalse(todayComparator.isEqual(yesterdayDatetime), 'Today should not be equal to yesterday');
        Assert.isFalse(todayComparator.isEqual(tomorrowDate), 'Today should not be equal to tomorrow');
        Assert.isFalse(todayComparator.isEqual(yesterdayDate), 'Today should not be equal to yesterday');
    }

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isFalse(todayComparator.isLessThan(now), 'Now should not be less than TODAY');
        Assert.isFalse(todayComparator.isLessThan(today), 'Today should not be less than TODAY');
        Assert.isTrue(todayComparator.isLessThan(yesterdayDatetime), 'Yesterday should be less than TODAY');
        Assert.isFalse(todayComparator.isLessThan(tomorrowDatetime), 'Tomorrow should not be less than TODAY');
        Assert.isTrue(todayComparator.isLessThan(yesterdayDate), 'Yesterday should be less than TODAY');
        Assert.isFalse(todayComparator.isLessThan(tomorrowDate), 'Tomorrow should not be less than TODAY');
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isFalse(todayComparator.isGreaterThan(now), 'Now should not be greater than TODAY');
        Assert.isFalse(todayComparator.isGreaterThan(today), 'Today should not be greater than TODAY');
        Assert.isFalse(todayComparator.isGreaterThan(yesterdayDatetime), 'Yesterday should not be greater than TODAY');
        Assert.isTrue(todayComparator.isGreaterThan(tomorrowDatetime), 'Tomorrow should be greater than TODAY');
        Assert.isFalse(todayComparator.isGreaterThan(yesterdayDate), 'Yesterday should not be greater than TODAY');
        Assert.isTrue(todayComparator.isGreaterThan(tomorrowDate), 'Tomorrow should be greater than TODAY');
    }

    @isTest
    static void ensureNotEqualsWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isFalse(todayComparator.isNotEqual(now), 'Now should be equal to TODAY');
        Assert.isFalse(todayComparator.isNotEqual(today), 'Today should be equal to TODAY');
        Assert.isTrue(todayComparator.isNotEqual(tomorrowDatetime), 'Tomorrow should not be equal to TODAY');
        Assert.isTrue(todayComparator.isNotEqual(yesterdayDatetime), 'Yesterday should not be equal to TODAY');
        Assert.isTrue(todayComparator.isNotEqual(tomorrowDate), 'Tomorrow should not be equal to TODAY');
        Assert.isTrue(todayComparator.isNotEqual(yesterdayDate), 'Yesterday should not be equal to TODAY');
    }

    @isTest
    static void ensureLessThanOrEqualWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isTrue(todayComparator.isLessThanOrEqual(now), 'Now should be less than or equal to TODAY');
        Assert.isTrue(todayComparator.isLessThanOrEqual(today), 'Today should be less than or equal to TODAY');
        Assert.isTrue(todayComparator.isLessThanOrEqual(yesterdayDatetime), 'Yesterday should be less than or equal to TODAY');
        Assert.isFalse(todayComparator.isLessThanOrEqual(tomorrowDatetime), 'Tomorrow should not be less than or equal to TODAY');
        Assert.isTrue(todayComparator.isLessThanOrEqual(yesterdayDate), 'Yesterday should be less than or equal to TODAY');
        Assert.isFalse(todayComparator.isLessThanOrEqual(tomorrowDate), 'Tomorrow should not be less than or equal to TODAY');
    }

    @isTest
    static void ensureGreaterThanOrEqualWorks() {
        DateLiteralComparable todayComparator = new TodayComparable();
        Assert.isTrue(todayComparator.isGreaterThanOrEqual(now), 'Now should be greater than or equal to TODAY');
        Assert.isTrue(todayComparator.isGreaterThanOrEqual(today), 'Today should be greater than or equal to TODAY');
        Assert.isFalse(todayComparator.isGreaterThanOrEqual(yesterdayDatetime), 'Yesterday should not be greater than or equal to TODAY');
        Assert.isTrue(todayComparator.isGreaterThanOrEqual(tomorrowDatetime), 'Tomorrow should be greater than or equal to TODAY');
        Assert.isFalse(todayComparator.isGreaterThanOrEqual(yesterdayDate), 'Yesterday should not be greater than or equal to TODAY');
        Assert.isTrue(todayComparator.isGreaterThanOrEqual(tomorrowDate), 'Tomorrow should be greater than or equal to TODAY');
    }
}