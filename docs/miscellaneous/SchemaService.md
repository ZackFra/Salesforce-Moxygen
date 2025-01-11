# SchemaService Class

`SUPPRESSWARNINGS`

this class is intended to handle interactions with the Schema class 
and provide a layer of abstraction for the Schema class, non-mutating 
string arguments to these methods are understood to be case-insensitive 
anything named &quot;getName&quot; are understood to return proper API names 
every argument is understood to be non-null

## Methods
### `describeField(field)`

Return the `Schema.DescribeFieldResult` for a given field

#### Signature
```apex
public static Schema.DescribeFieldResult describeField(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | `Schema.SObjectField` the field |

#### Return Type
**Schema.DescribeFieldResult**

,[object Object]

---

### `describeField(sObjApiName, fieldApiName)`

This method is used primarily to discover if a field is polymorphic,

#### Signature
```apex
public static Schema.DescribeFieldResult describeField(String sObjApiName, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjApiName | String | : the api name of the sObject |
| fieldApiName | String | : the api name of the field |

#### Return Type
**Schema.DescribeFieldResult**

the describe field result

---

### `getFieldType(sot, fieldApiName)`

this method returns the field type of a given field

#### Signature
```apex
public static Schema.DisplayType getFieldType(Schema.SObjectType sot, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | the sobject type |
| fieldApiName | String | the field api name |

#### Return Type
**Schema.DisplayType**

the field type

---

### `getFieldType(field)`

this method returns the field type of a given field

#### Signature
```apex
public static Schema.DisplayType getFieldType(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | the field |

#### Return Type
**Schema.DisplayType**

the field type

---

### `getFieldName(field)`

this method returns the field name of a given field

#### Signature
```apex
public static String getFieldName(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | `Schema.SObjectField` |

#### Return Type
**String**

the field name

---

### `getFieldName(sot, fieldApiName)`

this method returns the field name of a given field

#### Signature
```apex
public static String getFieldName(Schema.SObjectType sot, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | the sobject type |
| fieldApiName | String | the field api name |

#### Return Type
**String**

the field name

---

### `getFieldName(sObj, fieldApiName)`

this method returns the field name of a given field

#### Signature
```apex
public static String getFieldName(SObject sObj, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | SObject | the sobject |
| fieldApiName | String | the field api name |

#### Return Type
**String**

the field name

---

### `getSObjectType(sObj)`

this method returns the type of a given SObject

#### Signature
```apex
public static Schema.SObjectType getSObjectType(SObject sObj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | SObject | the sobject |

#### Return Type
**Schema.SObjectType**

the sobject type

---

### `getSObjectType(recordId)`

this method returns the type of a given record id

#### Signature
```apex
public static Schema.SObjectType getSObjectType(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | the record id |

#### Return Type
**Schema.SObjectType**

the sobject type

---

### `getSObjectType(sObjApiName)`

this method returns the type of a given SObject

#### Signature
```apex
public static Schema.SObjectType getSObjectType(String sObjApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjApiName | String | the sobject api name |

#### Return Type
**Schema.SObjectType**

the sobject type

#### Throws
TypeException: if the type is not found

---

### `getSObjectName(sot)`

this method returns the API name of a given SObject

#### Signature
```apex
public static String getSObjectName(Schema.SObjectType sot)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | the sobject type |

#### Return Type
**String**

the sobject api name

---

### `getSObjectName(recordId)`

this method returns the API name of a given SObject

#### Signature
```apex
public static String getSObjectName(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | the record id |

#### Return Type
**String**

the sobject api name

---

### `getSObjectName(sObjName)`

this method returns the API name of a given SObject

#### Signature
```apex
public static String getSObjectName(String sObjName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjName | String | the sobject name |

#### Return Type
**String**

the sobject api name

#### Throws
TypeException: if the type is not found

---

### `getSObjectName(sObj)`

this method returns the API name of a given SObject

#### Signature
```apex
public static String getSObjectName(SObject sObj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | SObject | the sobject |

#### Return Type
**String**

the sobject api name

---

### `blankSObjectFrom(sot)`

this method returns the type of a given SObject

#### Signature
```apex
public static SObject blankSObjectFrom(Schema.SObjectType sot)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | the sobject type |

#### Return Type
**SObject**

the sobject

#### Throws
TypeException: if the type is not found

---

### `blankSObjectFrom(sObjApiName)`

this method returns the type of a given SObject

#### Signature
```apex
public static SObject blankSObjectFrom(String sObjApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjApiName | String | the sobject api name |

#### Return Type
**SObject**

the sobject

#### Throws
TypeException: if the type is not found

---

### `getChildRelationships(sot)`

this method returns the child relationships of a given SObject type

#### Signature
```apex
public static List<Schema.ChildRelationship> getChildRelationships(Schema.SObjectType sot)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | the sobject type |

#### Return Type
**List&lt;Schema.ChildRelationship&gt;**

the child relationships

---

### `getChildRelationshipName(childRelationship)`

this method returns the child relationship name of a given child relationship

#### Signature
```apex
public static String getChildRelationshipName(Schema.ChildRelationship childRelationship)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| childRelationship | Schema.ChildRelationship | the child relationship |

#### Return Type
**String**

the child relationship name

---

### `getRelationshipName(sot, relationshipName)`

Given an sObject and a relationship name, return the relationship api name

#### Signature
```apex
public static String getRelationshipName(Schema.SObjectType sot, String relationshipName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | : the child sObject type |
| relationshipName | String | : the relationship name |

#### Return Type
**String**

: the field api name

#### Throws
QueryException: : if the relationship name is invalid

---

### `getFieldRelationshipName(field)`

this method returns the field relationship name of a given field

#### Signature
```apex
public static String getFieldRelationshipName(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | the field |

#### Return Type
**String**

the field relationship name

---

### `getChildRelationshipChildSObjectName(childRelationship)`

this method returns the child SObject name of a given child relationship

#### Signature
```apex
public static String getChildRelationshipChildSObjectName(Schema.ChildRelationship childRelationship)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| childRelationship | Schema.ChildRelationship | the child relationship |

#### Return Type
**String**

the child relationship name

---

### `getChildRelationshipFieldName(childRelationship)`

this method returns the child relationship field name of a given child relationship

#### Signature
```apex
public static String getChildRelationshipFieldName(Schema.ChildRelationship childRelationship)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| childRelationship | Schema.ChildRelationship | the child relationship |

#### Return Type
**String**

the child relationship name

---

### `isFieldNumeric(fieldType)`

given a field type, this method returns whether the field is numeric or not

#### Signature
```apex
public static Boolean isFieldNumeric(Schema.DisplayType fieldType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldType | Schema.DisplayType | : the field type |

#### Return Type
**Boolean**

: whether the field is numeric or not

---

### `getFields(sot)`

given an sObject type, return the fields

#### Signature
```apex
public static List<Schema.SObjectField> getFields(Schema.SObjectType sot)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | the sObject type |

#### Return Type
**List&lt;Schema.SObjectField&gt;**

the fields

---

### `getField(sot, fieldApiName)`

Given an sObject and a field api name, return the field

#### Signature
```apex
public static Schema.SObjectField getField(Schema.SObjectType sot, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | : the sObject type |
| fieldApiName | String | : the field api name |

#### Return Type
**Schema.SObjectField**

: the field

---

### `getField(sObj, fieldApiName)`

Given an sObject and a field api name, return the field

#### Signature
```apex
public static Schema.SObjectField getField(SObject sObj, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | SObject | : the sObject |
| fieldApiName | String | : the field api name |

#### Return Type
**Schema.SObjectField**

: the field

---

### `getField(sObjApiName, fieldApiName)`

Returns the field for a given sObject API name and field API name

#### Signature
```apex
public static Schema.SObjectField getField(String sObjApiName, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjApiName | String | `String` |
| fieldApiName | String | `String` |

#### Return Type
**Schema.SObjectField**

,[object Object]

---

### `getReferenceTo(field)`

Given an SObjectField, return the list of objects that the field references

#### Signature
```apex
public static List<SObjectType> getReferenceTo(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | : the field |

#### Return Type
**List&lt;SObjectType&gt;**

: the list of objects that the field references

---

### `getFieldNameForRelationship(sot, relationshipName)`

: given an sObject and a relationship name, return the field api name

#### Signature
```apex
public static String getFieldNameForRelationship(Schema.SObjectType sot, String relationshipName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | : the sObject |
| relationshipName | String | : the relationship name |

#### Return Type
**String**

: the field api name

#### Throws
QueryException: : if the relationship name is invalid

---

### `isRelationshipPolymorphic(sot, relationshipName)`

Given an sObject and a relationship name, return whether the relationship is polymorphic or not

#### Signature
```apex
public static Boolean isRelationshipPolymorphic(Schema.SObjectType sot, String relationshipName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | `Schema.SObjectType` the sObject type |
| relationshipName | String | `String` the relationship name |

#### Return Type
**Boolean**

,[object Object], whether the field is polymorphic or not

---

### `isFieldPolymorphic(field)`

Given an sObject and a relationship name, return the field api name

#### Signature
```apex
public static Boolean isFieldPolymorphic(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | : the field |

#### Return Type
**Boolean**

: whether the field is polymorphic or not

---

### `getPolymorphicFields()`

Returns the &quot;Name&quot; fields, where &quot;Name&quot; is the special SObject for polymorphic relationships

#### Signature
```apex
public static List<Schema.SObjectField> getPolymorphicFields()
```

#### Return Type
**List&lt;Schema.SObjectField&gt;**

the name fields

---

### `getPolymorphicFieldMap()`

Returns map of polymorphic field lowercase name to API name

#### Signature
```apex
public static Map<String,String> getPolymorphicFieldMap()
```

#### Return Type
**Map&lt;String,String&gt;**

: the map of polymorphic field lowercase name to API name

---

### `getFieldNames(fields)`

Given a list of fields, return their api names

#### Signature
```apex
public static List<String> getFieldNames(List<Schema.SObjectField> fields)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fields | List&lt;Schema.SObjectField&gt; | : the fields |

#### Return Type
**List&lt;String&gt;**

: the field api names

#### Throws
QueryException: : if the sObject or field names are invalid

---

### `getPolymorphicSObjectType()`

Returns the &quot;Name&quot; SObjectType

#### Signature
```apex
public static Schema.SObjectType getPolymorphicSObjectType()
```

#### Return Type
**Schema.SObjectType**

the name sobject type

---

### `getFieldSObjectType(field)`

Given a field object, return the SObjectType of the SObject the field is from

#### Signature
```apex
public static Schema.SObjectType getFieldSObjectType(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | : the field |

#### Return Type
**Schema.SObjectType**

: the SObjectType of the SObject the field is from

---

### `isChildRelationship(childRelationship, childRelationshipName)`

Given a child relationship and a child relationship name, return whether the child relationship is the same as the child relationship name

#### Signature
```apex
public static Boolean isChildRelationship(Schema.ChildRelationship childRelationship, String childRelationshipName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| childRelationship | Schema.ChildRelationship | : the child relationship |
| childRelationshipName | String | : the child relationship name |

#### Return Type
**Boolean**

: whether the child relationship is the same as the child relationship name

---

### `hasField(sot, fieldApiName)`

Given an SObject type and a field name, return whether the SObject type has the field

#### Signature
```apex
public static Boolean hasField(Schema.SObjectType sot, String fieldApiName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | `Schema.SObjectType` |
| fieldApiName | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `getRecordTypeId(sot, recordTypeName)`

Returns the specified record type&#x27;s id for a given sObject type

#### Signature
```apex
public static Id getRecordTypeId(Schema.SObjectType sot, String recordTypeName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | Schema.SObjectType | `Schema.SObjectType` |
| recordTypeName | String | `String` |

#### Return Type
**Id**

,[object Object]

---

### `idsReferenceSameSObject(field1, field2)`

Given two fields, return whether they reference the same SObject

#### Signature
```apex
public static Boolean idsReferenceSameSObject(Schema.SObjectField field1, Schema.SObjectField field2)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field1 | Schema.SObjectField | : the first id or reference field |
| field2 | Schema.SObjectField | : the second id or reference field |

#### Return Type
**Boolean**

: whether the fields reference the same SObject

#### Throws
QueryException: : if the sObject or field names are invalid

---

### `isRequiredField(field)`

Given a field, determine if it is required (system-level)

#### Signature
```apex
public static Boolean isRequiredField(Schema.SObjectField field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | Schema.SObjectField | : the field |

#### Return Type
**Boolean**

: whether the field is required or not

---

### `isFieldGroupable(sObjectName, fieldName)`

Given an sObject name and a field name, determine if the field is groupable in a query

#### Signature
```apex
public static Boolean isFieldGroupable(String sObjectName, String fieldName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjectName | String | `String` |
| fieldName | String | `String` |

#### Return Type
**Boolean**

,[object Object]