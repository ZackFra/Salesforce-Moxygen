public with sharing class Next90DaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime next90Days = Gmt.dateTime(Gmt.today().addDays(90));
        DateTime startTime = Gmt.dateTime(Gmt.today());
        return startTime <= fieldValue && fieldValue <= next90Days;
    }
}