# TopLevelNodes Class

This class is used to parse the top level nodes of a SOQL query. 
Designed to refresh the instance if the head node changes, i.e. if a new SOQL query is made.

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Properties
### `forUpdateNode`

The FOR UPDATE node of the SOQL query.

#### Signature
```apex
public forUpdateNode
```

#### Type
[Node](Node.md)

---

### `fromNode`

The FROM node of the SOQL query.

#### Signature
```apex
public fromNode
```

#### Type
[Node](Node.md)

---

### `groupByNode`

The GROUP BY node of the SOQL query.

#### Signature
```apex
public groupByNode
```

#### Type
[Node](Node.md)

---

### `havingNode`

The HAVING node of the SOQL query.

#### Signature
```apex
public havingNode
```

#### Type
[Node](Node.md)

---

### `limitNode`

The LIMIT node of the SOQL query.

#### Signature
```apex
public limitNode
```

#### Type
[Node](Node.md)

---

### `offsetNode`

The OFFSET node of the SOQL query.

#### Signature
```apex
public offsetNode
```

#### Type
[Node](Node.md)

---

### `orderByNode`

The ORDER BY node of the SOQL query.

#### Signature
```apex
public orderByNode
```

#### Type
[Node](Node.md)

---

### `selectNode`

The main node of the SOQL query, the SELECT node.

#### Signature
```apex
public selectNode
```

#### Type
[Node](Node.md)

---

### `usingScopeNode`

The USING SCOPE node of the SOQL query.

#### Signature
```apex
public usingScopeNode
```

#### Type
[Node](Node.md)

---

### `whereNode`

The WHERE node of the SOQL query.

#### Signature
```apex
public whereNode
```

#### Type
[Node](Node.md)

## Constructors
### `TopLevelNodes(selectNode)`

Constructor for the TopLevelNodes class.

#### Signature
```apex
public TopLevelNodes(Node selectNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| selectNode | [Node](Node.md) | ,[object Object], the head node of the SOQL query. |