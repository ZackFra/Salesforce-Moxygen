# AggregateComparator Class

A class to compare two pre-Aggregate based on a set of fields 
(a pre-Aggregate is a ProtoAggregate where the keys are the field names and the values are the field values)

**Implements**

Comparator&lt;ProtoAggregate&gt;

## Constructors
### `AggregateComparator(fields)`

Constructor

#### Signature
```apex
public AggregateComparator(Map<String,Map<String,String>> fields)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fields | Map&lt;String,Map&lt;String,String&gt;&gt; | A map of field names and whether they&#x27;re ASC or DESC |

## Methods
### `compare(a, b)`

`SUPPRESSWARNINGS`

Compare two ProtoAggregates based on the fields provided in the constructor

#### Signature
```apex
public Integer compare(ProtoAggregate a, ProtoAggregate b)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| a | [ProtoAggregate](ProtoAggregate.md) | The first proto-Aggregate |
| b | [ProtoAggregate](ProtoAggregate.md) | The second proto-Aggregate |

#### Return Type
**Integer**

Integer