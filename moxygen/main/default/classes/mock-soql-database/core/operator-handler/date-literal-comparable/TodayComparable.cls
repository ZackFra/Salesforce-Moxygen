public with sharing class TodayComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return today <= fieldValue && fieldValue < today.addDays(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return fieldValue >= today.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return fieldValue < today;
    }
}