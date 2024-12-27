public with sharing class NextWeekComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue)  {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek().addDays(7));
        return startOfWeek <= fieldValue && fieldValue < startOfWeek.addDays(7);
    }
}