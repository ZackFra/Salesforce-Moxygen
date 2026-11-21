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