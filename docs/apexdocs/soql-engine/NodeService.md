# NodeService Class

Service class for manipulating and describing the nodes of the AST created by the parser 
each method is a static method that takes in a TopLevelNodes

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `isAggregateQuery(topLevelNodes)`

Returns whether or not the query is an aggregate query

#### Signature
```apex
public static Boolean isAggregateQuery(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | `TopLevelNodes` |

#### Return Type
**Boolean**

,[object Object]

---

### `isSingularCount(topLevelNodes)`

Returns whether this is a COUNT query

#### Signature
```apex
public static Boolean isSingularCount(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | `TopLevelNodes` |

#### Return Type
**Boolean**

,[object Object]