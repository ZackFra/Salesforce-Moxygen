# HavingLogicHandler Class

This class is used to handle the having clause logic

**Since** 

3/23/2024

**Author** Zackary Frazier

**Inheritance**

[BooleanLogicHandler](BooleanLogicHandler.md)

## Fields
### `params`

*Inherited*

Parameters for bind variables in the query

#### Signature
```apex
public params
```

#### Type
Map&lt;String,Object&gt;

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

### `db`

*Inherited*

The database to use for queries

#### Signature
```apex
public db
```

#### Type
[MockDatabase](MockDatabase.md)

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

---

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