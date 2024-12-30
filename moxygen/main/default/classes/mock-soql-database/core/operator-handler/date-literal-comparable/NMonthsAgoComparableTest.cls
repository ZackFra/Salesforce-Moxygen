@isTest
private class NMonthsAgoComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable().withToken('n_months_ago:5');
        Assert.isFalse(nMonthsAgoComparable.isEqual(Gmt.today().addMonths(-1)), 'Last month should not be equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isEqual(Gmt.today().addMonths(-5)), '5 months ago should be equal to N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isEqual(Gmt.today().addMonths(-6)), '6 months ago should not be equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isEqual(Gmt.today().toStartOfMonth().addMonths(-5).addDays(15)), 'Middle of 5 months ago should be equal to N_MONTHS_AGO:5');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable().withToken('n_months_ago:5');
        Assert.isFalse(nMonthsAgoComparable.isLessThan(Gmt.today().addMonths(-1)), 'Last month should not be less than N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isLessThan(Gmt.today().addMonths(-5)), '5 months ago should not be less than N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isLessThan(Gmt.today().addMonths(-6)), '6 months ago should be less than N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isLessThan(Gmt.today().toStartOfMonth().addMonths(-5).addDays(15)), 'Middle of 5 months ago should not be less than N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isLessThan(Gmt.today().addMonths(-4)), '4 months ago should not be less than N_MONTHS_AGO:5');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable().withToken('n_months_ago:5');
        Assert.isTrue(nMonthsAgoComparable.isGreaterThan(Gmt.today().addMonths(-1)), 'Last month should be greater than N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isGreaterThan(Gmt.today().addMonths(-5)), '5 months ago should not be greater than N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isGreaterThan(Gmt.today().addMonths(-6)), '6 months ago should not be greater than N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isGreaterThan(Gmt.today().toStartOfMonth().addMonths(-5).addDays(15)), 'Middle of 5 months ago should not be greater than N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isGreaterThan(Gmt.today().addMonths(-4)), '4 months ago should be greater than N_MONTHS_AGO:5');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable().withToken('n_months_ago:5');
        Assert.isFalse(nMonthsAgoComparable.isLessThanOrEqual(Gmt.today().addMonths(-1)), 'Last month should not be less than or equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isLessThanOrEqual(Gmt.today().addMonths(-5)), '5 months ago should be less than or equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isLessThanOrEqual(Gmt.today().addMonths(-6)), '6 months ago should be less than or equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isLessThanOrEqual(Gmt.today().toStartOfMonth().addMonths(-5).addDays(15)), 'Middle of 5 months ago should be less than or equal to N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isLessThanOrEqual(Gmt.today().addMonths(-4)), '4 months ago should not be less than or equal to N_MONTHS_AGO:5');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable().withToken('n_months_ago:5');
        Assert.isTrue(nMonthsAgoComparable.isGreaterThanOrEqual(Gmt.today().addMonths(-1)), 'Last month should be greater than or equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isGreaterThanOrEqual(Gmt.today().addMonths(-5)), '5 months ago should be greater than or equal to N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isGreaterThanOrEqual(Gmt.today().addMonths(-6)), '6 months ago should not be greater than or equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isGreaterThanOrEqual(Gmt.today().toStartOfMonth().addMonths(-5).addDays(15)), 'Middle of 5 months ago should be greater than or equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isGreaterThanOrEqual(Gmt.today().addMonths(-4)), '4 months ago should be greater than or equal to N_MONTHS_AGO:5');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable().withToken('n_months_ago:5');
        Assert.isTrue(nMonthsAgoComparable.isNotEqual(Gmt.today().addMonths(-1)), 'Last month should not be equal to N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isNotEqual(Gmt.today().addMonths(-5)), '5 months ago should be equal to N_MONTHS_AGO:5');
        Assert.isTrue(nMonthsAgoComparable.isNotEqual(Gmt.today().addMonths(-6)), '6 months ago should not be equal to N_MONTHS_AGO:5');
        Assert.isFalse(nMonthsAgoComparable.isNotEqual(Gmt.today().toStartOfMonth().addMonths(-5).addDays(15)), 'Middle of 5 months ago should be equal to N_MONTHS_AGO:5');
    }
}