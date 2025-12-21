# BooleanLogicHandler Class
`virtual`

A class to handle boolean logic, when it comes to HAVING and WHERE clauses, it&#x27;s all the same except for the comparison

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Fields
### `db`

The database to use for queries

#### Signature
```apex
public db
```

#### Type
[MockDatabase](../mock-database/MockDatabase.md)

---

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

## Constructors
### `BooleanLogicHandler(options)`

Constructor

#### Signature
```apex
public BooleanLogicHandler(BooleanLogicOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [BooleanLogicOptions](BooleanLogicOptions.md) | The options for the handler |

## Methods
### `evaluate()`

Evaluate the conditional expression

#### Signature
```apex
public Boolean evaluate()
```

#### Return Type
**Boolean**

Whether the conditional expression is met

---

### `isCompareConditionMet(node)`

Evaluate the conditional expression, intended to be overridden

#### Signature
```apex
public virtual Boolean isCompareConditionMet(Node node)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| node | [Node](Node.md) | The node to evaluate |

#### Return Type
**Boolean**

Whether the conditional expression is met