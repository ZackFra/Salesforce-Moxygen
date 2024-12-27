public with sharing class LastNDaysComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.dateTime(Gmt.today().addDays(-days));
        return lastNDays <= fieldValue && fieldValue < Gmt.today().addDays(1);
    }
}