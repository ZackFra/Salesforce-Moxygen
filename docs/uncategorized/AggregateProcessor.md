# AggregateProcessor Class
`abstract`

Processor for aggregate functions

**Since** 

3/23/2024

**Author** Zackary Frazier

## Methods
### `finish()`

Finish processing the records and return the aggregates

#### Signature
```apex
public abstract List<ProtoAggregate> finish()
```

#### Return Type
**List&lt;ProtoAggregate&gt;**

,[object Object]

---

### `processRecord(databaseRecord)`

Process a record from the database

#### Signature
```apex
public abstract void processRecord(SObject databaseRecord)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| databaseRecord | SObject |  |

#### Return Type
**void**

---

### `setTopLevelNodes(topLevelNodes)`

Set the top level nodes to use for processing

#### Signature
```apex
public AggregateProcessor setTopLevelNodes(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) |  |

#### Return Type
**[AggregateProcessor](AggregateProcessor.md)**

,[object Object]