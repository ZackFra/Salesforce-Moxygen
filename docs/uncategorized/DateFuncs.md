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