# MockRecordQueryHandler Class

This class is responsible for handling record SOQL queries to the mock database

**Since**

4/12/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[MockSOQLHandler](MockSOQLHandler.md)

## Methods
### `doQuery(selectNode, params)`

`SUPPRESSWARNINGS`

Used internally, do not use this method

#### Signature
```apex
public List<SObject> doQuery(Node selectNode, Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| selectNode | [Node](Node.md) | The select node |
| params | Map<String,Object> | The query parameters |

#### Return Type
**List<SObject>**

The query results

#### Throws
QueryException: If the query is invalid

---

### `query(query)`

Query the database for records

#### Signature
```apex
public List<SObject> query(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |

#### Return Type
**List<SObject>**

,[object Object]

---

### `query(query, accessLevel)`

Query the database for records, with access level

#### Signature
```apex
public List<SObject> query(String query, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List<SObject>**

,[object Object]

---

### `queryWithBinds(query, binds, accessLevel)`

Query the database for records, with binds

#### Signature
```apex
public List<SObject> queryWithBinds(String query, Map<String,Object> binds, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| binds | Map<String,Object> | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List<SObject>**

,[object Object]