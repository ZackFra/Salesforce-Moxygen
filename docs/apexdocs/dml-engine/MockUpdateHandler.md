# MockUpdateHandler Class

`ISTEST`

MockUpdateHandler is used to mock the update operation in the database

**Since**

3/9/2024

**Group** DML Engine

**Author** Zackary Frazier

**Inheritance**

[MockDMLHandler](MockDMLHandler.md)

## Methods
### `doUpdate(recordToUpdate, allOrNone)`

`SUPPRESSWARNINGS`

Updates a record in the database

#### Signature
```apex
public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpdate | SObject | Record to update |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |

#### Return Type
**Database.SaveResult**

,[object Object]

#### Throws
DMLException: 

---

### `doUpdate(recordsToUpdate, allOrNone)`

doUpdate is used to update a list of records in the database

#### Signature
```apex
public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List<SObject> | - The records to update |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List<Database.SaveResult>**

List&lt;Database.SaveResult&gt; - The results of the update operations

---

### `doUpdate(recordToUpdate, allOrNone, accessLevel)`

Updates a record in the database

#### Signature
```apex
public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpdate | SObject | Record to update |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access level of the user |

#### Return Type
**Database.SaveResult**

,[object Object]

---

### `doUpdate(recordsToUpdate, allOrNone, accessLevel)`

Updates a list of records in the database

#### Signature
```apex
public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List<SObject> | Records to update |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access level of the user |

#### Return Type
**List<Database.SaveResult>**

,[object Object]

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