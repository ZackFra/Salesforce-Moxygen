public with sharing class NMonthsAgoComparable extends DateLiteralComparable {
    public override Boolean isEqual(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today().addMonths(-Integer.valueOf(nMonths));
        return nMonthsAgo <= fieldValue && fieldValue < nMonthsAgo.addMonths(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today().addMonths(-Integer.valueOf(nMonths));
        return fieldValue >= nMonthsAgo.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today().addMonths(-Integer.valueOf(nMonths));
        return fieldValue < nMonthsAgo;
    }
}