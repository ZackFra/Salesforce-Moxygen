/**
 * @description Aggregate class to represent the result of an aggregate query
 */
public inherited sharing class Aggregate {
    
    private Map<String, Object> data;
    
    /**
     * @description Standard constructor, creates an Aggregate object from an AggregateResult
     * @param ar the AggregateResult to create the Aggregate from
     */
    public Aggregate(AggregateResult ar) {
        data = ar.getPopulatedFieldsAsMap();
    }

    /**
     * @description Constructor for testing purposes, creates an Aggregate object from a Map
     * @param data the data to create the Aggregate from
     */
    @TestVisible
    private Aggregate(Map<String, Object> data) {
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