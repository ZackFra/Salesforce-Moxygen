public with sharing class NextWeekComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue)  {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(7);
        return startOfWeek <= fieldValue && fieldValue < startOfWeek.addDays(7);
    }

    public override Boolean isGreaterThan(DateTime fieldValue)  {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(7);
        return fieldValue >= startOfWeek.addDays(7);
    }

    public override Boolean isLessThan(DateTime fieldValue)  {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(7);
        return fieldValue < startOfWeek;
    }
}