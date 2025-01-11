# OrderByOptions Class

Options class for OrderBy

**Since** 

3/23/2024

**Author** Zackary Frazier

## Methods
### `getType()`

Getter for the type of query

#### Signature
```apex
public Types.SOQL getType()
```

#### Return Type
**Types.SOQL**

,[object Object]

---

### `setType(type)`

Setter for the type of query

#### Signature
```apex
public OrderByOptions setType(Types.SOQL type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.SOQL | `Types.SOQL` |

#### Return Type
**[OrderByOptions](OrderByOptions.md)**

,[object Object]

---

### `setObj(obj)`

Setter for the object to be queried

#### Signature
```apex
public OrderByOptions setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object | `List<ProtoAggreate> | List<SObject>` |

#### Return Type
**[OrderByOptions](OrderByOptions.md)**

,[object Object]

---

### `getObj()`

Getter for the object to be ordered

#### Signature
```apex
public Object getObj()
```

#### Return Type
**Object**

,[object Object]

---

### `setTopLevelNodes(topLevelNodes)`

Setter for the top level nodes

#### Signature
```apex
public OrderByOptions setTopLevelNodes(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | `TopLevelNodes` |

#### Return Type
**[OrderByOptions](OrderByOptions.md)**

,[object Object]

---

### `getTopLevelNodes()`

Getter for the top level nodes

#### Signature
```apex
public TopLevelNodes getTopLevelNodes()
```

#### Return Type
**[TopLevelNodes](TopLevelNodes.md)**

,[object Object]