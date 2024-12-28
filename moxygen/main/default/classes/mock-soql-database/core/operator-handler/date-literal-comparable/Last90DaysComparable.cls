public with sharing class Last90DaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOf90Days = Gmt.today().addDays(-90);
        return startOf90Days <= fieldValue && fieldValue <= Gmt.now();
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue > Gmt.now();
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOf90Days = Gmt.today().addDays(-90);
        return fieldValue < startOf90Days;
    }
}