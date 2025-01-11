# DateLiteral Class
`virtual`

Represents the value and new record field value for a date literal

**Since** 

11/27/2024

**Author** Zackary Frazier

## Properties
### `fieldValue`

The field value to the date literal token

#### Signature
```apex
public fieldValue
```

#### Type
String

## Classes
### Builder Class

Builder for the DateLiteral class

**Implements**

[IBuilder](../interfaces/IBuilder.md)

#### Methods
##### `setFieldValue(fieldValue)`

Set the field value

###### Signature
```apex
public Builder setFieldValue(String fieldValue)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | String | `String` |

###### Return Type
**Builder**

,[object Object]

---

##### `build()`

Build the DateLiteral

###### Signature
```apex
public DateLiteral build()
```

###### Return Type
**[DateLiteral](DateLiteral.md)**

,[object Object]