/**
 * @description Comprable for LAST_N_QUARTERS
 * @author Zackary Frazier
 * @since 2/5/2025
 * @group Soql Engine
 */
public with sharing class LastNQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime thisCalendarQuarter = Datetime.newInstanceGmt(
            Gmt.today().year(),
            Math.mod((Integer) Math.ceil(Gmt.today().month() / 3), 4) + 1,
            1
        );
        Datetime startingQuarter = thisCalendarQuarter.addMonths(-3 * this.n);
        return fieldValue < startingQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime thisCalendarQuarter = Datetime.newInstanceGmt(
            Gmt.today().year(),
            Math.mod((Integer) Math.ceil(Gmt.today().month() / 3), 4) + 1,
            1
        );
        return fieldValue >= thisCalendarQuarter;
    }
}
