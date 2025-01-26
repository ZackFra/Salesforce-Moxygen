# MockAggregateQueryHandler Class

This class is responsible for handling aggregate SOQL queries to the mock database

**Since** 

4/13/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[MockSOQLHandler](MockSOQLHandler.md)

## Methods
### `aggregateQuery(query)`

Perform an aggregate query

#### Signature
```apex
public List<Aggregate> aggregateQuery(String query)
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
public List<Aggregate> aggregateQuery(String query, System.AccessLevel accessLevel)
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
public List<Aggregate> aggregateQueryWithBinds(String query, Map<String,Object> binds, System.AccessLevel accessLevel)
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