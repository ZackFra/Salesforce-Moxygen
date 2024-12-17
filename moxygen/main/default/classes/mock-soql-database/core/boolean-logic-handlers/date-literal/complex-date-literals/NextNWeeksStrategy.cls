public with sharing class NextNWeeksStrategy extends ComplexDateLiteralStrategy {
    public NextNWeeksStrategy() {
        super(new DateFormulas.Weeks());
    }

    public override DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        return resolve(GMT.today().toStartOfWeek());
    }
}