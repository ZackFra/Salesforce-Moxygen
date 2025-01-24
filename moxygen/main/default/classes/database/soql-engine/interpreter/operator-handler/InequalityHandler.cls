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
 * @description Handles the inequality operator
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class InequalityHandler implements IOperatorHandler {
    /**
     * @description Handles the inequality operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        Boolean isSObjNull = (sObjectFieldValue == null);
        Boolean isFieldNull = (fieldValue == null);

        // if their both null, return false, they're equal
        // if they're not both null, return true, they're not equal
        if (isSObjNull && isFieldNull) {
            return false;
        } else if (isSObjNull || isFieldNull) {
            return true;
        }

        if (fieldValue instanceof DateLiteral) {
            DateLiteralComparable dateLiteral = (DateLiteralComparable) DateLiteralComparableFactory.create(
                (DateLiteral) fieldValue
            );
            return dateLiteral.isNotEqual((DateTime) sObjectFieldValue);
        }

        if (sObjectFieldValue instanceof Date) {
            fieldValue = (Object) Common.parseDate((String) fieldValue)
                .toString();
        } else if (SObjectFieldValue instanceof DateTime) {
            fieldValue = (Object) Common.parseDateTime((String) fieldValue)
                .toString();
        } else if (SObjectFieldValue instanceof Time) {
            fieldValue = (Object) Common.parseTime((String) fieldValue)
                .toString();
        }

        return (String.valueOf(sObjectFieldValue).toLowerCase() !=
        ((String) fieldValue).toLowerCase());
    }
}
