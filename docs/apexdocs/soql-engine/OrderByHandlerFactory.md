# OrderByHandlerFactory Class

Factory class for creating OrderByHandler instances

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `createHandler()`

Create a new instance of the OrderByHandler class

#### Signature
```apex
public OrderByHandler createHandler()
```

#### Return Type
**[OrderByHandler](OrderByHandler.md)**

,[object Object]

#### Throws
OrderByException: 

---

### `setObj(obj)`

Setter for the object to be queried

#### Signature
```apex
public OrderByHandlerFactory setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object | `List<ProtoAggregate> | List<SObject>` |

#### Return Type
**[OrderByHandlerFactory](OrderByHandlerFactory.md)**

,[object Object]

---

### `setTopLevelNodes(topLevelNodes)`

Setter for the top level nodes of the query

#### Signature
```apex
public OrderByHandlerFactory setTopLevelNodes(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | `TopLevelNodes` |

#### Return Type
**[OrderByHandlerFactory](OrderByHandlerFactory.md)**

,[object Object]

---

### `setType(type)`

Setter for the type of query to be executed

#### Signature
```apex
public OrderByHandlerFactory setType(Types.SOQL type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.SOQL | `Types.SOQL` |

#### Return Type
**[OrderByHandlerFactory](OrderByHandlerFactory.md)**

,[object Object]