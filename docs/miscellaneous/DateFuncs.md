# DateFuncs Class

Repository of aggregate date functions

**Since** 

4/28/2024

**Author** Zackary Frazier

## Methods
### `execute(dateFunc, dateOrDateTimeValue)`

Determins which date function to execute and executes it

#### Signature
```apex
public static Integer execute(String dateFunc, Object dateOrDateTimeValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dateFunc | String | `String` |
| dateOrDateTimeValue | Object | `Date|Datetime` |

#### Return Type
**Integer**

,[object Object]

#### Throws
IllegalArgumentException: 

---

### `calendarMonth(value)`

CALENDAR_MONTH function

#### Signature
```apex
public static Integer calendarMonth(Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Object | `Date|DateTime` |

#### Return Type
**Integer**

,[object Object]

#### Throws
QueryException: 

---

### `calendarYear(value)`

CALENDAR_YEAR function

#### Signature
```apex
public static Integer calendarYear(Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Object | `Date|DateTime` |

#### Return Type
**Integer**

,[object Object]

#### Throws
QueryException: 

---

### `calendarQuarter(value)`

Calculates the calendar quarter of a given Date or DateTime

#### Signature
```apex
public static Integer calendarQuarter(Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Object | `Date|DateTime` |

#### Return Type
**Integer**

,[object Object]

#### Throws
QueryException: