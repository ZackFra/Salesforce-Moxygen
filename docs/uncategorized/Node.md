# Node Class

: Returns a string representation of the AST

**Since** 

3/23/2024

**Author** Zackary Frazier

## Fields
### `left`

#### Signature
```apex
public left
```

#### Type
[Node](Node.md)

---

### `right`

#### Signature
```apex
public right
```

#### Type
[Node](Node.md)

## Properties
### `id`

The id of the node, cannot be null

#### Signature
```apex
public id
```

#### Type
String

---

### `nodeType`

The type of the node, cannot be null

#### Signature
```apex
public nodeType
```

#### Type
String

## Constructors
### `Node(nodeType, id, left, right)`

: Constructor for a Node, not to be used directly

#### Signature
```apex
public Node(String nodeType, string id, Node left, Node right)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| nodeType | String | : String, the type of the node |
| id | string | : String, the id of the node |
| left | [Node](Node.md) | : Node, the left child of the node |
| right | [Node](Node.md) | : Node, the right child of the node |

## Methods
### `deepClone()`

: Clones a node and all of its children, recursively

#### Signature
```apex
public Node deepClone()
```

#### Return Type
**[Node](Node.md)**

: Node, the cloned tree

---

### `toString()`

: Returns a string representation of the node by traversing the tree in pre-order

#### Signature
```apex
public override String toString()
```

#### Return Type
**String**

: String, the string representation of the node