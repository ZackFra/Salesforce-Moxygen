/**
 * @description Handles the LessThanOrEqual operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public class LessThanOrEqualHandler implements IOperatorHandler {
    /**
     * @description Handles the LessThanOrEqual operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     * @exception QueryException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        if(sObjectFieldValue == null) {
            return false;
        }

        if(sObjectFieldValue instanceOf Date) {
            Date fieldDate = Common.parseDate((String) fieldValue);
            Date sObjDate = (Date) sObjectFieldValue;
            return sObjDate <= fieldDate;
        } else if(sObjectFieldValue instanceOf DateTime) {
            DateTime fieldDateTime = Common.parseDateTime((String) fieldValue);
            DateTime sObjDateTime = (DateTime) sObjectFieldValue;
            return sObjDateTime <= fieldDateTime;
        } else if(sObjectFieldValue instanceOf Time) {
            Time sObjTime = (Time) sObjectFieldValue;
            return sObjTime <= Common.parseTime((String) fieldValue);
        } else if(sObjectFieldValue instanceOf Integer) {
            Integer fieldInt = Integer.valueOf((String)fieldValue);
            Integer sObjInt = (Integer) sObjectFieldValue;
            return sObjInt <= fieldInt;
        }  else if(sObjectFieldValue instanceOf Long) {
            Long fieldLong = Long.valueOf((String) fieldValue);
            Long sObjLong = (Long) sObjectFieldValue;
            return sObjLong <= fieldLong;
        } else if(sObjectFieldValue instanceOf String) {
            String fieldString = ((String) fieldValue).toLowerCase();
            String sObjString = ((String) sObjectFieldValue).toLowerCase();
            return sObjString <= fieldString;
        } else if(sObjectFieldValue instanceOf Decimal) {
            Decimal fieldDec = Decimal.valueOf((String)fieldValue);
            Decimal sObjDec = (Decimal) sObjectFieldValue;
            return sObjDec <= fieldDec;
        } else {
            throw new QueryException('Invalid field type');
        }
    }
}