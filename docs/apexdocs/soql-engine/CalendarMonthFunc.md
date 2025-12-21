# CalendarMonthFunc Class

Function to calculate the calendar month of a date or datetime value

**Since**

1/17/2025

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IDateFunc](IDateFunc.md)

## Methods
### `calculate(value)`

Returns the calendar month of a date or datetime value

#### Signature
```apex
public Integer calculate(Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Object | Date or Datetime value to calculate the calendar month of |

#### Return Type
**Integer**

The calendar month of the date or datetime value

#### Throws
QueryException: if the value is not a Date or DateTime