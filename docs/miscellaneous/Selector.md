# Selector Class

`SUPPRESSWARNINGS`

Wrapper class for Database class

**Since** 

3/9/2024

**Author** Zackary Frazier

## Methods
### `query(queryString)`

Query for a list of sObjects

#### Signature
```apex
public static List<SObject> query(String queryString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

---

### `query(queryString, accessLevel)`

Query for a list of sObjects

#### Signature
```apex
public static List<SObject> query(String queryString, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

---

### `queryWithBinds(queryString, bindMap, accessLevel)`

Query for a list of sObjects with bind variables

#### Signature
```apex
public static List<SObject> queryWithBinds(String queryString, Map<String,Object> bindMap, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |
| bindMap | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

---

### `aggregateQuery(queryString)`

perform an aggregate query

#### Signature
```apex
public static List<Aggregate> aggregateQuery(String queryString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |

#### Return Type
**List&lt;Aggregate&gt;**

,[object Object]

---

### `aggregateQuery(queryString, accessLevel)`

Query for a list of sObjects

#### Signature
```apex
public static List<Aggregate> aggregateQuery(String queryString, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;Aggregate&gt;**

,[object Object]

---

### `aggregateQueryWithBinds(queryString, bindMap, accessLevel)`

Query for a list of sObjects with bind variables

#### Signature
```apex
public static List<Aggregate> aggregateQueryWithBinds(String queryString, Map<String,Object> bindMap, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |
| bindMap | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**List&lt;Aggregate&gt;**

,[object Object]

---

### `countQuery(queryString)`

Count the number of records returned by a query

#### Signature
```apex
public static Integer countQuery(String queryString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |

#### Return Type
**Integer**

,[object Object]

---

### `countQuery(queryString, accessLevel)`

Count the number of records returned by a query

#### Signature
```apex
public static Integer countQuery(String queryString, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**Integer**

,[object Object]

---

### `countQueryWithBinds(queryString, bindMap, accessLevel)`

Count the number of records returned by a query

#### Signature
```apex
public static Integer countQueryWithBinds(String queryString, Map<String,Object> bindMap, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | `String` |
| bindMap | Map&lt;String,Object&gt; | `Map<String, Object>` |
| accessLevel | System.AccessLevel | `System.AccessLevel` |

#### Return Type
**Integer**

,[object Object]