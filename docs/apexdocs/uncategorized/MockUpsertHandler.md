# MockUpsertHandler Class

`SUPPRESSWARNINGS`
`ISTEST`

MockUpsertHandler is used to mock the upsert operation in the database

**Since** 

3/9/2024

**Author** Zackary Frazier

**Inheritance**

[MockDMLHandler](MockDMLHandler.md)

## Methods
### `doUpsert(recordToUpsert, externalIdField, allOrNone)`

Upsert a record into the database

#### Signature
```apex
public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpsert | SObject | Record to upsert |
| externalIdField | SObjectField | Optional field to use as the external id for the upsert operation |
| allOrNone | Boolean | Boolean to throw an exception if the record already exists |

#### Return Type
**Database.UpsertResult**

,[object Object]

#### Throws
DmlException: 

---

### `doUpsert(recordsToUpsert, externalIdField, allOrNone)`

doUpsert is used to upsert a list of records into the database

#### Signature
```apex
public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List&lt;SObject&gt; | The records to upsert |
| externalIdField | SObjectField | Optional field to use as the external id for the upsert operation |
| allOrNone | Boolean | Boolean to throw an exception if the record already exists |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

,[object Object]

#### Throws
DmlException: 

---

### `doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Upsert a record into the database

#### Signature
```apex
public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordToUpsert | SObject | Record to upsert |
| externalIdField | SObjectField | Optional field to use as the external id for the upsert operation |
| allOrNone | Boolean | Boolean to throw an exception if the record already exists |
| accessLevel | System.AccessLevel | Access level of the user performing the operation |

#### Return Type
**Database.UpsertResult**

,[object Object]

#### Throws
DmlException: 

---

### `doUpsert(recordsToUpsert, externalIdField, allOrNone, accessLevel)`

`SUPPRESSWARNINGS`

Upsers a list of records into the database

#### Signature
```apex
public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordsToUpsert | List&lt;SObject&gt; | Records to upsert |
| externalIdField | SObjectField | Optional field to use as the external id for the upsert operation |
| allOrNone | Boolean | Boolean to throw an exception if any of the records already exist |
| accessLevel | System.AccessLevel | Access level of the user performing the operation |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

,[object Object]

#### Throws
DmlException: 

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