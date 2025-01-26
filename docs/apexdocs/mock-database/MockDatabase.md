# MockDatabase Class

`SUPPRESSWARNINGS`

The MockDatabase class is used to simulate the Salesforce database in Apex unit tests

**Since** 

3/23/2024

**Group** Mock Database

**Author** Zackary Frazier

## Fields
### `dmlHandler`

#### Signature
```apex
public static dmlHandler
```

#### Type
[DmlEngine](../uncategorized/DmlEngine.md)

---

### `soqlHandler`

#### Signature
```apex
public static soqlHandler
```

#### Type
[SoqlEngine](../uncategorized/SoqlEngine.md)

---

### `utils`

#### Signature
```apex
public static utils
```

#### Type
[MockDatabaseUtils](../uncategorized/MockDatabaseUtils.md)

## Methods
### `aggregateQuery(query)`

Perform an aggregate query

#### Signature
```apex
public static List<Aggregate> aggregateQuery(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |

#### Return Type
**List&lt;Aggregate&gt;**

,[object Object]

---

### `aggregateQuery(query, accessLevel)`

Perform an aggregate query with access level

#### Signature
```apex
public static List<Aggregate> aggregateQuery(String query, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;Aggregate&gt;**

,[object Object]

---

### `aggregateQueryWithBinds(query, binds, accessLevel)`

Perform an aggregate query with binds

#### Signature
```apex
public static List<Aggregate> aggregateQueryWithBinds(String query, Map<String,Object> binds, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| binds | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;Aggregate&gt;**

,[object Object]

---

### `countQuery(query)`

Perform a count query

#### Signature
```apex
public static Integer countQuery(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |

#### Return Type
**Integer**

,[object Object]

---

### `countQuery(query, accessLevel)`

Perform a count query with access level

#### Signature
```apex
public static Integer countQuery(String query, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**Integer**

,[object Object]

---

### `countQueryWithBinds(query, binds, accessLevel)`

Perform a count query with binds

#### Signature
```apex
public static Integer countQueryWithBinds(String query, Map<String,Object> binds, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| binds | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**Integer**

,[object Object]

---

### `doDelete(recordToDelete, allOrNone)`

Deletes a record from the mock database

#### Signature
```apex
public static Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
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
public static List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToDelete | List&lt;SObject&gt; | - The records to delete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

List&lt;Database.DeleteResult&gt; - The results of the delete operations

---

### `doDelete(recordID, allOrNone)`

doDelete is used to delete a record from the database

#### Signature
```apex
public static Database.DeleteResult doDelete(Id recordID, Boolean allOrNone)
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
public static List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List&lt;Id&gt; | - The Ids of the records to delete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

List&lt;Database.DeleteResult&gt; - The results of the delete operations

---

### `doInsert(recordToInsert, allOrNone, accessLevel)`

doInsert is used to insert a record into the database

#### Signature
```apex
public static Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
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
public static Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone)
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
public static List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone)
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

doInsert is used to insert a list of records into the database

#### Signature
```apex
public static List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | - The records to insert |
| allOrNone | Boolean | - Whether to throw an exception if any of the records already exist |
| accessLevel | System.AccessLevel | - The access level of the user performing the operation |

#### Return Type
**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - The results of the insert operations

---

### `doMockInsert(recordToInsert)`

DML methods

#### Signature
```apex
public static void doMockInsert(SObject recordToInsert)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject |  |

#### Return Type
**void**

---

### `doMockInsert(recordsToInsert)`

doMockInsert is used to insert a list of records into the mock database without setting the `wasCalled` flag

#### Signature
```apex
public static void doMockInsert(List<SObject> recordsToInsert)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | - The records to insert |

#### Return Type
**void**

---

### `doSelectQueryInternal(head, params)`

SOQL methods

#### Signature
```apex
public static List<SObject> doSelectQueryInternal(Node head, Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| head | [Node](../uncategorized/Node.md) |  |
| params | Map&lt;String,Object&gt; |  |

#### Return Type
**List&lt;SObject&gt;**

---

### `doUndelete(recordToUndelete, allOrNone)`

doUndelete is used to undelete a record from the database

#### Signature
```apex
public static Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone)
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
public static List<Database.UndeleteResult> doUndelete(List<sObject> recordsToUndelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUndelete | List&lt;sObject&gt; | - The records to undelete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List&lt;Database.UndeleteResult&gt;**

List&lt;Database.UndeleteResult&gt; - The results of the undelete operations

#### Throws
DmlException: - If any of the records do not exists and allOrNone is true

---

### `doUndelete(recordID, allOrNone)`

doUndelete is used to undelete a record from the database

#### Signature
```apex
public static Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone)
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
public static List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List&lt;Id&gt; | - The Ids of the records to undelete |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List&lt;Database.UndeleteResult&gt;**

List&lt;Database.UndeleteResult&gt; - The results of the undelete operations

#### Throws
DmlException: - If any of the records do not exists and allOrNone is true

---

### `doUndelete(recordToUndelete, allOrNone, accessLevel)`

doUndelete is used to undelete a record from the database

#### Signature
```apex
public static Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel)
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
public static Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone)
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
public static List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List&lt;SObject&gt; | - The records to update |
| allOrNone | Boolean | - Whether to throw an exception if any of the records do not exist |

#### Return Type
**List&lt;Database.SaveResult&gt;**

,[object Object], - The results of the update operations

---

### `doUpdate(recordToUpdate, allOrNone, accessLevel)`

Updates a record in the mock database

#### Signature
```apex
public static Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
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
public static List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List&lt;SObject&gt; | Records to update |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access Level of the user performing the operation |

#### Return Type
**List&lt;Database.SaveResult&gt;**

,[object Object]

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone)`

Upserts a record into the mock database

#### Signature
```apex
public static Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone)
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
public static List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List&lt;SObject&gt; | Records to upsert |
| externalIdField | SObjectField | Optional field to use as the external ID |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

,[object Object]

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Upserts a record in the mock database

#### Signature
```apex
public static Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
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
public static List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List&lt;SObject&gt; | Records to upsert |
| externalIdField | SObjectField | Optional external ID field |
| allOrNone | Boolean | Boolean to throw an exception if the record does not exist |
| accessLevel | System.AccessLevel | Access level of the user performing the operation |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

,[object Object]

---

### `query(query)`

This method is used to query the mock database by traversing the AST

#### Signature
```apex
public static List<SObject> query(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | : the query string |

#### Return Type
**List&lt;SObject&gt;**

: the query results

---

### `query(query, accessLevel)`

Query the database for records, with access level

#### Signature
```apex
public static List<SObject> query(String query, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

---

### `queryWithBinds(query, binds, accessLevel)`

Query the database for records, with binds

#### Signature
```apex
public static List<SObject> queryWithBinds(String query, Map<String,Object> binds, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| binds | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

---

### `resetHandlers()`

Utility methods (For Testing)

#### Signature
```apex
public static void resetHandlers()
```

#### Return Type
**void**