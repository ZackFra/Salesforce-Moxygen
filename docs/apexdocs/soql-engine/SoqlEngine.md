# SoqlEngine Class

This class is response for handling SOQL queries to the mock database

**Since** 

4/13/2024

**Group** Soql Engine

**Author** Zackary Frazier

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

---

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
| binds | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**Integer**

,[object Object]

---

### `doSelectQueryInternal(head, params)`

Internal, do not use this method

#### Signature
```apex
public List<SObject> doSelectQueryInternal(Node head, Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| head | [Node](Node.md) | `Node` |
| params | Map&lt;String,Object&gt; | `Map<String, Object>` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

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
**List&lt;SObject&gt;**

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
**List&lt;SObject&gt;**

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
| binds | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]