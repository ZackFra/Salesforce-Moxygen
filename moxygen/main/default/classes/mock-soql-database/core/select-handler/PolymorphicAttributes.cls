public with sharing class PolymorphicAttributes extends Attributes {
    public PolymorphicAttributes(SObject record) {
        super(record);
        Schema.SObjectType polymorphicSObjectSot = SchemaService.getPolymorphicSObjectType();
        String polymorphicSObjectName = SchemaService.getSObjectName(polymorphicSObjectSot);
        this.type = polymorphicSObjectName;
    }
}