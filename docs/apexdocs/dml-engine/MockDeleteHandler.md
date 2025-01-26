# MockDeleteHandler Class

`ISTEST`

MockDeleteHandler is a class that extends MockDMLHandler and overrides the delete methods to simulate the delete operation

**Since** 

3/9/2024

**Group** DML Engine

**Author** Zackary Frazier

**Inheritance**

[MockDMLHandler](MockDMLHandler.md)

## Methods
### `doDelete(recordToDelete, allOrNone)`

DELETE METHODS

#### Signature
```apex
public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToDelete | SObject |  |
| allOrNone | Boolean |  |

#### Return Type
**Database.DeleteResult**

---

### `doDelete(recordsToDelete, allOrNone)`

Deletes a list of records

#### Signature
```apex
public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToDelete | List&lt;SObject&gt; | Records to delete |
| allOrNone | Boolean | Boolean to indicate if an exception should be thrown if any record fails to delete |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

,[object Object]

#### Throws
DmlException: 

---

### `doDelete(recordID, allOrNone)`

Deletes a record by ID

#### Signature
```apex
public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordID | Id | Id of the record to delete |
| allOrNone | Boolean | Boolean to indicate if an exception should be thrown if the record fails to delete |

#### Return Type
**Database.DeleteResult**

,[object Object]

#### Throws
DMLException: 

---

### `doDelete(recordIDs, allOrNone)`

Deletes a list of records by ID

#### Signature
```apex
public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List&lt;Id&gt; | List of record IDs to delete |
| allOrNone | Boolean | Boolean to indicate if an exception should be thrown if any record fails to delete |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

,[object Object]

#### Throws
DMLException: 

---

### `wasCalled()`

*Inherited*

Returns true if the method was called, otherwise false.

#### Signature
```apex
public Boolean wasCalled()
```

#### Return Type
**Boolean**

,[object Object]