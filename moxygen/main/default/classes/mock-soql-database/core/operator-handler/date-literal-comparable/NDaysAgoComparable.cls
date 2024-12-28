public with sharing class NDaysAgoComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String nDaysValue = this.token.split(':')[1];
        Integer nDays = Integer.valueOf(nDaysValue);
        DateTime nDaysAgo = Gmt.today().addDays(-nDays);
        return nDaysAgo <= fieldValue && fieldValue < nDaysAgo.addDays(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nDaysValue = this.token.split(':')[1];
        Integer nDays = Integer.valueOf(nDaysValue);
        DateTime nDaysAgo = Gmt.today().addDays(-nDays);
        return fieldValue >= nDaysAgo.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        String nDaysValue = this.token.split(':')[1];
        Integer nDays = Integer.valueOf(nDaysValue);
        DateTime nDaysAgo = Gmt.today().addDays(-nDays);
        return fieldValue < nDaysAgo;
    }
}