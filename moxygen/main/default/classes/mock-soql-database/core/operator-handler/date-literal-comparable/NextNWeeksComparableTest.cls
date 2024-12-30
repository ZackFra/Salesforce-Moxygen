@isTest
private class NextNWeeksComparableTest {

    @isTest
    static void ensureIsEqualWorks(){
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable().withToken('next_n_weeks:5');
        Assert.isFalse(nextNWeeksComparable.isEqual(Gmt.today().toStartOfWeek()), 'Start of week should not be equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isEqual(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should not be equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isEqual(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should not be equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isEqual(Gmt.today().toStartOfWeek().addDays(35)), '5 weeks from now should be equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isEqual(Gmt.today().toStartOfWeek().addDays(36)), '5 weeks + 1 day from now should not be equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isEqual(Gmt.today().addMonths(5)), '5 months from now should not be equal to NEXT_N_WEEKS:5');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable().withToken('next_n_weeks:5');
        Assert.isTrue(nextNWeeksComparable.isLessThan(Gmt.today().toStartOfWeek()), 'Start of week should be less than NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isLessThan(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should be less than NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isLessThan(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should be less than NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isLessThan(Gmt.today().toStartOfWeek().addDays(35)), '5 weeks from now should not be less than NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isLessThan(Gmt.today().toStartOfWeek().addDays(36)), '5 weeks + 1 day from now should not be less than NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isLessThan(Gmt.today().addMonths(5)), '5 months from now should not be less than NEXT_N_WEEKS:5');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable().withToken('next_n_weeks:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThan(Gmt.today().toStartOfWeek()), 'Start of week should not be greater than NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThan(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should not be greater than NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThan(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should not be greater than NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThan(Gmt.today().toStartOfWeek().addDays(35)), '5 weeks from now should not be greater than NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isGreaterThan(Gmt.today().toStartOfWeek().addDays(36)), '5 weeks + 1 day from now should be greater than NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isGreaterThan(Gmt.today().addMonths(5)), '5 months from now should be greater than NEXT_N_WEEKS:5');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable().withToken('next_n_weeks:5');
        Assert.isTrue(nextNWeeksComparable.isLessThanOrEqual(Gmt.today().toStartOfWeek()), 'Start of week should be less than or equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should be less than or equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should be less than or equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(35)), '5 weeks from now should be less than or equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(36)), '5 weeks + 1 day from now should not be less than or equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isLessThanOrEqual(Gmt.today().addMonths(5)), '5 months from now should not be less than or equal to NEXT_N_WEEKS:5');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable().withToken('next_n_weeks:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThanOrEqual(Gmt.today().toStartOfWeek()), 'Start of week should not be greater than or equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should not be greater than or equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should not be greater than or equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(35)), '5 weeks from now should be greater than or equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(36)), '5 weeks + 1 day from now should be greater than or equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isGreaterThanOrEqual(Gmt.today().addMonths(5)), '5 months from now should be greater than or equal to NEXT_N_WEEKS:5');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable().withToken('next_n_weeks:5');
        Assert.isTrue(nextNWeeksComparable.isNotEqual(Gmt.today().toStartOfWeek()), 'Start of week should not be equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isNotEqual(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should not be equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isNotEqual(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should not be equal to NEXT_N_WEEKS:5');
        Assert.isFalse(nextNWeeksComparable.isNotEqual(Gmt.today().toStartOfWeek().addDays(35)), '5 weeks from now should be equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isNotEqual(Gmt.today().toStartOfWeek().addDays(36)), '5 weeks + 1 day from now should not be equal to NEXT_N_WEEKS:5');
        Assert.isTrue(nextNWeeksComparable.isNotEqual(Gmt.today().addMonths(5)), '5 months from now should not be equal to NEXT_N_WEEKS:5');
    }
}