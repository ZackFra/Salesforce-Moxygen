# FieldSelector Class

FieldSelector is a class that is used to select fields from a queried record based on a field node.

**Since** 

3/23/2024

**Author** Zackary Frazier

## Fields
### `databaseRecord`

#### Signature
```apex
public databaseRecord
```

#### Type
SObject

---

### `fieldNode`

#### Signature
```apex
public fieldNode
```

#### Type
[Node](Node.md)

---

### `params`

#### Signature
```apex
public params
```

#### Type
Map&lt;String,Object&gt;

---

### `queriedRecord`

#### Signature
```apex
public queriedRecord
```

#### Type
SObject

## Methods
### `setDatabaseRecord(databaseRecord)`

Setter for the `databaseRecord` property

#### Signature
```apex
public FieldSelector setDatabaseRecord(SObject databaseRecord)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| databaseRecord | SObject |  |

#### Return Type
**[FieldSelector](FieldSelector.md)**

,[object Object]

---

### `setFieldNode(fieldNode)`

Setter for the `fieldNode` property

#### Signature
```apex
public FieldSelector setFieldNode(Node fieldNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldNode | [Node](Node.md) |  |

#### Return Type
**[FieldSelector](FieldSelector.md)**

,[object Object]

---

### `setParams(params)`

Setter for the `params` property

#### Signature
```apex
public FieldSelector setParams(Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| params | Map&lt;String,Object&gt; |  |

#### Return Type
**[FieldSelector](FieldSelector.md)**

,[object Object]

---

### `setQueriedRecord(queriedRecord)`

Setter for the `queriedRecord` property

#### Signature
```apex
public FieldSelector setQueriedRecord(SObject queriedRecord)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queriedRecord | SObject |  |

#### Return Type
**[FieldSelector](FieldSelector.md)**

,[object Object]