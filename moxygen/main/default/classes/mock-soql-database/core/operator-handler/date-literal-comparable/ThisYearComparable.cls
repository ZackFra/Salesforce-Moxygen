public with sharing class ThisYearComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        return fieldValue.yearGmt() == Gmt.today().year();
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue.yearGmt() < Gmt.today().year();
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue.yearGmt() > Gmt.today().year();
    }
}