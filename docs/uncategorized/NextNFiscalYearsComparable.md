# NextNFiscalYearsComparable Class

Compare the date field value with the NEXT_N_FISCAL_YEARS:N token

**Since** 

1/11/2025

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

Check if the fieldValue is greater than the NEXT_N_FISCAL_YEARS:N token

#### Signature
```apex
public override Boolean isGreaterThan(Datetime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | Datetime | Datetime or Date to be compared |

#### Return Type
**Boolean**

Whether fieldValue is greater than the NEXT_N_FISCAL_YEARS:N token

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

---

### `isLessThan(fieldValue)`

Check if the fieldValue is less than the NEXT_N_FISCAL_YEARS:N token

#### Signature
```apex
public override Boolean isLessThan(Datetime fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldValue | Datetime | Datetime or Date to be compared |

#### Return Type
**Boolean**

Whether fieldValue is less than the NEXT_N_FISCAL_YEARS:N token

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| fieldValue | DateTime | `DateTime` |

#### Return Type
**Boolean**

,[object Object]

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
| token | String | `String` |

#### Return Type
**[DateLiteralComparable](DateLiteralComparable.md)**

,[object Object]