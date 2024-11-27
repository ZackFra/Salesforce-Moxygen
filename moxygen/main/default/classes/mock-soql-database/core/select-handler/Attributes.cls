/**
 * @description Attributes for SObject 
 * @author Zackary Frazier
 * @since 11/26/2024
 */
public with sharing virtual class Attributes {
    public String url;
    public String type;

    /**
     * @description Constructor for normal SObject
     * @param record `SObject`
     */
    public Attributes(SObject record) {
        Map<String, Object> resultAttributes = this.getAttributes(record.Id);
        this.type = (String) resultAttributes.get('type');
        this.url = (String) resultAttributes.get('url');
    }

    /**
     * @description Get the attributes of the SObject
     * @param recordId `Id`
     * @return  `Map<String, Object>`
     */
    protected Map<String, Object> getAttributes(Id recordId) {
        SObject record = recordId.getSObjectType().newSObject(recordId);
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeObject(record);
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(gen.getAsString());
        Map<String, Object> resultAttributes = (Map<String, Object>) result.get('attributes');
        return resultAttributes;
    }
}