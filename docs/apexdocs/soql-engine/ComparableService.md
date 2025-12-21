# ComparableService Class

This class provides the ability to compare fields on SObjects with the mock database

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `getComparableData(obj, field)`

: getComparables, except we don&#x27;t return the comparable sObject, we return a blank sObject of that type

#### Signature
```apex
public static Map<String,Object> getComparableData(sObject obj, String field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | sObject | : the sObject |
| field | String | : the field name |

#### Return Type
**Map<String,Object>**

: a map with the comparable sObject, the field api name, and the relationship name

#### Throws
QueryException: : if the field name is invalid

---

### `getComparableDataFromNodes(fieldNode, selectNode)`

: given a field node and a select node, return a map with the comparable sObject data, 
the field api name, and the relationship name, builds on getComparables

#### Signature
```apex
public static Map<String,Object> getComparableDataFromNodes(Node fieldNode, Node selectNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldNode | [Node](Node.md) | : the field node |
| selectNode | [Node](Node.md) | : the select node |

#### Return Type
**Map<String,Object>**

: a map with the comparable sObject, the field api name, and the relationship name

#### Throws
QueryException: : if the field name is invalid

---

### `getComparableField(comparableRecord, finalField, isPolymorphic)`

Get the comparable field name from a field name and a comparable sObject

#### Signature
```apex
public static String getComparableField(SObject comparableRecord, String finalField, Boolean isPolymorphic)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| comparableRecord | SObject | `SObject` |
| finalField | String | `String` |
| isPolymorphic | Boolean | `Boolean` |

#### Return Type
**String**

,[object Object]

---

### `getComparables(record, fieldLookupChain)`

`SUPPRESSWARNINGS`

: given an sObject and a field name (which may be a relationon i.e. Account.Name), 
: return a map with the comparable sObject (i.e. the parent), the field api name of that object, 
: and the relationship name

#### Signature
```apex
public static ComparableRecordData getComparables(SObject record, String fieldLookupChain)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | : the sObject |
| fieldLookupChain | String | : the field name |

#### Return Type
**[ComparableRecordData](ComparableRecordData.md)**

: a map with the comparable sObject, the field api name, and the relationship name, and whether the field is polymorphic

#### Throws
QueryException: : if the field name is invalid

---

### `getParentObject(sObj, fieldName)`

: return a parent sObject from a field name and a child sObject

#### Signature
```apex
public static Map<String,Object> getParentObject(sObject sObj, String fieldName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | sObject | : the child sObject |
| fieldName | String | : the field name of the parent sObject from the child 
: ex. OpportunityLineItem, the field is Opportunity |

#### Return Type
**Map<String,Object>**

A map with the parent sObject, the field api name, and the relationship name

---

### `getParentObjectData(sObj, fieldName)`

: return a parent sObject from a field name and a child sObject

#### Signature
```apex
public static Map<String,Object> getParentObjectData(SObject sObj, String fieldName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | SObject | : the child sObject |
| fieldName | String | : the field name of the parent sObject from the child 
: ex. OpportunityLineItem, the field is Opportunity |

#### Return Type
**Map<String,Object>**

: a map with the parent sObject, the field api name, and the relationship name