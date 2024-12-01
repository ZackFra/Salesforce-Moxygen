public abstract class ComplexDateLiteralStrategy {

    public abstract DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue);

    protected DateLiteral resolve(String fieldValue, Schema.DisplayType fieldType, Object recordFieldValue) {
        Date newRecordFieldValue = null;
        if(fieldType== Schema.DisplayType.DATETIME) {
            newRecordFieldValue = (Date) GMT.date((DateTime) recordFieldValue);
        }
        return new DateLiteral.Builder()
            .setFieldValue(fieldValue)
            .setNewRecordFieldValue(newRecordFieldValue)
            .build();
    }
}