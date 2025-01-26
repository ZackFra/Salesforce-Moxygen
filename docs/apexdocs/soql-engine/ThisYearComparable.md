# ThisYearComparable Class

Comparable for THIS_YEAR

**Since** 

1/4/2025

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[DateLiteralComparable](DateLiteralComparable.md)

## Properties
### `token`

*Inherited*

The token for the date literal

#### Signature
```apex
public token
```

#### Type
String

## Methods
### `isEqual(fieldValue)`

*Inherited*

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

#### Signature
```apex
public override Boolean isGreaterThan(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime |  |

#### Return Type
**Boolean**

---

### `isGreaterThanOrEqual(fieldValue)`

*Inherited*

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

#### Signature
```apex
public override Boolean isLessThan(DateTime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | DateTime |  |

#### Return Type
**Boolean**

---

### `isLessThanOrEqual(fieldValue)`

*Inherited*

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

*Inherited*

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

*Inherited*

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