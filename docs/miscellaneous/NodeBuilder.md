# NodeBuilder Class

: Builder class for the Node class, used to create a Node

**Since** 

3/23/2024

**Author** Zackary Frazier

## Properties
### `id`

The id of the node

#### Signature
```apex
public id
```

#### Type
String

---

### `nodeType`

The type of the node

#### Signature
```apex
public nodeType
```

#### Type
String

---

### `left`

The left child of the node

#### Signature
```apex
public left
```

#### Type
[Node](Node.md)

---

### `right`

The right child of the node

#### Signature
```apex
public right
```

#### Type
[Node](Node.md)

## Methods
### `setId(id)`

: Sets the id of the node

#### Signature
```apex
public NodeBuilder setId(String id)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| id | String | : String, the id of the node |

#### Return Type
**[NodeBuilder](NodeBuilder.md)**

: NodeBuilder, the current instance of the NodeBuilder

---

### `setNodeType(nodeType)`

: Sets the type of the node

#### Signature
```apex
public NodeBuilder setNodeType(String nodeType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| nodeType | String | : String, the type of the node |

#### Return Type
**[NodeBuilder](NodeBuilder.md)**

: NodeBuilder, the current instance of the NodeBuilder

---

### `setLeft(left)`

: Sets the left child of the node

#### Signature
```apex
public NodeBuilder setLeft(Node left)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| left | [Node](Node.md) | : Node, the left child of the node |

#### Return Type
**[NodeBuilder](NodeBuilder.md)**

: NodeBuilder, the current instance of the NodeBuilder

---

### `setRight(right)`

: Sets the right child of the node

#### Signature
```apex
public NodeBuilder setRight(Node right)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| right | [Node](Node.md) | : Node, the right child of the node |

#### Return Type
**[NodeBuilder](NodeBuilder.md)**

: NodeBuilder, the current instance of the NodeBuilder

---

### `build()`

: Builds the node

#### Signature
```apex
public Node build()
```

#### Return Type
**[Node](Node.md)**

: Node, the built node