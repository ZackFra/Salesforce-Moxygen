public with sharing class NextMonthComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.dateTime(Gmt.today().toStartOfMonth().addMonths(1));
        return startOfNextMonth <= fieldValue && fieldValue < startOfNextMonth.addMonths(1);
    }
}