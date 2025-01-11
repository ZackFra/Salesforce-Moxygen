# AggregateStandardProcessor Class

Standard processor for aggregate queries

**Since** 

3/23/2024

**Author** Zackary Frazier

**Inheritance**

[AggregateProcessor](AggregateProcessor.md)

## Methods
### `processRecord(databaseRecord)`

#### Signature
```apex
public override void processRecord(SObject databaseRecord)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| databaseRecord | SObject |  |

#### Return Type
**void**

---

### `finish()`

#### Signature
```apex
public override List<ProtoAggregate> finish()
```

#### Return Type
**List&lt;ProtoAggregate&gt;**

---

### `setTopLevelNodes(topLevelNodes)`

*Inherited*

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