public with sharing class NextNWeeksComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime nextNWeeks = Gmt.today().addDays(Integer.valueOf(nWeeks) * 7);
        return Gmt.today() <= fieldValue && fieldValue < nextNWeeks.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today();
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime nextNWeeks = Gmt.today().addDays(Integer.valueOf(nWeeks) * 7);
        return fieldValue >= nextNWeeks.addDays(1);
    }
}