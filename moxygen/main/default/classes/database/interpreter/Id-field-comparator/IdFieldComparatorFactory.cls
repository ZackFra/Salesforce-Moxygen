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
 * @description Returns a comparator for the given field types, compares ID fields (i.e. ID, Reference)
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class IdFieldComparatorFactory {
    /**
     * @description Creates a comparator for the given field types
     * @param field1
     * @param field2
     * @return  `Comparator<Schema.SObjectField>`
     * @exception IllegalArgumentException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public static Comparator<Schema.SObjectField> create(
        Schema.SObjectField field1,
        Schema.SObjectField field2
    ) {
        Schema.DisplayType field1Type = SchemaService.getFieldType(field1);
        Schema.DisplayType field2Type = SchemaService.getFieldType(field1);
        if (
            field1Type == Schema.DisplayType.ID &&
            field2Type == Schema.DisplayType.ID
        ) {
            return new IdFieldComparator();
        }
        if (
            field1Type == Schema.DisplayType.ID &&
            field2Type == Schema.DisplayType.REFERENCE
        ) {
            return new IdAndReferenceFieldComparator();
        }
        if (
            field1Type == Schema.DisplayType.REFERENCE &&
            field2Type == Schema.DisplayType.ID
        ) {
            return new IdAndReferenceFieldComparator();
        }
        if (
            field1Type == Schema.DisplayType.REFERENCE &&
            field2Type == Schema.DisplayType.REFERENCE
        ) {
            return new ReferenceFieldComparator();
        }
        throw new IllegalArgumentException('Invalid field types');
    }
}
