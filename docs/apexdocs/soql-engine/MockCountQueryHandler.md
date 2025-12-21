# MockCountQueryHandler Class

This class is responsible for handling count SOQL queries to the mock database

**Since**

4/13/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[MockSOQLHandler](MockSOQLHandler.md)

## Methods
### `countQuery(query)`

Perform a count query

#### Signature
```apex
public Integer countQuery(String query)
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
public Integer countQuery(String query, System.AccessLevel accessLevel)
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
public Integer countQueryWithBinds(String query, Map<String,Object> binds, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| binds | Map<String,Object> | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**Integer**

,[object Object]