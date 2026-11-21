# OrderByOptions Class

Options class for OrderBy

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `getObj()`

Getter for the object to be ordered

#### Signature
```apex
public Object getObj()
```

#### Return Type
**Object**

`Object`

---

### `getTopLevelNodes()`

Getter for the top level nodes

#### Signature
```apex
public TopLevelNodes getTopLevelNodes()
```

#### Return Type
**[TopLevelNodes](TopLevelNodes.md)**

`TopLevelNodes`

---

### `getType()`

Getter for the type of query

#### Signature
```apex
public Types.SOQL getType()
```

#### Return Type
**Types.SOQL**

`Types.SOQL`

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

`OrderByOptions`

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

`OrderByOptions`

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

`OrderByOptions`