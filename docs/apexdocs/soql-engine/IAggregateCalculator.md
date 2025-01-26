# IAggregateCalculator Interface

Interface for aggregate calculator

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `calculate()`

Calculate the aggregate of the data

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](../utilities/ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Calculate the aggregate of the data, for the field specified by `alias` in the options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]