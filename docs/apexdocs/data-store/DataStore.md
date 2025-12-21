# DataStore Class

Static data store for records

**Since**

1/25/2025

**Group** Data Store

**Author** Zackary Frazier

## Methods
### `count()`

Count the number of records in the data store

#### Signature
```apex
public static Integer count()
```

#### Return Type
**Integer**

Number of records in the static data store

---

### `getAllBySot(sot)`

return all SObjects of a given type

#### Signature
```apex
public static Map<Id,SObject> getAllBySot(SObjectType sot)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sot | SObjectType | The SObjectType to get records for |

#### Return Type
**Map<Id,SObject>**

Map of records by id for the given object type

---

### `getById(recordId)`

Get a record by id

#### Signature
```apex
public static SObject getById(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | Id of the record to get |

#### Return Type
**SObject**

The record with the given id

---

### `isRecordInDataStore(recordId)`

Returns whether a record exists in the data store

#### Signature
```apex
public static Boolean isRecordInDataStore(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | Record id to check |

#### Return Type
**Boolean**

Whether the record exists in the data store

---

### `isSoftDeleted(recordId)`

Returns if a record has been deleted

#### Signature
```apex
public static Boolean isSoftDeleted(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | Id of the record |

#### Return Type
**Boolean**

Whether the record has been deleted

---

### `put(insertedRecord)`

Put a record into the data store, or update it if it already exists

#### Signature
```apex
public static void put(SObject insertedRecord)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| insertedRecord | SObject | Record to be upserted |

#### Return Type
**void**

#### Throws
IllegalArgumentException: if the id is null

---

### `put(insertedRecords)`

Put a list of records into the data store, or update them if they already exist

#### Signature
```apex
public static void put(List<SObject> insertedRecords)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| insertedRecords | List<SObject> | Records to be upserted |

#### Return Type
**void**

---

### `restore(recordId)`

Undelete a record that was soft deleted in the data store

#### Signature
```apex
public static void restore(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | Id of the record to undelete |

#### Return Type
**void**

---

### `softDelete(recordId)`

Delete a record from the data store

#### Signature
```apex
public static void softDelete(Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | The record id |

#### Return Type
**void**