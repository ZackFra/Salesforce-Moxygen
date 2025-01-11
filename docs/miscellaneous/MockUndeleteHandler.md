# MockUndeleteHandler Class

`ISTEST`

MockUndeleteHandler is used to mock the Database.UndeleteResult class and the Database.undelete method

**Since** 

3/9/2024

**Author** Zackary Frazier

**Inheritance**

[MockDMLHandler](MockDMLHandler.md)

## Methods
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