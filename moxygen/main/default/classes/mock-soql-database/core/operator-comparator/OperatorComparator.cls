public with sharing class OperatorComparator {
    private String operation;
    public OperatorComparator(String operation) {
        this.operation = operation;
    }

    public String getOperator() {
        return this.operation;
    }

    public Boolean compare(Object value1, Object value2) {
        Boolean result = false;
        ObjectComparator comparator = new ObjectComparator();
        Integer comparisonValue = comparator.compare(value1, value2);
        if(operation == '=') {
            result = (comparisonValue == 0);
        } else if(operation == '<') {
            result = (comparisonValue < 0);
        } else if(operation == '<=') {
            result = (comparisonValue <= 0);
        } else if(operation == '>') {
            result = (comparisonValue > 0);
        } else if(operation == '>=') {
            result = (comparisonValue >= 0);
        } else if(operation == '!=' || operation == '<>') {
            result = (comparisonValue != 0);
        }
        return result;
    }
}