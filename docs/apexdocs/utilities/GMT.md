# GMT Class

Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT

**Since**

11/16/2024

**Group** Utilities

**Author** Zackary Frazier

## Methods
### `date(dt)`

Return the date in GMT of the date time

#### Signature
```apex
public static Date date(DateTime dt)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dt | DateTime |  |

#### Return Type
**Date**

`Date`

---

### `dateTime(d)`

Return the date time in GMT of the date

#### Signature
```apex
public static DateTime dateTime(Date d)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| d | Date | `Date` |

#### Return Type
**DateTime**

`DateTime`

---

### `fiscalMonth(value)`

Fiscal month for a date, from 1 to 12

#### Signature
```apex
public static Integer fiscalMonth(Date value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Date | `Date` |

#### Return Type
**Integer**

`Integer`

---

### `fiscalQuarter(value)`

Fiscal quarter for a date, from 1 to 4

#### Signature
```apex
public static Integer fiscalQuarter(Date value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Date | `Date` |

#### Return Type
**Integer**

`Integer`

---

### `fiscalStartMonth()`

Month the org&#x27;s standard fiscal year starts, from 1 to 12

#### Signature
```apex
public static Integer fiscalStartMonth()
```

#### Return Type
**Integer**

`Integer`

---

### `fiscalYear(value)`

Fiscal year number for a date. Standard fiscal years are named for the year they end.

#### Signature
```apex
public static Integer fiscalYear(Date value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Date | `Date` |

#### Return Type
**Integer**

`Integer`

---

### `fiscalYearStart(value)`

First day of the standard fiscal year that contains the date

#### Signature
```apex
public static Date fiscalYearStart(Date value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| value | Date | `Date` |

#### Return Type
**Date**

`Date`

---

### `now()`

Return today&#x27;s date time in GMT

#### Signature
```apex
public static DateTime now()
```

#### Return Type
**DateTime**

`DateTime`

---

### `startOfThisCalendarQuarter()`

Return the start of the current calendar quarter

#### Signature
```apex
public static Datetime startOfThisCalendarQuarter()
```

#### Return Type
**Datetime**

`Date`

---

### `startOfthisFiscalQuarter()`

Return the start of the current fiscal quarter

#### Signature
```apex
public static Date startOfthisFiscalQuarter()
```

#### Return Type
**Date**

`Date`

---

### `startOfThisFiscalYear()`

Return the start of the current fiscal year

#### Signature
```apex
public static Date startOfThisFiscalYear()
```

#### Return Type
**Date**

`Date`

---

### `today()`

Return today&#x27;s date in GMT

#### Signature
```apex
public static Date today()
```

#### Return Type
**Date**

`Date`