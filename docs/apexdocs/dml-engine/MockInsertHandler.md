# MockInsertHandler Class

`ISTEST`

MockInsertHandler is used to mock the insert operation

**Since** 

3/9/2024

**Group** DML Engine

**Author** Zackary Frazier

**Inheritance**

[MockDMLHandler](MockDMLHandler.md)

## Methods
### `doInsert(recordToInsert, allOrNone, accessLevel)`

doInsert is used to insert a record into the database

#### Signature
```apex
public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | - The record to insert |
| allOrNone | Boolean | - Whether to throw an exception if the record already exists |
| accessLevel | System.AccessLevel | - The access level of the user performing the operation |

#### Return Type
**Database.SaveResult**

Database.SaveResult - The result of the insert operation

---

### `doInsert(recordToInsert, allOrNone)`

Does a mock insert of a record into the database

#### Signature
```apex
public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | Record to insert |
| allOrNone | Boolean | Boolean to throw an exception if the record already exists |

#### Return Type
**Database.SaveResult**

,[object Object]

#### Throws
DmlException: 

---

### `doInsert(recordsToInsert, allOrNone)`

doInsert is used to insert a list of records into the database

#### Signature
```apex
public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | - The records to insert |
| allOrNone | Boolean | - Whether to throw an exception if any of the records already exist |

#### Return Type
**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - The results of the insert operations

---

### `doInsert(recordsToInsert, allOrNone, accessLevel)`

Inserts a list of records into the database

#### Signature
```apex
public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | List of records to insert |
| allOrNone | Boolean | Boolean to throw an exception if the record already exists |
| accessLevel | System.AccessLevel | Access level of the user performing the operation |

#### Return Type
**List&lt;Database.SaveResult&gt;**

,[object Object]

---

### `doMockInsert(recordsToInsert)`

Does a mock insert of a record into the database without setting `wasCalled` to true

#### Signature
```apex
public void doMockInsert(List<SObject> recordsToInsert)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | List of records to insert |

#### Return Type
**void**

---

### `doMockInsert(recordToInsert)`

Does a mock insert of a record into the database without setting `wasCalled` to true

#### Signature
```apex
public void doMockInsert(SObject recordToInsert)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | Record to insert |

#### Return Type
**void**

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