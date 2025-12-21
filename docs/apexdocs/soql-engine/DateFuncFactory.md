# DateFuncFactory Class

Factory class to create date functions by name

**Since**

1/17/2025

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `create(name)`

Create a date function by name

#### Signature
```apex
public static IDateFunc create(String name)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| name | String | Name of the date function to create |

#### Return Type
**[IDateFunc](IDateFunc.md)**

Instance of an IDateFunc

#### Throws
IllegalArgumentException: if the name is not a valid date function