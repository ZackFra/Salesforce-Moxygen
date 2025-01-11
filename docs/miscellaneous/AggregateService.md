# AggregateService Class

`SUPPRESSWARNINGS`

Contains static methods for working with aggregates and proto-aggregates

**Since** 

3/23/2024

**Author** Zackary Frazier

## Fields
### `SUPPORTED_COUNT_FUNCS`

#### Signature
```apex
public final static SUPPORTED_COUNT_FUNCS
```

#### Type
List&lt;String&gt;

---

### `SUPPORTED_NUMERIC_FUNCS`

#### Signature
```apex
public final static SUPPORTED_NUMERIC_FUNCS
```

#### Type
List&lt;String&gt;

---

### `SUPPORTED_DATE_FUNCS`

#### Signature
```apex
public final static SUPPORTED_DATE_FUNCS
```

#### Type
List&lt;String&gt;

---

### `SUPPORTED_AGGREGATE_FUNCS`

#### Signature
```apex
public final static SUPPORTED_AGGREGATE_FUNCS
```

#### Type
List&lt;String&gt;

## Methods
### `isCountFunc(type, nodeId)`

Returns whether a node type and node id represent a count function

#### Signature
```apex
public static Boolean isCountFunc(String type, String nodeId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | String | `String` |
| nodeId | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `isDateFunc(type, nodeId)`

Returns whether this function is a date function

#### Signature
```apex
public static Boolean isDateFunc(String type, String nodeId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | String | `String` |
| nodeId | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `isNumericFunc(type, nodeId)`

Returns whether this function is a numeric function

#### Signature
```apex
public static Boolean isNumericFunc(String type, String nodeId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | String | `String` |
| nodeId | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `isAggregateFunc(nodeType, nodeId)`

Returns whether the node is an aggregate function

#### Signature
```apex
public static Boolean isAggregateFunc(String nodeType, String nodeId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| nodeType | String | `String` |
| nodeId | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `getAggregateFields(topLevelNodes)`

`SUPPRESSWARNINGS`

: given the top level nodes, return a map with the fields to group by and the fields to select

#### Signature
```apex
public static Map<String,List<String>> getAggregateFields(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | : the top level nodes of the query |

#### Return Type
**Map&lt;String,List&lt;String&gt;&gt;**

: a map with the fields to group by and the fields to select