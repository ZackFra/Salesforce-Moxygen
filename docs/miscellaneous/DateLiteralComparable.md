# DateLiteralComparable Class
`abstract`

Abstract class for date literal comparison

**Since** 

12/28/2024

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
public virtual Boolean isEqual(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| token | String | `String` |

#### Return Type
**[DateLiteralComparable](DateLiteralComparable.md)**

,[object Object]