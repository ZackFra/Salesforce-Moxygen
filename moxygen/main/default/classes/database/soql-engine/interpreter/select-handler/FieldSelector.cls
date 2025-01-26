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
 * @description FieldSelector is a class that is used to select fields from a queried record based on a field node.
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class FieldSelector {
    public SObject databaseRecord;
    public SObject queriedRecord;
    public Node fieldNode;
    public Map<String, Object> params;

    /**
     * @description Setter for the `databaseRecord` property
     * @param databaseRecord
     * @return  `FieldSelector`
     */
    public FieldSelector setDatabaseRecord(SObject databaseRecord) {
        this.databaseRecord = databaseRecord;
        return this;
    }

    /**
     * @description Setter for the `queriedRecord` property
     * @param queriedRecord
     * @return  `FieldSelector`
     */
    public FieldSelector setQueriedRecord(SObject queriedRecord) {
        this.queriedRecord = queriedRecord;
        return this;
    }

    /**
     * @description Setter for the `fieldNode` property
     * @param fieldNode
     * @return  `FieldSelector`
     */
    public FieldSelector setFieldNode(Node fieldNode) {
        this.fieldNode = fieldNode;
        return this;
    }

    /**
     * @description Setter for the `params` property
     * @param params
     * @return  `FieldSelector`
     */
    public FieldSelector setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }
}
