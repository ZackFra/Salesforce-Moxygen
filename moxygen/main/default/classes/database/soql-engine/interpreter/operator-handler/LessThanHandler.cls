/*
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

/**
 * @description Handles the less than operator
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public class LessThanHandler implements IOperatorHandler {
    /**
     * @description Handles the less than operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     * @exception QueryException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        if (sObjectFieldValue == null) {
            return false;
        } else if (fieldValue == null) {
            throw new QueryException('invalid operator');
        }

        if (fieldValue instanceof DateLiteral) {
            DateLiteralComparable dateLiteral = (DateLiteralComparable) DateLiteralComparableFactory.create(
                (DateLiteral) fieldValue
            );
            return dateLiteral.isLessThan((DateTime) sObjectFieldValue);
        }

        if (sObjectFieldValue instanceof Date) {
            Date fieldDate = Common.parseDate((String) fieldValue);
            Date sObjDate = (Date) sObjectFieldValue;
            return sObjDate < fieldDate;
        } else if (sObjectFieldValue instanceof DateTime) {
            DateTime fieldDateTime = Common.parseDateTime((String) fieldValue);
            DateTime sObjDateTime = (DateTime) sObjectFieldValue;
            return sObjDateTime < fieldDateTime;
        } else if (sObjectFieldValue instanceof Time) {
            Time sObjTime = (Time) sObjectFieldValue;
            return sObjTime < Common.parseTime((String) fieldValue);
        } else if (sObjectFieldValue instanceof Integer) {
            Integer fieldInt = Integer.valueOf((String) fieldValue);
            Integer sObjInt = (Integer) sObjectFieldValue;
            return sObjInt < fieldInt;
        } else if (sObjectFieldValue instanceof Long) {
            Long fieldLong = Long.valueOf((String) fieldValue);
            Long sObjLong = (Long) sObjectFieldValue;
            return sObjLong < fieldLong;
        } else if (sObjectFieldValue instanceof String) {
            String fieldString = ((String) fieldValue).toLowerCase();
            String sObjString = ((String) sObjectFieldValue).toLowerCase();
            return sObjString < fieldString;
        } else if (sObjectFieldValue instanceof Decimal) {
            Decimal fieldDec = Decimal.valueOf((String) fieldValue);
            Decimal sObjDec = (Decimal) sObjectFieldValue;
            return sObjDec < fieldDec;
        } else {
            throw new QueryException('Invalid field type');
        }
    }
}
