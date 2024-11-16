public with sharing class ComparisonHandler implements IOperatorHandler {
    public OperatorComparator handler;
    public ComparisonHandler(String operator) {
        this.handler = new OperatorComparator(operator);
    }

    static Set<String> ALLOWS_NULL = new Set<String> { '=', '<>', '!=' };

    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {

        if(fieldValue == null && !ALLOWS_NULL.contains(this.handler.getOperator())) {
            throw new QueryException('Invalid comparison with null value');
        }

        if(sObjectFieldValue instanceof Date) {
            if(fieldValue == Token.TODAY_LITERAL) {
                return this.handler.compare((Date) sObjectFieldValue, System.today());
            }    
            fieldValue = Common.parseDate((String) fieldValue);
            return this.handler.compare(fieldValue, (Date) sObjectFieldValue);
        } else if(SObjectFieldValue instanceof DateTime) {
            if(fieldValue == Token.TODAY_LITERAL) {
                Date sObjectFieldValueAsDate = ((DateTime) sObjectFieldValue).date();
                return this.handler.compare(sObjectFieldValueAsDate, System.today());
            }
            fieldValue = Common.parseDateTime((String) fieldValue);
            return this.handler.compare(fieldValue, (DateTime) sObjectFieldValue);
        } else if(SObjectFieldValue instanceof Time) {
            fieldValue = Common.parseTime((String) fieldValue);
            return this.handler.compare(fieldValue, (Time) sObjectFieldValue);
        }

        return this.handler.compare(sObjectFieldValue, fieldValue);
    }
}