public with sharing class Last90DaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOf90Days = Gmt.dateTime(Gmt.today().addDays(-90));
        return startOf90Days <= fieldValue && fieldValue <= Gmt.now();
    }
}