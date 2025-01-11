# AliasService Class

Tool for finding the aliases on nodes

**Since** 

3/23/2024

**Author** Zackary Frazier

## Methods
### `getFieldAlias(curr, fieldNode, selectNode)`

Get the field alias

#### Signature
```apex
public static Map<String,String> getFieldAlias(Node curr, Node fieldNode, Node selectNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| curr | [Node](Node.md) |  |
| fieldNode | [Node](Node.md) |  |
| selectNode | [Node](Node.md) |  |

#### Return Type
**Map&lt;String,String&gt;**

,[object Object]

---

### `getAlias(selectNode, fieldNode)`

#### Signature
```apex
public static Map<String,String> getAlias(Node selectNode, Node fieldNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| selectNode | [Node](Node.md) |  |
| fieldNode | [Node](Node.md) |  |

#### Return Type
**Map&lt;String,String&gt;**