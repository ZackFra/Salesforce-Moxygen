public inherited sharing class NextWeekStrategy implements IComplexDateLiteralStrategy  {
    public DateLiteral resolve(Schema.DisplayType fieldType, Object recordFieldValue) {
        String fieldValue = Common.dateToSoqlString(GMT.today().addDays(7).toStartOfWeek());
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