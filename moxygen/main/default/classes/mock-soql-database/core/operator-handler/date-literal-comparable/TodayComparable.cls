public with sharing class TodayComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime today = GMT.dateTime(Gmt.today());
        return today <= fieldValue && fieldValue < today.addDays(1);
    }
}