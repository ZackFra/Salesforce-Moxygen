# MockDatabaseUtils Class

`SUPPRESSWARNINGS`

: utilities for a MockDatabase, contains methods that DO NOT mutate the database 
: a method in here must be dependent on the database, but not necessary to understand 
: the database

## Methods
### `isRecordInDatabase(recordId)`

Given a record id, verify it exists in the database

#### Signature
```apex
public Boolean isRecordInDatabase(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | : the record id |

#### Return Type
**Boolean**

: whether the record exists in the database

---

### `findRecord(recordId)`

: get the sObject from the database

#### Signature
```apex
public SObject findRecord(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | : the record id |

#### Return Type
**SObject**

: the sObject

---

### `findParentRecord(sObj, fieldName)`

: return a parent sObject from a field name and a child sObject

#### Signature
```apex
public ParentRecordData findParentRecord(sObject sObj, String fieldName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObj | sObject | : the child sObject |
| fieldName | String | : the field name of the parent sObject from the child 
: ex. OpportunityLineItem, the field is Opportunity |

#### Return Type
**[ParentRecordData](ParentRecordData.md)**

: the parent sObject

---

### `getAggrNodeValue(aggrNode, selectNode)`

#### Signature
```apex
public Map<String,Object> getAggrNodeValue(Node aggrNode, Node selectNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| aggrNode | [Node](Node.md) |  |
| selectNode | [Node](Node.md) |  |

#### Return Type
**Map&lt;String,Object&gt;**

---

### `getFieldNodeValue(valueNode, sObj, params)`

`SUPPRESSWARNINGS`

Get the value of a field node

#### Signature
```apex
public Object getFieldNodeValue(Node valueNode, sObject sObj, Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| valueNode | [Node](Node.md) |  |
| sObj | sObject |  |
| params | Map&lt;String,Object&gt; |  |

#### Return Type
**Object**

,[object Object]

#### Throws
QueryException: 

---

### `getUnfulfilledField(record)`

: check if the required fields are set on a record

#### Signature
```apex
public String getUnfulfilledField(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | : the record |

#### Return Type
**String**

: first required field that is not set

---

### `checkForRequiredFieldsOnInsert(record)`

Check if the required fields are set on a record

#### Signature
```apex
public void checkForRequiredFieldsOnInsert(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject |  |

#### Return Type
**void**

#### Throws
DMLException: 

---

### `checkForRequiredFieldsOnUpdate(record)`

Check if the required fields are set on a record

#### Signature
```apex
public void checkForRequiredFieldsOnUpdate(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject |  |

#### Return Type
**void**

#### Throws
DMLException: 

---

### `emptyResponse(topLevelNodes)`

Returns an empty response based on the top level nodes

#### Signature
```apex
public Object emptyResponse(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) |  |

#### Return Type
**Object**

,[object Object]