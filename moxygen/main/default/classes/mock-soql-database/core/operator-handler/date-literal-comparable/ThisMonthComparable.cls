public with sharing class ThisMonthComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return startOfMonth <= fieldValue && fieldValue < startOfMonth.addMonths(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return fieldValue >= startOfMonth.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return fieldValue < startOfMonth;
    }
}