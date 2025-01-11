# DML Class

`SUPPRESSWARNINGS`

DML class to handle DML operations, wrapper around Database methods 
to allow for mocking and stubbing in unit tests.

**Group** Moxygen

## Methods
### `doDelete(recordToDelete, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToDelete | SObject | - The record to delete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.DeleteResult**

Database.DeleteResult - The result of the delete operation

---

### `doDelete(recordsToDelete, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToDelete | List&lt;SObject&gt; | - The records to delete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

List&lt;Database.DeleteResult&gt; - The result of the delete operation

---

### `doDelete(recordID, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.DeleteResult doDelete(Id recordID, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordID | Id | - The ID of the record to delete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.DeleteResult**

Database.DeleteResult - The result of the delete operation

---

### `doDelete(recordIDs, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List&lt;Id&gt; | - The IDs of the records to delete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

List&lt;Database.DeleteResult&gt; - The result of the delete operation

---

### `doInsert(recordToInsert, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | - The record to insert |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.SaveResult**

Database.SaveResult - The result of the insert operation

---

### `doInsert(recordsToInsert, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | - The records to insert |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - The result of the insert operation

---

### `doInsert(recordToInsert, allOrNone, accessLevel)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToInsert | SObject | - The record to insert |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**Database.SaveResult**

Database.SaveResult - The result of the update operation

---

### `doInsert(recordsToInsert, allOrNone, accessLevel)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToInsert | List&lt;SObject&gt; | - The records to insert |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - The result of the update operation

---

### `doUndelete(recordToUndelete, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUndelete | sObject | - The record to undelete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.UndeleteResult**

Database.UndeleteResult - The result of the undelete operation

---

### `doUndelete(recordsToUndelete, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.UndeleteResult> doUndelete(List<SObject> recordsToUndelete, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUndelete | List&lt;SObject&gt; | - The records to undelete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.UndeleteResult&gt;**

List&lt;Database.UndeleteResult&gt; - The result of the undelete operation

---

### `doUndelete(recordID, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordID | Id | - The ID of the record to undelete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.UndeleteResult**

Database.UndeleteResult - The result of the undelete operation

---

### `doUndelete(recordIDs, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordIDs | List&lt;Id&gt; | - The IDs of the records to undelete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.UndeleteResult&gt;**

List&lt;Database.UndeleteResult&gt; - The result of the undelete operation

---

### `doUndelete(recordToUndelete, allOrNone, accessLevel)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUndelete | SObject | - The record to undelete |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**Database.UndeleteResult**

Database.UndeleteResult - The result of the undelete operation

---

### `doUpdate(recordToUpdate, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpdate | SObject | - The record to update |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.SaveResult**

Database.SaveResult - The result of the update operation

---

### `doUpdate(recordsToUpdate, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List&lt;SObject&gt; | - The records to update |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - The result of the update operation

---

### `doUpdate(recordToUpdate, allOrNone, accessLevel)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpdate | SObject | - The record to update |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**Database.SaveResult**

Database.SaveResult - The result of the update operation

---

### `doUpdate(recordsToUpdate, allOrNone, accessLevel)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpdate | List&lt;SObject&gt; | - The records to update |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - The result of the update operation

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpsert | SObject | - The record to upsert |
| externalIdField | SObjectField | - The field to use as the external ID |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**Database.UpsertResult**

Database.UpsertResult - The result of the upsert operation

---

### `doUpsert(recordsToUpsert, externalIdField, allOrNone)`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List&lt;SObject&gt; | - The records to upsert |
| externalIdField | SObjectField | - The field to use as the external ID |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

List&lt;Database.UpsertResult&gt; - The result of the upsert operation

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpsert | SObject | - The record to upsert |
| externalIdField | SObjectField | - The field to use as the external ID |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**Database.UpsertResult**

Database.UpsertResult - The result of the upsert operation

---

### `doUpsert(recordsToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Wrapper around Database methods to allow for mocking and stubbing in unit tests

#### Signature
```apex
public static List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List&lt;SObject&gt; | - The records to upsert |
| externalIdField | SObjectField | - The field to use as the external ID |
| allOrNone | Boolean | - If true, the operation is an all-or-none operation. If false, the operation allows partial success. |
| accessLevel | System.AccessLevel | - The access level for the operation |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

List&lt;Database.UpsertResult&gt; - The result of the upsert operation