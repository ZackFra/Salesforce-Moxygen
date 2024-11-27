public with sharing class Attributes {
    public String url;
    public String type;

    /**
     * @description Constructor
     * @param record 
     */
    public Attributes(SObject record) {
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeObject(record);
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(gen.getAsString());
        Map<String, Object> resultAttributes = (Map<String, Object>) result.get('attributes');
        this.type = (String) resultAttributes.get('type');
        this.url = (String) resultAttributes.get('url');
    }
}