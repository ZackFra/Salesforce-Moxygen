public with sharing class LastNDaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.today().addDays(-days);
        return lastNDays <= fieldValue && fieldValue < Gmt.today().addDays(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.today().addDays(-days);
        return fieldValue >= Gmt.today().addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.today().addDays(-days);
        return fieldValue < lastNDays;
    }
}