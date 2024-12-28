public with sharing class LastNWeeksComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime lastNWeeks = Gmt.today().addDays(-Integer.valueOf(nWeeks) * 7);
        return lastNWeeks <= fieldValue && fieldValue < Gmt.today().addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime lastNWeeks = Gmt.today().addDays(-Integer.valueOf(nWeeks) * 7);
        return fieldValue < lastNWeeks;
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today().addDays(1);
    }
}