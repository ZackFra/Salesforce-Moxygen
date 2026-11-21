# DateFuncBase Class
`abstract`

Shared date and datetime normalization for SOQL date functions

**Since**

11/21/2026

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IDateFunc](IDateFunc.md)

## Methods
### `calculate(value)`

Calculate the date function value

#### Signature
```apex
public abstract Object calculate(Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Object | Date or Datetime value |

#### Return Type
**Object**

Calculated value, or null when the input is null