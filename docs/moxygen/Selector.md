# Selector Class

`SUPPRESSWARNINGS`

Wrapper class for Database class&#x27;s query methods. This class is used to allow for mocking of the Database class in unit tests.

**Since** 

3/9/2024

**Group** Moxygen

**Author** Zackary Frazier

## Methods
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

---

### `query(queryString)`

Query for a list of sObjects

#### Signature
```apex
public static List<SObject> query(String queryString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queryString | String | SOQL Query to be executed |

#### Return Type
**List&lt;SObject&gt;**

Returns a list of records that match the query. Will parse backticks out of the query string.

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