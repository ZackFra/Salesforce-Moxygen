public with sharing class Attributes {
    public String url;
    public String type;

    /**
     * @description Constructor for normal SObject
     * @param record 
     */
    public Attributes(SObject record) {
        Map<String, Object> resultAttributes = this.getAttributes(record.Id);
        this.type = (String) resultAttributes.get('type');
        this.url = (String) resultAttributes.get('url');
    }

    /**
     * @description Constructor for the polymorphic relationship
     * @param recordId 
     */
    public Attributes(Id recordId) {
        Schema.SObjectType polymorphicSObjectSot = SchemaService.getPolymorphicSObjectType();
        String polymorphicSObjectName = SchemaService.getSObjectName(polymorphicSObjectSot);
        this.type = polymorphicSObjectName;
        Map<String, Object> resultAttributes = getAttributes(recordId);
    }

    private Map<String, Object> getAttributes(Id recordId) {
        SObject record = recordId.getSObjectType().newSObject(recordId);
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeObject(record);
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(gen.getAsString());
        Map<String, Object> resultAttributes = (Map<String, Object>) result.get('attributes');
        return resultAttributes;
    }
}