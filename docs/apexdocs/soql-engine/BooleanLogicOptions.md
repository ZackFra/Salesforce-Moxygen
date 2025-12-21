# BooleanLogicOptions Class

This class is used to store the options for the BooleanLogic class

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Fields
### `head`

The head conditional node

#### Signature
```apex
public head
```

#### Type
[Node](Node.md)

---

### `obj`

The object being compared (either SObject or Aggregate)

#### Signature
```apex
public obj
```

#### Type
Object

---

### `params`

Parameters for bind variables in the query

#### Signature
```apex
public params
```

#### Type
Map<String,Object>

---

### `selectNode`

The select node to compare against

#### Signature
```apex
public selectNode
```

#### Type
[Node](Node.md)

## Methods
### `setHead(head)`

Setter for `head` node

#### Signature
```apex
public BooleanLogicOptions setHead(Node head)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| head | [Node](Node.md) |  |

#### Return Type
**[BooleanLogicOptions](BooleanLogicOptions.md)**

,[object Object]

---

### `setObj(obj)`

Setter for `obj`

#### Signature
```apex
public BooleanLogicOptions setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object |  |

#### Return Type
**[BooleanLogicOptions](BooleanLogicOptions.md)**

,[object Object]

---

### `setParams(params)`

Setter for `params`

#### Signature
```apex
public BooleanLogicOptions setParams(Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| params | Map<String,Object> |  |

#### Return Type
**[BooleanLogicOptions](BooleanLogicOptions.md)**

,[object Object]

---

### `setSelectNode(selectNode)`

Setter for `selectNode`

#### Signature
```apex
public BooleanLogicOptions setSelectNode(Node selectNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| selectNode | [Node](Node.md) |  |

#### Return Type
**[BooleanLogicOptions](BooleanLogicOptions.md)**

,[object Object]