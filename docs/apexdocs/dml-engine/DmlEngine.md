# DmlEngine Class

`SUPPRESSWARNINGS`

MockDatabaseDMLHandler is used to handle DML operations on the mock database

**Since**

4/8/2024

**Group** DML Engine

**Author** Zackary Frazier

## Constructors
### `DmlEngine()`

Constructor

#### Signature
```apex
public DmlEngine()
```

## Methods
### `doDelete(recordToDelete, allOrNone)`

Deletes a record from the mock database

#### Signature
```apex
public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToDelete | SObject | - The record to delete |
| allOrNone | Boolean | - Whether to throw an exception if the record does not exist |

#### Return Type
**Database.DeleteResult**

Database.DeleteResult - The result of the delete operation

---

### `doDelete(recordsToDelete, allOrNone)`

doDelete is used to delete a list of records from the database

#### Signature
```apex
public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToDelete | List<SObject> | - The records to delete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List<Database.DeleteResult>**

List&lt;Database.DeleteResult&gt; - The results of the delete operations

---

### `doDelete(recordID, allOrNone)`

doDelete is used to delete a record from the database

#### Signature
```apex
public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordID | Id | - The Id of the record to delete |
| allOrNone | Boolean | - Whether to throw an exception if the record does not exist |

#### Return Type
**Database.DeleteResult**

Database.DeleteResult - The result of the delete operation

---

### `doDelete(recordIDs, allOrNone)`

doDelete is used to delete a list of records from the database

#### Signature
```apex
public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List<Id> | - The Ids of the records to delete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List<Database.DeleteResult>**

List&lt;Database.DeleteResult&gt; - The results of the delete operations

---

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

doInsert is used to insert a list of records into the database

#### Signature
```apex
public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | - The record to insert |
| allOrNone | Boolean | - Whether to throw an exception if any of the records already exist |

#### Return Type
**Database.SaveResult**

List&lt;Database.SaveResult&gt; - The results of the insert operations

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
| recordsToInsert | List<SObject> | - The records to insert |
| allOrNone | Boolean | - Whether to throw an exception if any of the records already exist |

#### Return Type
**List<Database.SaveResult>**

List&lt;Database.SaveResult&gt; - The results of the insert operations

---

### `doInsert(recordsToInsert, allOrNone, accessLevel)`

doInsert is used to insert a list of records into the database

#### Signature
```apex
public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List<SObject> | - The records to insert |
| allOrNone | Boolean | - Whether to throw an exception if any of the records already exist |
| accessLevel | System.AccessLevel | - The access level of the user performing the operation |

#### Return Type
**List<Database.SaveResult>**

List&lt;Database.SaveResult&gt; - The results of the insert operations

---

### `doMockInsert(recordToInsert)`

doMockInsert is used to insert a record into the mock database without setting the `wasCalled` flag

#### Signature
```apex
public void doMockInsert(SObject recordToInsert)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | - The record to insert |

#### Return Type
**void**

---

### `doMockInsert(recordsToInsert)`

doMockInsert is used to insert a list of records into the mock database without setting the `wasCalled` flag

#### Signature
```apex
public void doMockInsert(List<SObject> recordsToInsert)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List<SObject> | - The records to insert |

#### Return Type
**void**

---

### `doUndelete(recordToUndelete, allOrNone)`

doUndelete is used to undelete a record from the database

