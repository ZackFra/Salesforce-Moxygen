public with sharing class NextNWeeksComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime nextNWeeks = Gmt.today().toStartOfWeek().addDays(Integer.valueOf(nWeeks) * 7);
        return Gmt.today().toStartOfWeek().addDays(7) <= fieldValue && fieldValue < nextNWeeks.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today().toStartOfWeek().addDays(7);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime nextNWeeks = Gmt.today().toStartOfWeek().addDays(Integer.valueOf(nWeeks) * 7);
        return fieldValue >= nextNWeeks.addDays(1);
    }
}