public with sharing class YesterdayComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        Date yesterday = GMT.today().addDays(-1);
        return yesterday <= (DateTime) fieldValue && (DateTime) fieldValue < GMT.today();
    }
}