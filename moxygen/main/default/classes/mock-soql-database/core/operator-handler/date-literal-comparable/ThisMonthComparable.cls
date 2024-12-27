public with sharing class ThisMonthComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.dateTime(Gmt.today().toStartOfMonth());
        return startOfMonth <= fieldValue && fieldValue < startOfMonth.addMonths(1);
    }
}