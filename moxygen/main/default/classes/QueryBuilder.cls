public inherited sharing class QueryBuilder {

    private class QueryBuilderException extends Exception {}

    public class QueryBuilderSelectIntermediary {
        String query;

        public QueryBuilderSelectIntermediary(String query) {
            this.query = query;
        }

        public QueryBuilderFromIntermediary doFrom(Schema.SObjectType sObjectType) {
            this.query += ' FROM ' + sObjectType.getDescribe().getName();
            return new QueryBuilderFromIntermediary(this.query);
        }
    }

    public class QueryBuilderFromIntermediary {
        String query;

        public QueryBuilderFromIntermediary(String query) {
            this.query = query;
        }

        public override String toString() {
            return this.query;
        }
    }
    
    public static QueryBuilderSelectIntermediary doSelect(Object field) {
        if(!(field instanceof Schema.SObjectField) && !(field instanceof QueryBuilderSelectIntermediary)) {
            throw new QueryBuilderException('Value must be a field or subquery');
        }

        if(field instanceof Schema.SObjectField) {
            Schema.SObjectField schemaField = (Schema.SObjectField) field;
            return new QueryBuilderSelectIntermediary('SELECT ' + schemaField.getDescribe().getName());
        } else {
            throw new QueryBuilderException('Value must be a field or subquery');
        }
    }
}