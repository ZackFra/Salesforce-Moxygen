public inherited sharing class Aggregate {
    
    Map<String, Object> data;

    public Aggregate(AggregateResult ar) {
        data = ar.getPopulatedFieldsAsMap();
    }

    @TestVisible
    public Aggregate(Map<String, Object> data) {
        this.data = data;
    }

    /**
     * @description get the value of a field
     * @param field the field to get
     * @return the value of the field
     */
    public Object get(String field) {
        return data.get(field);
    }

    /**
     * @description get the value of the aggregate as a String
     * @return the value of the field as a string
     */
    public override String toString() {
        return data.toString();
    }
}