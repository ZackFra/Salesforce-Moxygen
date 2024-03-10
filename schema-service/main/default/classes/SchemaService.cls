/**
 * @description this class is intended to handle interactions with the Schema class
 *              and provide a layer of abstraction for the Schema class, non-mutating
 *              string arguments to these methods are understood to be case-insensitive
 *              anything named "getName" are understood to return proper API names
 *              every argument is understood to be non-null
 */
@SuppressWarnings('PMD.CognitiveComplexity, PMD.CyclomaticComplexity, PMD.ExcessivePublicCount')
public inherited sharing class SchemaService {
    final private static List<Schema.DisplayType> NUMERIC_FIELD_TYPES = new List<Schema.DisplayType> {
        Schema.DisplayType.CURRENCY,
        Schema.DisplayType.DOUBLE,
        Schema.DisplayType.INTEGER,
        Schema.DisplayType.PERCENT
    };

    final private static String POLYMORPHIC_OBJECT = 'Name';

    private class SchemaServiceException extends Exception {}

    /**
     * @description Return the `Schema.DescribeFieldResult` for a given field
     * @param field `Schema.SObjectField` the field
     * @return  `Schema.DescribeFieldResult`
     */
    public static Schema.DescribeFieldResult describeField(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        return field.getDescribe();
    }

    /**
     * @description This method is used primarily to discover if a field is polymorphic, 
     * @param sObjApiName : the api name of the sObject
     * @param fieldApiName : the api name of the field
     * @return the describe field result
     */
    public static Schema.DescribeFieldResult describeField(String sObjApiName, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObjApiName' => sObjApiName,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);

        SObject record = blankSObjectFrom(sObjApiName);
        Schema.SObjectType sot = getSObjectType(record);
        Schema.SObjectField field = getField(sot, fieldApiName);
        Schema.DescribeFieldResult dfr = describeField(field);

        return dfr;
    }

    /**
     * @description this method returns the field type of a given field
     * @param sot the sobject type
     * @param fieldApiName the field api name
     * @return the field type
     */
    public static Schema.DisplayType getFieldType(Schema.SObjectType sot, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);

        fieldApiName = fieldApiName.toLowerCase();
        Schema.DescribeFieldResult field = sot.getDescribe().fields.getMap().get(fieldApiName).getDescribe();
        return field.getType();
    }

    /**
     * @description this method returns the field type of a given field
     * @param field the field
     * @return the field type
     */
    public static Schema.DisplayType getFieldType(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        return field.getDescribe().getType();
    }

    /**
     * @description this method returns the field name of a given field
     * @param field `Schema.SObjectField`
     * @return the field name
     */
    public static String getFieldName(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        return field.getDescribe().getName();
    }

    /**
     * @description this method returns the field name of a given field
     * @param sot the sobject type
     * @param fieldApiName the field api name
     * @return the field name
     */
    public static String getFieldName(Schema.SObjectType sot, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);

        fieldApiName = fieldApiName.toLowerCase();
        Schema.SObjectField field = sot.getDescribe().fields.getMap().get(fieldApiName);
        return field.getDescribe().getName();
    }

    /**
     * @description this method returns the field name of a given field
     * @param sObj the sobject
     * @param fieldApiName the field api name
     * @return the field name
     */
    public static String getFieldName(SObject sObj, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObj' => sObj,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);

        Schema.SObjectType sot = getSObjectType(sObj);
        return getFieldName(sot, fieldApiName);
    }

    /**
     * @description this method returns the type of a given SObject
     * @param sObj the sobject
     * @return the sobject type
     */
    public static Schema.SObjectType getSObjectType(SObject sObj) {
        Map<String, Object> args = new Map<String, Object> {
            'sObj' => sObj
        };
        Common.nullCheck(args);

        return sObj.getSObjectType();
    }

    /**
     * @description this method returns the type of a given record id
     * @param recordId the record id
     * @return the sobject type
     */
    public static Schema.SObjectType getSObjectType(Id recordId) {
        Map<String, Object> args = new Map<String, Object> {
            'recordId' => recordId
        };
        Common.nullCheck(args);

        return recordId.getSObjectType();
    }

    /**
     * @description this method returns the type of a given SObject
     * @param sObjApiName the sobject api name
     * @return the sobject type
     * @throws TypeException if the type is not found
     */
    public static Schema.SObjectType getSObjectType(String sObjApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObjApiName' => sObjApiName
        };
        Common.nullCheck(args);
        SObject sObj = (SObject) Type.forName(sObjApiName).newInstance();
        Schema.SObjectType sot = sObj.getSObjectType();
        return sot;
    }

    /**
     * @description this method returns the API name of a given SObject
     * @param sot the sobject type
     * @return the sobject api name
     */
    public static String getSObjectName(Schema.SObjectType sot) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot
        };
        Common.nullCheck(args);

        return sot.getDescribe().getName();
    }

    /**
     * @description this method returns the API name of a given SObject
     * @param recordId the record id
     * @return the sobject api name
     */
    public static String getSObjectName(Id recordId) {
        Map<String, Object> args = new Map<String, Object> {
            'recordId' => recordId
        };
        Common.nullCheck(args);

        return recordId.getSObjectType().getDescribe().getName();
    }

    /**
     * @description this method returns the API name of a given SObject
     * @param sObjName the sobject name
     * @return the sobject api name
     * @exception TypeException if the type is not found
     */
    public static String getSObjectName(String sObjName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObjName' => sObjName
        };
        Common.nullCheck(args);
        sObjName = sObjName.toLowerCase();

        Schema.SObjectType sot = getSObjectType(sObjName);
        return sot.getDescribe().getName();
    }

    /**
     * @description this method returns the API name of a given SObject
     * @param sObj the sobject
     * @return the sobject api name
     */
    public static String getSObjectName(SObject sObj) {
        Map<String, Object> args = new Map<String, Object> {
            'sObj' => sObj
        };
        Common.nullCheck(args);
        Schema.SObjectType sot = getSObjectType(sObj);
        String sObjName = sot.getDescribe().getName();
        return sObjName;
    }

    /**
     * @description this method returns the type of a given SObject
     * @param sot the sobject type
     * @return the sobject
     * @throws TypeException if the type is not found
     */
    public static SObject blankSObjectFrom(Schema.SObjectType sot) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot
        };
        Common.nullCheck(args);

        return sot.newSObject();
    }

    /**
     * @description this method returns the type of a given SObject
     * @param sObjApiName the sobject api name
     * @return the sobject
     * @throws TypeException if the type is not found
     */
    public static SObject blankSObjectFrom(String sObjApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObjApiName' => sObjApiName
        };
        Common.nullCheck(args);

        sObjApiName = sObjApiName.toLowerCase();

        return blankSObjectFrom(getSObjectType(sObjApiName));
    }
    
    /**
     * @description this method returns the child relationships of a given SObject type
     * @param sot the sobject type
     * @return the child relationships
     */
    public static List<Schema.ChildRelationship> getChildRelationships(Schema.SObjectType sot) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot
        };
        Common.nullCheck(args);

        return sot.getDescribe().getChildRelationships();
    }

    /**
     * @description this method returns the child relationship name of a given child relationship
     * @param childRelationship the child relationship
     * @return the child relationship name
     */
    public static String getChildRelationshipName(Schema.ChildRelationship childRelationship) {
        Map<String, Object> args = new Map<String, Object> {
            'childRelationship' => childRelationship
        };
        Common.nullCheck(args);

        return childRelationship.getRelationshipName();
    }

    /**
     * @description Given an sObject and a relationship name, return the relationship api name
     * @param sot : the child sObject type
     * @param relationshipName : the relationship name
     * @return : the field api name
     * @throws QueryException : if the relationship name is invalid
     */
    public static String getRelationshipName(Schema.SObjectType sot, String relationshipName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'relationshipName' => relationshipName
        };
        Common.nullCheck(args);
        relationshipName = relationshipName.toLowerCase();

        List<Schema.SObjectField> sObjFields = getFields(sot);
        for(Schema.SObjectField field : sObjFields) {
            Schema.DescribeFieldResult dfr = field.getDescribe();
            List<Schema.sObjectType> relatedSObjs = dfr.getReferenceTo();
            if(relatedSObjs.isEmpty()) {
                continue;
            }

            String fieldRelationshipApiName = dfr.getRelationshipName();
            if(fieldRelationshipApiName == null) {
                continue;
            }

            if(fieldRelationshipApiName.toLowerCase() != relationshipName) {
                continue;
            }
            return fieldRelationshipApiName;
        }
        throw new SchemaServiceException('Invalid relationship name: ' + relationshipName);
    }

    /**
     * @description this method returns the field relationship name of a given field
     * @param field the field
     * @return the field relationship name
     */
    public static String getFieldRelationshipName(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        return field.getDescribe().getRelationshipName();
    }

    /**
     * @description this method returns the child SObject name of a given child relationship
     * @param childRelationship the child relationship
     * @return the child relationship name
     */
    public static String getChildRelationshipChildSObjectName(Schema.ChildRelationship childRelationship) {
        Map<String, Object> args = new Map<String, Object> {
            'childRelationship' => childRelationship
        };
        Common.nullCheck(args);

        return childRelationship.getChildSObject().getDescribe().getName();
    }

    /**
     * @description this method returns the child relationship field name of a given child relationship
     * @param childRelationship the child relationship
     * @return the child relationship name
     */
    public static String getChildRelationshipFieldName(Schema.ChildRelationship childRelationship) {
        Map<String, Object> args = new Map<String, Object> {
            'childRelationship' => childRelationship
        };
        Common.nullCheck(args);

        return childRelationship.getField().getDescribe().getName();
    }
    
    /**
     * @description given a field type, this method returns whether the field is numeric or not
     * @param fieldType : the field type
     * @return : whether the field is numeric or not
     */
    public static Boolean isFieldNumeric(Schema.DisplayType fieldType) {
        Map<String, Object> args = new Map<String, Object> {
            'fieldType' => fieldType
        };
        Common.nullCheck(args);

        return NUMERIC_FIELD_TYPES.contains(fieldType);
    }

    /**
     * @description given an sObject type, return the fields
     * @param sot the sObject type
     * @return the fields
     */
    public static List<Schema.SObjectField> getFields(Schema.SObjectType sot) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot
        };
        Common.nullCheck(args);
        return sot.getDescribe().fields.getMap().values();
    }

    /**
     * @description Given an sObject and a field api name, return the field
     * @param sot : the sObject type
     * @param fieldApiName : the field api name
     * @return : the field
     */
    public static Schema.SObjectField getField(Schema.SObjectType sot, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);
        fieldApiName = fieldApiName.toLowerCase();

        return sot.getDescribe().fields.getMap().get(fieldApiName);
    }

    /**
     * @description Given an sObject and a field api name, return the field
     * @param sObj : the sObject
     * @param fieldApiName : the field api name
     * @return : the field
     */
    public static Schema.SObjectField getField(SObject sObj, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObj' => sObj,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);
        fieldApiName = fieldApiName.toLowerCase();

        Schema.SObjectType sot = getSObjectType(sObj);
        return getField(sot, fieldApiName);
    }

    /**
     * @description Returns the field for a given sObject API name and field API name
     * @param sObjApiName `String`
     * @param fieldApiName `String`
     * @return  `Schema.SObjectField`
     */
    public static Schema.SObjectField getField(String sObjApiName, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sObjApiName' => sObjApiName,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);
        sObjApiName = sObjApiName.toLowerCase();
        fieldApiName = fieldApiName.toLowerCase();

        Schema.SObjectType sot = getSObjectType(sObjApiName);
        return getField(sot, fieldApiName);
    }

    /**
     * @description Given an SObjectField, return the list of objects that the field references
     * @param field : the field
     * @return : the list of objects that the field references
     */
    public static List<SObjectType> getReferenceTo(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        return field.getDescribe().getReferenceTo();
    }

    /**
     * @description : given an sObject and a relationship name, return the field api name
     * @param sot : the sObject
     * @param relationshipName : the relationship name
     * @return : the field api name
     * @throws QueryException : if the relationship name is invalid
     */
    public static String getFieldNameForRelationship(Schema.SObjectType sot, String relationshipName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'relationshipName' => relationshipName
        };
        Common.nullCheck(args);
        relationshipName = relationshipName.toLowerCase();

        List<Schema.SObjectField> fields = getFields(sot);
        for (Schema.SObjectField field : fields) {
            Schema.DisplayType fieldType = getFieldType(field);
            
            String relationshipApiName = getFieldRelationshipName(field);
            if(relationshipApiName == null) {
                continue;
            }

            String lowerCaseRelationshipApiName = relationshipApiName.toLowerCase();
            Boolean isRelationshipEqual = (lowerCaseRelationshipApiName == relationshipName);
            if (fieldType == DisplayType.Reference && isRelationshipEqual) {
                return getFieldName(field);
            }
        }
        throw new QueryException('Invalid relationship name: ' + relationshipName);
    }

    /**
     * @description Given an sObject and a relationship name, return whether the relationship is polymorphic or not
     * @param sot `Schema.SObjectType` the sObject type
     * @param relationshipName `String` the relationship name
     * @return `Boolean` whether the field is polymorphic or not
     */
    public static Boolean isRelationshipPolymorphic(Schema.SObjectType sot, String relationshipName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'relationshipName' => relationshipName
        };
        Common.nullCheck(args);
        relationshipName = relationshipName.toLowerCase();

        String relationshipFieldApiName = getFieldNameForRelationship(sot, relationshipName);
        Schema.SObjectField relationshipField = getField(sot, relationshipFieldApiName);
        return isFieldPolymorphic(relationshipField);
    }

    /**
     * @description Given an sObject and a relationship name, return the field api name
     * @param field : the field
     * @return : whether the field is polymorphic or not
     */
    public static Boolean isFieldPolymorphic(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        List<Schema.SObjectType> relatedSObjs = getReferenceTo(field);
        return relatedSObjs.size() > 1;
    }

    /**
     * @description Returns the "Name" fields, where "Name" is the special SObject for polymorphic relationships
     * @return the name fields
     */
    public static List<Schema.SObjectField> getPolymorphicFields() {
        Schema.SObjectType sot = getSObjectType(POLYMORPHIC_OBJECT);
        return getFields(sot);
    }

    /**
     * @description Returns map of polymorphic field lowercase name to API name
     * @return : the map of polymorphic field lowercase name to API name
     */
    public static Map<String, String> getPolymorphicFieldMap() {
        List<Schema.SObjectField> fields = getPolymorphicFields();
        Map<String, String> fieldMap = new Map<String, String>();
        for(Schema.SObjectField field : fields) {
            String fieldName = getFieldName(field);
            fieldMap.put(fieldName.toLowerCase(), fieldName);
        }
        return fieldMap;
    }

    /**
     * @description Given a list of fields, return their api names
     * @param fields : the fields
     * @return : the field api names
     * @throws QueryException : if the sObject or field names are invalid
     */
    public static List<String> getFieldNames(List<Schema.SObjectField> fields) {
        Map<String, Object> args = new Map<String, Object> {
            'fields' => fields
        };
        Common.nullCheck(args);

        List<String> fieldNames = new List<String>();
        for(Schema.SObjectField field : fields) {
            fieldNames.add(getFieldName(field));
        }
        return fieldNames;
    }

    /**
     * @description Returns the "Name" SObjectType
     * @return the name sobject type
     */
    public static Schema.SObjectType getPolymorphicSObjectType() {
        Schema.SObjectType sot = getSObjectType(POLYMORPHIC_OBJECT);
        return sot;
    }

    /**
     * @description Given a field object, return the SObjectType of the SObject the field is from
     * @param field : the field
     * @return : the SObjectType of the SObject the field is from
     */
    public static Schema.SObjectType getFieldSObjectType(Schema.SObjectField field) {
        Map<String, Object> args = new Map<String, Object> {
            'field' => field
        };
        Common.nullCheck(args);

        return field.getDescribe().getSObjectType();
    }

    /** 
     * @description Given a child relationship and a child relationship name, return whether the child relationship is the same as the child relationship name
     * @param childRelationship : the child relationship
     * @param childRelationshipName : the child relationship name
     * @return : whether the child relationship is the same as the child relationship name
     */
    public static Boolean isChildRelationship(Schema.ChildRelationship childRelationship, String childRelationshipName) {
        Map<String, Object> args = new Map<String, Object> {
            'childRelationship' => childRelationship,
            'childRelationshipName' => childRelationshipName
        };
        Common.nullCheck(args);
        childRelationshipName = childRelationshipName.toLowerCase();

        String foundChildRelationshipName = getChildRelationshipName(childRelationship);
        return (
            foundChildRelationshipName != null && 
            foundChildRelationshipName.toLowerCase() == childRelationshipName
        );
    }

    /**
     * @description Given an SObject type and a field name, return whether the SObject type has the field
     * @param sot `Schema.SObjectType`
     * @param fieldApiName `String`
     * @return  `Boolean`
     */
    public static Boolean hasField(Schema.SObjectType sot, String fieldApiName) {
        Map<String, Object> args = new Map<String, Object> {
            'sot' => sot,
            'fieldApiName' => fieldApiName
        };
        Common.nullCheck(args);
        fieldApiName = fieldApiName.toLowerCase();

        return sot.getDescribe().fields.getMap().containsKey(fieldApiName);
    }
}