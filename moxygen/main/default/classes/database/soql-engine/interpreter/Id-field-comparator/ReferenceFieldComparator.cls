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
 * @description Comparator for two reference fields, checks if they reference the same object
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public class ReferenceFieldComparator implements Comparator<Schema.SObjectField> {
    /**
     * @description Compares two reference fields to see if they reference the same object
     * @param field1
     * @param field2
     * @return  `Integer`
     */
    public Integer compare(
        Schema.SObjectField field1,
        Schema.SObjectField field2
    ) {
        List<Schema.sObjectType> sObj1FieldRefs = SchemaService.getReferenceTo(
            field1
        );
        List<Schema.sObjectType> sObj2FieldRefs = SchemaService.getReferenceTo(
            field2
        );

        for (Schema.SObjectType ref1 : sObj1FieldRefs) {
            for (Schema.SObjectType ref2 : sObj2FieldRefs) {
                if (ref1 == ref2) {
                    return 0;
                }
            }
        }
        return -1;
    }
}
