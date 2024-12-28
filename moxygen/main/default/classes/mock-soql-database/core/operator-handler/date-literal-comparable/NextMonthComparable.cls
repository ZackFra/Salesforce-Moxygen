public with sharing class NextMonthComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return startOfNextMonth <= fieldValue && fieldValue < startOfNextMonth.addMonths(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return fieldValue >= startOfNextMonth.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return fieldValue < startOfNextMonth;
    }
}