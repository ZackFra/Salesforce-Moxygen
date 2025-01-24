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
 * @description FieldSelectHandler is a class that implements ISelectHandler. It is used to handle the selection of a field.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class FieldSelectHandler implements ISelectHandler {
    FieldSelector fSelector;

    /**
     * @description Constructor for FieldSelectHandler
     * @param fSelector
     */
    public FieldSelectHandler(FieldSelector fSelector) {
        this.fSelector = fSelector;
    }

    /**
     * @description Handles the selection of a field
     * @return  `SObject`
     */
    public SObject handleSelect() {
        SObject queriedRecord = fSelector.queriedRecord;
        SObject databaseRecord = fSelector.databaseRecord;
        Node fieldNode = fSelector.fieldNode;

        String fieldName = fieldNode.id;
        Object fieldValue = databaseRecord.get(fieldName);

        Schema.SObjectType sot = SchemaService.getSObjectType(databaseRecord);
        String sObjectName = SchemaService.getSObjectName(sot);
        if (fieldValue != null) {
            Map<String, Object> objMap = Common.mapFromRecord(queriedRecord);
            objMap.put(fieldName, fieldValue);

            queriedRecord = Common.recordFromMap(objMap, SObjectName);
        }
        return queriedRecord;
    }
}
