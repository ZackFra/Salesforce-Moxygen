/**
 * @description Attributes for polymorphic SObject 
 * @author Zackary Frazier
 * @since 11/26/2024
 */
public with sharing class PolymorphicAttributes extends Attributes {
    /**
     * @description Constructor, sets the type to the polymorphic SObject
     * @param record `SObject`
     */
    public PolymorphicAttributes(SObject record) {
        super(record);
        Schema.SObjectType polymorphicSObjectSot = SchemaService.getPolymorphicSObjectType();
        String polymorphicSObjectName = SchemaService.getSObjectName(polymorphicSObjectSot);
        this.type = polymorphicSObjectName;
    }
}