public with sharing class Next90DaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime next90Days = Gmt.today().addDays(90);
        DateTime startTime = Gmt.today();
        return startTime <= fieldValue && fieldValue <= next90Days;
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime next90Days = Gmt.today().addDays(90);
        return fieldValue > next90Days;
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today();
    }
}