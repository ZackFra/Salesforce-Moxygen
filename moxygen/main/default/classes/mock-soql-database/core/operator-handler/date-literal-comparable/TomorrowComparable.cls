public with sharing class TomorrowComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        Date tomorrow = GMT.today().addDays(1);
        return tomorrow <= (DateTime) fieldValue && (DateTime) fieldValue < tomorrow.addDays(1);
    }
}