#### Signature
```apex
public Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUndelete | sObject | - The record to undelete |
| allOrNone | Boolean | - Whether to throw an exception if the record does not exist |

#### Return Type
**Database.UndeleteResult**

Database.UndeleteResult - The result of the undelete operation

#### Throws
DmlException: - If the record does not exists and allOrNone is true

---

### `doUndelete(recordsToUndelete, allOrNone)`

doUndelete is used to undelete a list of records from the database

#### Signature
```apex
public List<Database.UndeleteResult> doUndelete(List<sObject> recordsToUndelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUndelete | List<sObject> | - The records to undelete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List<Database.UndeleteResult>**

List&lt;Database.UndeleteResult&gt; - The results of the undelete operations

#### Throws
DmlException: - If any of the records do not exists and allOrNone is true

---

### `doUndelete(recordID, allOrNone)`

doUndelete is used to undelete a record from the database

#### Signature
```apex
public Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordID | Id | - The Id of the record to undelete |
| allOrNone | Boolean | - Whether to throw an exception if the record does not exist |

#### Return Type
**Database.UndeleteResult**

Database.UndeleteResult - The result of the undelete operation

---

### `doUndelete(recordIDs, allOrNone)`

doUndelete is used to undelete a list of records from the database

#### Signature
```apex
public List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List<Id> | - The Ids of the records to undelete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List<Database.UndeleteResult>**

List&lt;Database.UndeleteResult&gt; - The results of the undelete operations

#### Throws
DmlException: - If any of the records do not exists and allOrNone is true

---

### `doUndelete(recordToUndelete, allOrNone, accessLevel)`

doUndelete is used to undelete a record from the database

#### Signature
```apex
public Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUndelete | SObject | - The record to undelete |
| allOrNone | Boolean | - Whether to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | - The access level of the user performing the operation |

#### Return Type
**Database.UndeleteResult**

Database.UndeleteResult - The result of the undelete operation

---

### `doUpdate(recordToUpdate, allOrNone)`

doUpdate is used to update a record in the database

#### Signature
```apex
public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpdate | SObject | - The record to update |
| allOrNone | Boolean | - Whether to throw an exception if the record does not exist |

#### Return Type
**Database.SaveResult**

Database.SaveResult - The result of the update operation

#### Throws
DmlException: - If the record does not exists and allOrNone is true

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

,[object Object], - The results of the update operations

---

### `doUpdate(recordToUpdate, allOrNone, accessLevel)`

Updates a record in the mock database

#### Signature
```apex
public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpdate | SObject | Record to update |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | AccessLevel of the user performing the operation |

#### Return Type
**Database.SaveResult**

,[object Object]

---

### `doUpdate(recordsToUpdate, allOrNone, accessLevel)`

Update a list of records in the mock database

#### Signature
```apex
public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List<SObject> | Records to update |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access Level of the user performing the operation |

#### Return Type
**List<Database.SaveResult>**

,[object Object]

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone)`

Upserts a record into the mock database

#### Signature
```apex
public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpsert | SObject | Records to upsert |
| externalIdField | SObjectField | Optional field to use as the external ID |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |

#### Return Type
**Database.UpsertResult**

,[object Object]

---

### `doUpsert(recordsToUpsert, externalIdField, allOrNone)`

Upserts a record in the mock database

#### Signature
```apex
public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List<SObject> | Records to upsert |
| externalIdField | SObjectField | Optional field to use as the external ID |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |

#### Return Type
**List<Database.UpsertResult>**

,[object Object]

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Upserts a record in the mock database

#### Signature
```apex
public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpsert | SObject | Record to upsert |
| externalIdField | SObjectField | Optional external ID field |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access level of the user performing the operation |

#### Return Type
**Database.UpsertResult**

,[object Object]

---

### `doUpsert(recordsToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Upsert a list of records in the mock database

#### Signature
```apex
public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List<SObject> | Records to upsert |
| externalIdField | SObjectField | Optional external ID field |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access level of the user performing the operation |

#### Return Type
**List<Database.UpsertResult>**

,[object Object]

---

### `resetHandlers()`

resetHandlers is used to reset the DML handlers to their default state

#### Signature
```apex
public void resetHandlers()
```

#### Return Type
**void**

---

### `wasCalled(type)`

Returns whether a specific DML operation was called

#### Signature
```apex
public Boolean wasCalled(Types.DML type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.DML | - The type of DML operation to check |

#### Return Type
**Boolean**

Boolean - Whether the DML operation was called

---

### `wasCalled()`

Returns whether any DML operation was called

#### Signature
```apex
public Boolean wasCalled()
```

#### Return Type
**Boolean**

Boolean - Whether any DML operation was called