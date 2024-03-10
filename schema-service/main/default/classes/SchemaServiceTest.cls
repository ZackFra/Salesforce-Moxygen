@SuppressWarnings('PMD.CyclomaticComplexity')
@isTest
private class SchemaServiceTest {

    @isTest
    static void testDescribeField1() {
        Schema.SObjectField nameField = Schema.Account.Name;
        Test.startTest();
            Schema.DescribeFieldResult fieldResult = SchemaService.describeField(nameField);
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            fieldResult.getName(),
            'The field name should be "Name"'
        );
    }

    @isTest
    static void testDescribeField2() {
        String objectName = 'Account';
        String fieldName = 'Name';
        Test.startTest();
            Schema.DescribeFieldResult fieldResult = SchemaService.describeField(objectName, fieldName);
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            fieldResult.getName(),
            'The field name should be "Name"'
        );
    }

    @isTest
    static void testGetFieldType1() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        String fieldName = 'Name';
        Test.startTest();
            Schema.DisplayType fieldType = SchemaService.getFieldType(acctType, fieldName);
        Test.stopTest();
        Assert.areEqual(
            Schema.DisplayType.String, 
            fieldType,
            'The field type should be "String"'
        );
    }

    @isTest
    static void testGetFieldType2() {
        Schema.SObjectField nameField = Schema.Account.Name;
        Test.startTest();
            Schema.DisplayType fieldType = SchemaService.getFieldType(nameField);
        Test.stopTest();
        Assert.areEqual(
            Schema.DisplayType.String, 
            fieldType,
            'The field type should be "String"'
        );
    }

    @isTest
    static void getFieldName1() {
        Schema.SObjectField nameField = Schema.Account.Name;
        Test.startTest();
            String fieldName = SchemaService.getFieldName(nameField);
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            fieldName,
            'The field name should be "Name"'
        );
    }

    @isTest
    static void getFieldName2() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        String fieldName = 'Name';
        Test.startTest();
            String foundFieldName = SchemaService.getFieldName(acctType, fieldName);
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            foundFieldName,
            'The field name should be "Name"'
        );
    }

    @isTest
    static void getFieldName3() {
        Account acct = new Account(Name = 'Test Account');
        Test.startTest();
            String fieldName = SchemaService.getFieldName(acct, 'Name');
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            fieldName,
            'The field name should be "Name"'
        );
    }

    @isTest
    static void testGetSObjectType1() {
        Account acct = new Account(Name = 'Test Account');
        Test.startTest();
            Schema.SObjectType acctType = SchemaService.getSObjectType(acct);
        Test.stopTest();
        Assert.areEqual(
            Schema.Account.getSObjectType(), 
            acctType,
            'The SObjectType should be "Account"'
        );
    }

    @isTest
    static void testGetSObjectType2() {
        Id acctId = fflib_IDGenerator.generate(Account.SObjectType);
        Test.startTest();
            Schema.SObjectType acctType = SchemaService.getSObjectType(acctId);
        Test.stopTest();
        Assert.areEqual(
            Schema.Account.getSObjectType(), 
            acctType,
            'The SObjectType should be "Account"'
        );
    }

    @isTest
    static void testGetSObjectType3() {
        Test.startTest();
            Schema.SObjectType acctType = SchemaService.getSObjectType('Account');
        Test.stopTest();
        Assert.areEqual(
            Schema.Account.getSObjectType(), 
            acctType,
            'The SObjectType should be "Account"'
        );
    }

    @isTest
    static void testGetSObjectName1() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        Test.startTest();
            String acctName = SchemaService.getSObjectName(acctType);
        Test.stopTest();
        Assert.areEqual(
            'Account', 
            acctName,
            'The SObject name should be "Account"'
        );
    }

    @isTest
    static void testGetSObjectName2() {
        Id acctId = fflib_IDGenerator.generate(Account.SObjectType);
        Test.startTest();
            String acctName = SchemaService.getSObjectName(acctId);
        Test.stopTest();
        Assert.areEqual(
            'Account', 
            acctName,
            'The SObject name should be "Account"'
        );
    }

    @isTest
    static void testGetSObjectName3() {
        Test.startTest();
            String acctName = SchemaService.getSObjectName('Account');
        Test.stopTest();
        Assert.areEqual(
            'Account', 
            acctName,
            'The SObject name should be "Account"'
        );
    }

    @isTest
    static void testGetSObjectName4() {
        Account acct = new Account(Name = 'Test Account');
        Test.startTest();
            String acctName = SchemaService.getSObjectName(acct);
        Test.stopTest();
        Assert.areEqual(
            'Account', 
            acctName,
            'The SObject name should be "Account"'
        );
    }

    @isTest
    static void testBlankSObjectFrom1() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        Test.startTest();
            SObject acct = SchemaService.blankSObjectFrom(acctType);
        Test.stopTest();
        Assert.areEqual(
            'Account', 
            acct.getSObjectType().getDescribe().getName(),
            'The SObjectType should be "Account"'
        );
    }

    @isTest
    static void testBlankSObjectFrom2() {
        Test.startTest();
            SObject acct = SchemaService.blankSObjectFrom('Account');
        Test.stopTest();
        Assert.areEqual(
            'Account', 
            acct.getSObjectType().getDescribe().getName(),
            'The SObjectType should be "Account"'
        );
    }

    @isTest
    static void testGetChildRelationships() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        Test.startTest();
            List<Schema.ChildRelationship> childRelationships = SchemaService.getChildRelationships(acctType);
        Test.stopTest();
        Assert.areNotEqual(
            0, 
            childRelationships.size(),
            'There should be child relationships'
        );
    }

    @isTest
    static void testGetChildRelationshipName() {
        List<Schema.ChildRelationship> childRelationships = SchemaService.getChildRelationships(Schema.Account.getSObjectType());
        String childRelationshipName;
        Test.startTest();
        for (Schema.ChildRelationship cr : childRelationships) {
            childRelationshipName = SchemaService.getChildRelationshipName(cr);
            if(childRelationshipName == 'Contacts') {
                break;
            }
        }
        Test.stopTest();
        Assert.areEqual(
            'Contacts', 
            childRelationshipName,
            'The child relationship name should be "Contacts"'
        );
    }

    @isTest
    static void testGetRelationshipName() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        String fieldName = 'Owner';
        Test.startTest();
            String relationshipName = SchemaService.getRelationshipName(acctType, fieldName);
        Test.stopTest();
        Assert.areEqual(
            'Owner', 
            relationshipName,
            'The relationship name should be "Owner"'
        );
    }

    @isTest
    static void testGetFieldRelationshipName() {
        Schema.SObjectField ownerField = Schema.Account.OwnerId;
        Test.startTest();
            String relationshipName = SchemaService.getFieldRelationshipName(ownerField);
        Test.stopTest();
        Assert.areEqual(
            'Owner', 
            relationshipName,
            'The relationship name should be "Owner"'
        );
    }

    @isTest
    static void testGetChildRelationshipChildSObjectName() {
        List<Schema.ChildRelationship> childRelationships = SchemaService.getChildRelationships(Schema.Account.getSObjectType());
        String childSObjectName;
        Test.startTest();
        for (Schema.ChildRelationship cr : childRelationships) {
            childSObjectName = SchemaService.getChildRelationshipChildSObjectName(cr);
            if(childSObjectName == 'Contact') {
                break;
            }
        }
        Test.stopTest();
        Assert.areEqual(
            'Contact', 
            childSObjectName,
            'The child SObject name should be "Contact"'
        );
    }

    @isTest
    static void testGetChildRelationshipFieldName() {
        List<Schema.ChildRelationship> childRelationships = SchemaService.getChildRelationships(Schema.Account.getSObjectType());
        String childRelationshipFieldName;
        Test.startTest();
        for (Schema.ChildRelationship cr : childRelationships) {
            childRelationshipFieldName = SchemaService.getChildRelationshipFieldName(cr);
            if(childRelationshipFieldName == 'Contacts') {
                break;
            }
        }
        Test.stopTest();
        Assert.areEqual(
            'AccountId', 
            childRelationshipFieldName,
            'The child relationship field name should be "AccountId"'
        );
    }

    @isTest
    static void testIsFieldNumeric() {
        Schema.SObjectField numberField = Schema.Account.NumberOfEmployees;
        Test.startTest();
            Boolean isNumeric = SchemaService.isFieldNumeric(numberField.getDescribe().getType());
        Test.stopTest();
        Assert.isTrue(
            isNumeric,
            'The field should be numeric'
        );
    }

    @isTest
    static void testGetFields() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        Test.startTest();
            List<Schema.SObjectField> fields = SchemaService.getFields(acctType);
        Test.stopTest();
        Assert.areNotEqual(
            0, 
            fields.size(),
            'There should be fields'
        );
    }

    @isTest
    static void testGetField1() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        String fieldName = 'Name';
        Test.startTest();
            Schema.SObjectField field = SchemaService.getField(acctType, fieldName);
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            field.getDescribe().getName(),
            'The field name should be "Name"'
        );
    }

    @isTest
    static void testGetField2() {
        Account acct = new Account(Name = 'Test Account');
        String fieldName = 'Name';
        Test.startTest();
            Schema.SObjectField field = SchemaService.getField(acct, fieldName);
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            field.getDescribe().getName(),
            'The field name should be "Name"'
        );
    }

    @isTest
    static void testGetField3() {
        Test.startTest();
            Schema.SObjectField field = SchemaService.getField('Account', 'Name');
        Test.stopTest();
        Assert.areEqual(
            'Name', 
            field.getDescribe().getName(),
            'The field name should be "Name"'
        );
    }

    @isTest
    static void testGetReferenceTo() {
        Schema.SObjectField ownerField = Schema.Account.OwnerId;
        Test.startTest();
            List<Schema.SObjectType> referenceTo = SchemaService.getReferenceTo(ownerField);
        Test.stopTest();
        Assert.areNotEqual(
            0, 
            referenceTo.size(),
            'There should be reference to'
        );
    }

    @isTest
    static void testGetFieldNameForRelationship() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        String relationshipName = 'Owner';
        Test.startTest();
            String fieldName = SchemaService.getFieldNameForRelationship(acctType, relationshipName);
        Test.stopTest();
        Assert.areEqual(
            'OwnerId', 
            fieldName,
            'The field name should be "OwnerId"'
        );
    }

    @isTest
    static void testIsRelationshipPolymorphic() {
        Schema.SObjectType taskType = Schema.Task.getSObjectType();
        Test.startTest();
            Boolean isPolymorphic = SchemaService.isRelationshipPolymorphic(taskType, 'What');
        Test.stopTest();
        Assert.isTrue(
            isPolymorphic,
            'The relationship should be polymorphic'
        );
    }

    @isTest
    static void testIsFieldPolymorphic() {
        Schema.SObjectField ownerField = Schema.Account.OwnerId;
        Test.startTest();
            Boolean isPolymorphic = SchemaService.isFieldPolymorphic(ownerField);
        Test.stopTest();
        Assert.isFalse(
            isPolymorphic,
            'The field should not be polymorphic'
        );
    }

    @isTest
    static void testGetPolymorphicFields() {
        Test.startTest();
            List<Schema.SObjectField> polymorphicFields = SchemaService.getPolymorphicFields();
        Test.stopTest();
        Assert.areNotEqual(
            0, 
            polymorphicFields.size(),
            'There should be polymorphic fields'
        );
    }

    @isTest
    static void testGetPolymorphicFieldMap() {
        Test.startTest();
            Map<String, String> polymorphicFieldMap = SchemaService.getPolymorphicFieldMap();
        Test.stopTest();
        Assert.areNotEqual(
            0, 
            polymorphicFieldMap.size(),
            'There should be polymorphic fields'
        );
    }

    @isTest
    static void testGetFieldNames() {
        List<Schema.SObjectField> fields = SchemaService.getFields(Schema.Account.getSObjectType());
        Test.startTest();
            List<String> fieldNames = SchemaService.getFieldNames(fields);
        Test.stopTest();
        Assert.areNotEqual(
            0, 
            fieldNames.size(),
            'There should be field names'
        );
    }

    @isTest
    static void testGetPolymorphicSObjectType() {
        Test.startTest();
            Schema.SObjectType sObjectType = SchemaService.getPolymorphicSObjectType();
        Test.stopTest();
        Assert.areEqual(
            'Name',
            sObjectType.getDescribe().getName(), // NOPMD
            'SObjectType should be "Name"'
        );
    }

    @isTest
    static void testGetFieldSObjectType() {
        Schema.SObjectField parentField = Schema.Account.ParentId;
        Test.startTest();
            Schema.SObjectType sObjectType = SchemaService.getFieldSObjectType(parentField);
        Test.stopTest();
        Assert.areEqual(
            'Account',
            sObjectType.getDescribe().getName(), // NOPMD
            'SObjectType should be "Account"'
        );
    }

    @isTest
    static void testHasField() {
        Schema.SObjectType acctType = Schema.Account.getSObjectType();
        String fieldName = 'Name';
        Test.startTest();
            Boolean hasField = SchemaService.hasField(acctType, fieldName);
        Test.stopTest();
        Assert.isTrue(
            hasField,
            'The SObject should have the field'
        );
    }
}