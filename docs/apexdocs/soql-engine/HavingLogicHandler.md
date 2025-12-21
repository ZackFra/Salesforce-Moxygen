# HavingLogicHandler Class

This class is used to handle the having clause logic

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[BooleanLogicHandler](BooleanLogicHandler.md)

## Fields
### `db`

*Inherited*

The database to use for queries

#### Signature
```apex
public db
```

#### Type
[MockDatabase](../mock-database/MockDatabase.md)

---

### `head`

*Inherited*

The head conditional node

#### Signature
```apex
public head
```

#### Type
[Node](Node.md)

---

### `obj`

*Inherited*

The object being compared (either SObject or Aggregate)

#### Signature
```apex
public obj
```

#### Type
Object

---

### `params`

*Inherited*

Parameters for bind variables in the query

#### Signature
```apex
public params
```

#### Type
Map<String,Object>

---

### `selectNode`

*Inherited*

The select node to compare against

#### Signature
```apex
public selectNode
```

#### Type
[Node](Node.md)

## Constructors
### `HavingLogicHandler(options)`

Constructor

#### Signature
```apex
public HavingLogicHandler(BooleanLogicOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [BooleanLogicOptions](BooleanLogicOptions.md) |  |

## Methods
### `evaluate()`

*Inherited*

Evaluate the conditional expression

#### Signature
```apex
public Boolean evaluate()
```

#### Return Type
**Boolean**

Whether the conditional expression is met

---

### `isCompareConditionMet(operatorNode)`

This method is used to check if the having condition is met

#### Signature
```apex
public override Boolean isCompareConditionMet(Node operatorNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| operatorNode | [Node](Node.md) | The operator node |

#### Return Type
**Boolean**

Boolean

#### Throws
Exception: