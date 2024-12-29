@isTest
private class NextNDaysComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable().withToken('next_n_days:5');
        Assert.isFalse(nextNDaysComparable.isEqual(Gmt.today().addDays(-1)), 'Yesterday should not be equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isEqual(Date.today()), 'Date should be equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isEqual(Date.today().addDays(1)), 'Date + 1 day should be equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isEqual(Date.today().addDays(4)), 'Date + 4 days should be equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isEqual(Date.today().addDays(5)), '5 days from now should be equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isEqual(Date.today().addDays(6)), '5 days + 1 day from now should not be equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isEqual(Date.today().addMonths(5)), '5 months from now should not be equal to NEXT_N_DAYS:5');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable().withToken('next_n_days:5');
        Assert.isTrue(nextNDaysComparable.isLessThan(Gmt.today().addDays(-7)), 'Last week should be less than NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isLessThan(Gmt.today().addDays(-1)), 'Yesterday should be less than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isLessThan(Date.today()), 'Date should not be less than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isLessThan(Date.today().addDays(1)), 'Date + 1 day should not be less than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isLessThan(Date.today().addDays(4)), 'Date + 4 days should not be less than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isLessThan(Date.today().addDays(5)), '5 days from now should not be less than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isLessThan(Date.today().addDays(6)), '5 days + 1 day from now should not be less than NEXT_N_DAYS:5');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable().withToken('next_n_days:5');
        Assert.isFalse(nextNDaysComparable.isGreaterThan(Gmt.today()), 'Date should not be greater than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isGreaterThan(Date.today().addDays(1)), 'Date + 1 day should not be greater than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isGreaterThan(Date.today().addDays(4)), 'Date + 4 days should not be greater than NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isGreaterThan(Date.today().addDays(5)), '5 days from now should not be greater than NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThan(Date.today().addDays(6)), '5 days + 1 day from now should be greater than NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThan(Date.today().addMonths(5)), '5 months from now should be greater than NEXT_N_DAYS:5');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable().withToken('next_n_days:5');
        Assert.isTrue(nextNDaysComparable.isLessThanOrEqual(Gmt.today().addDays(-7)), 'Last week should be less than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isLessThanOrEqual(Gmt.today().addDays(-1)), 'Yesterday should be less than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isLessThanOrEqual(Date.today()), 'Date should be less than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isLessThanOrEqual(Date.today().addDays(1)), 'Date + 1 day should be less than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isLessThanOrEqual(Date.today().addDays(4)), 'Date + 4 days should be less than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isLessThanOrEqual(Date.today().addDays(5)), '5 days from now should be less than or equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isLessThanOrEqual(Date.today().addDays(6)), '5 days + 1 day from now should not be less than or equal to NEXT_N_DAYS:5');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable().withToken('next_n_days:5');
        Assert.isFalse(nextNDaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(-7)), 'Last week should not be greater than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThanOrEqual(Date.today()), 'Date should be greater than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThanOrEqual(Date.today().addDays(1)), 'Date + 1 day should be greater than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThanOrEqual(Date.today().addDays(4)), 'Date + 4 days should be greater than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThanOrEqual(Date.today().addDays(5)), '5 days from now should be greater than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThanOrEqual(Date.today().addDays(6)), '5 days + 1 day from now should be greater than or equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isGreaterThanOrEqual(Date.today().addMonths(5)), '5 months from now should be greater than or equal to NEXT_N_DAYS:5');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable().withToken('next_n_days:5');
        Assert.isTrue(nextNDaysComparable.isNotEqual(Gmt.today().addDays(-1)), 'Yesterday should not be equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isNotEqual(Gmt.today()), 'Date should not be not equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isNotEqual(Date.today().addDays(1)), 'Date + 1 day should not be not equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isNotEqual(Date.today().addDays(4)), 'Date + 4 days should not be not equal to NEXT_N_DAYS:5');
        Assert.isFalse(nextNDaysComparable.isNotEqual(Date.today().addDays(5)), '5 days from now should not be not equal to NEXT_N_DAYS:5');
        Assert.isTrue(nextNDaysComparable.isNotEqual(Date.today().addDays(6)), '5 days + 1 day from now should be not equal to NEXT_N_DAYS:5');

    }
}