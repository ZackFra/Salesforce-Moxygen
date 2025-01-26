# DateLiteralComparable Class
`abstract`

Abstract class for date literal comparison

**Since** 

12/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Properties
### `token`

The token for the date literal

#### Signature
```apex
public token
```

#### Type
String

## Methods
### `isEqual(fieldValue)`

Whether the date literal is equal to the field value

#### Signature
```apex
public Boolean isEqual(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is equal to the date literal

---

### `isGreaterThan(fieldValue)`

Whether the date literal is greater than the field value

#### Signature
```apex
public abstract Boolean isGreaterThan(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is greater than the date literal

---

### `isGreaterThanOrEqual(fieldValue)`

Whether the date literal is greater than or equal to the field value

#### Signature
```apex
public Boolean isGreaterThanOrEqual(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is greater than or equal to the date literal

---

### `isLessThan(fieldValue)`

Whether the date literal is less than the field value

#### Signature
```apex
public abstract Boolean isLessThan(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is less than the date literal

---

### `isLessThanOrEqual(fieldValue)`

Whether the date literal is less than or equal to the field value

#### Signature
```apex
public Boolean isLessThanOrEqual(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is less than or equal to the date literal

---

### `isNotEqual(fieldValue)`

Whether the date literal is not equal to the field value

#### Signature
```apex
public Boolean isNotEqual(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is not equal to the date literal

---

### `withToken(token)`

Sets the token for the date literal

#### Signature
```apex
public DateLiteralComparable withToken(String token)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| token | String | Parsed token |

#### Return Type
**[DateLiteralComparable](DateLiteralComparable.md)**

This instance of DateLiteralComparable