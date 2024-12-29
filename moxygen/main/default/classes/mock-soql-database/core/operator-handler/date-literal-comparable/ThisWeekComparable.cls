public with sharing class ThisWeekComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return startOfWeek <= fieldValue && fieldValue < startOfWeek.addDays(7);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return fieldValue >= startOfWeek.addDays(7);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return fieldValue < startOfWeek;
    }
}