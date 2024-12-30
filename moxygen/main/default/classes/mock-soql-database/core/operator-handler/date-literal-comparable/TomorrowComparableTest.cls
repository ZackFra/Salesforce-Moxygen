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
    static void ensureEqualWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isTrue(tomorrowComparator.isEqual(tomorrowDatetime), 'Tomorrow should be equal to now');
        Assert.isTrue(tomorrowComparator.isEqual(tomorrowDate), 'Tomorrow should be equal to today');
        Assert.isFalse(tomorrowComparator.isEqual(now), 'Tomorrow should not be equal to now');
        Assert.isFalse(tomorrowComparator.isEqual(today), 'Tomorrow should not be equal to today');
        Assert.isFalse(tomorrowComparator.isEqual(yesterdayDatetime), 'Tomorrow should not be equal to yesterday');
        Assert.isFalse(tomorrowComparator.isEqual(yesterdayDate), 'Tomorrow should not be equal to yesterday');
    }

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isTrue(tomorrowComparator.isLessThan(now), 'Now should be less than TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThan(today), 'Today should be less than TOMORROW');
        Assert.isFalse(tomorrowComparator.isLessThan(tomorrowDatetime), 'Tomorrow should not be less than TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThan(yesterdayDatetime), 'Yesterday should be less than TOMORROW');
        Assert.isFalse(tomorrowComparator.isLessThan(tomorrowDate), 'Tomorrow should not be less than TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThan(yesterdayDate), 'Yesterday should not less than TOMORROW');
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isFalse(tomorrowComparator.isGreaterThan(now), 'Now should not be greater than TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThan(today), 'Today should not be greater than TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThan(tomorrowDatetime), 'Tomorrow should not be greater than TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThan(yesterdayDatetime), 'Yesterday should not be greater than TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThan(tomorrowDate), 'Tomorrow should not be greater than TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThan(yesterdayDate), 'Yesterday should not be greater than TOMORROW');
    }

    @isTest
    static void ensureNotEqualWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isFalse(tomorrowComparator.isNotEqual(tomorrowDatetime), 'Tomorrow should be equal to TOMORROW');
        Assert.isFalse(tomorrowComparator.isNotEqual(tomorrowDate), 'Tomorrow should be equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isNotEqual(now), 'Now should not be equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isNotEqual(today), 'Today should not be equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isNotEqual(yesterdayDatetime), 'Yesterday should not be equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isNotEqual(yesterdayDate), 'Yesterday should not be equal to TOMORROW');
    }

    @isTest
    static void ensureGreaterThanOrEqualWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isFalse(tomorrowComparator.isGreaterThanOrEqual(now), 'Now should not be greater than or equal to TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThanOrEqual(today), 'Today should not be greater than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isGreaterThanOrEqual(tomorrowDatetime), 'Tomorrow should be greater than or equal to TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThanOrEqual(yesterdayDatetime), 'Yesterday should not be greater than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isGreaterThanOrEqual(tomorrowDate), 'Tomorrow should be greater than or equal to TOMORROW');
        Assert.isFalse(tomorrowComparator.isGreaterThanOrEqual(yesterdayDate), 'Yesterday should not be greater than or equal to TOMORROW');
    }

    @isTest
    static void ensureLessThanOrEqualWorks() {
        DateLiteralComparable tomorrowComparator = new TomorrowComparable();
        Assert.isTrue(tomorrowComparator.isLessThanOrEqual(now), 'Now should be less than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThanOrEqual(today), 'Today should be less than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThanOrEqual(tomorrowDatetime), 'Tomorrow should be less than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThanOrEqual(yesterdayDatetime), 'Yesterday should be less than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThanOrEqual(tomorrowDate), 'Tomorrow should be less than or equal to TOMORROW');
        Assert.isTrue(tomorrowComparator.isLessThanOrEqual(yesterdayDate), 'Yesterday should be less than or equal to TOMORROW');
        Assert.isFalse(tomorrowComparator.isLessThanOrEqual(oneWeekFromNowDateTime), 'One week from now should not be less than or equal to TOMORROW');
        Assert.isFalse(tomorrowComparator.isLessThanOrEqual(oneWeekFromNowDate), 'One week from now should not be less than or equal to TOMORROW');
    }
}