public with sharing class LastMonthComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.dateTime(Gmt.today().toStartOfMonth().addMonths(-1));
        return startOfMonth <= fieldValue && fieldValue < startOfMonth.addMonths(1);
    }
}