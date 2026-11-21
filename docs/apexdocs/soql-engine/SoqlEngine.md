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
**List<Aggregate>**

`List<Aggregate>`

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
**List<Aggregate>**

`List<Aggregate>`

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
| binds | Map<String,Object> | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List<Aggregate>**

`List<Aggregate>`

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

`Integer`

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

`Integer`

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

`Integer`

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
| params | Map<String,Object> | `Map<String, Object>` |

#### Return Type
**List<SObject>**

`List<SObject>`

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

`List<SObject>`

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

`List<SObject>`

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

`List<SObject>`