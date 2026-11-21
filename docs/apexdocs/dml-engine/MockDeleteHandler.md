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

Deletes a record

#### Signature
```apex
public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToDelete | SObject | Record to delete |
| allOrNone | Boolean | Boolean to indicate if all records should be deleted or none |

#### Return Type
**Database.DeleteResult**

`Database.DeleteResult`

#### Throws
DmlException: 

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
| recordsToDelete | List<SObject> | Records to delete |
| allOrNone | Boolean | Boolean to indicate if an exception should be thrown if any record fails to delete |

#### Return Type
**List<Database.DeleteResult>**

`List<Database.DeleteResult>`

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

`Database.DeleteResult`

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
| recordIDs | List<Id> | List of record IDs to delete |
| allOrNone | Boolean | Boolean to indicate if an exception should be thrown if any record fails to delete |

#### Return Type
**List<Database.DeleteResult>**

`List<Database.DeleteResult>`

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

`Boolean`