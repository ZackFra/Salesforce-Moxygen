public inherited sharing class Aggregate {
    
    Map<String, Object> data;

    public Aggregate(AggregateResult ar) {
        data = ar.getPopulatedFieldsAsMap();
    }

    @TestVisible
    public Aggregate(Map<String, Object> data) {
        this.data = data;
    }

    public Object get(String field) {
        return data.get(field);
    }
}