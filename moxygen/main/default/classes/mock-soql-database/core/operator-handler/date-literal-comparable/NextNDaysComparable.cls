public with sharing class NextNDaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime nextNDays = Gmt.today().addDays(days);
        return Gmt.today().addDays(1) <= fieldValue && fieldValue < nextNDays.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today().addDays(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime nextNDays = Gmt.today().addDays(days);
        return fieldValue >= nextNDays.addDays(1);
    }
}