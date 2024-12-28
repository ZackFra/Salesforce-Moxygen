public with sharing class LastMonthComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-1);
        return startOfMonth <= fieldValue && fieldValue < startOfMonth.addMonths(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-1);
        return fieldValue >= startOfMonth.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-1);
        return fieldValue < startOfMonth;
    }
}