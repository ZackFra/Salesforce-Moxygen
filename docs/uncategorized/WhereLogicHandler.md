# WhereLogicHandler Class

`SUPPRESSWARNINGS`

This class is responsible for handling the WHERE clause logic

**Since** 

3/23/2024

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
[MockDatabase](MockDatabase.md)

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
Map&lt;String,Object&gt;

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
### `WhereLogicHandler(options)`

Constructor

#### Signature
```apex
public WhereLogicHandler(BooleanLogicOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [BooleanLogicOptions](BooleanLogicOptions.md) | - the options to be used for the handler |

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

Checks if the WHERE clause is met

#### Signature
```apex
public override Boolean isCompareConditionMet(Node operatorNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| operatorNode | [Node](Node.md) |  |

#### Return Type
**Boolean**

,[object Object]

#### Throws
QueryException: