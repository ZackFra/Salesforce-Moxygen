# ObjectComparator Class

`SUPPRESSWARNINGS`

This class is used to compare two generic objects of the same type.

**Since** 

3/23/2024

**Author** Zackary Frazier

**Implements**

Comparator&lt;Object&gt;

## Methods
### `compare(obj1, obj2)`

`SUPPRESSWARNINGS`

This method compares two generic objects of the same type.

#### Signature
```apex
public Integer compare(Object obj1, Object obj2)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj1 | Object | The first object to compare. |
| obj2 | Object | The second object to compare. |

#### Return Type
**Integer**

An integer value indicating the result of the comparison.

#### Throws
UnsupportedTypeException: : If the type of the objects is not supported.