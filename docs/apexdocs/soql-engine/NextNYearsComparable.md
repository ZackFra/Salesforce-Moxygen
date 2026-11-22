# NextNYearsComparable Class

Comparable for NEXT_N_YEARS

**Since**

2/5/2025

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[DateLiteralComparable](DateLiteralComparable.md)

## Properties
### `n`

*Inherited*

The number in variable date literals

#### Signature
```apex
public n
```

#### Type
Integer

---

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
public Boolean isEqual(Object fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | Object | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is equal to the date literal

---

### `isGreaterThan(rawField)`

#### Signature
```apex
public override Boolean isGreaterThan(Object rawField)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| rawField | Object |  |

#### Return Type
**Boolean**

---

### `isGreaterThanOrEqual(fieldValue)`

*Inherited*

Whether the date literal is greater than or equal to the field value

#### Signature
```apex
public Boolean isGreaterThanOrEqual(Object fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | Object | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is greater than or equal to the date literal

---

### `isLessThan(rawField)`

#### Signature
```apex
public override Boolean isLessThan(Object rawField)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| rawField | Object |  |

#### Return Type
**Boolean**

---

### `isLessThanOrEqual(fieldValue)`

*Inherited*

Whether the date literal is less than or equal to the field value

#### Signature
```apex
public Boolean isLessThanOrEqual(Object fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | Object | Date or Datetime value |

#### Return Type
**Boolean**

Whether fieldValue is less than or equal to the date literal

---

### `isNotEqual(fieldValue)`

*Inherited*

Whether the date literal is not equal to the field value

#### Signature
```apex
public Boolean isNotEqual(Object fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | Object | Date or Datetime value |

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