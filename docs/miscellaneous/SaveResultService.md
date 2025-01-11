# SaveResultService Class

`ISTEST`

This class is used to create success and failure results for DML operations.

## Methods
### `createSuccess(recordId, resultType)`

This method is used to create a success result for DML operations.

#### Signature
```apex
public Object createSuccess(Id recordId, Type resultType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordId | Id | The Id of the record that was created or updated. |
| resultType | Type | The type of result to create. |

#### Return Type
**Object**

The success result.

---

### `createFailure(message, resultType)`

This method is used to create a failure result for DML operations.

#### Signature
```apex
public Object createFailure(String message, Type resultType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| message | String | The error message. |
| resultType | Type | The type of result to create. |

#### Return Type
**Object**

The failure result.