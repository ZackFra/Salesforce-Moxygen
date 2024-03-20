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
 * @description Mock ORM, for testing purposes
 */
@SuppressWarnings('PMD.ExcessivePublicCount')
@IsTest
public inherited sharing class MockORM implements IORM {
    ISelector s;
    IDML d;
    /**
     * @description Mock ORM constructor
     */
    public MockORM() {
        s = new MockSelector();
        d = new MockDML();
    }

    /**
     * @description returns the selector
     * @return the selector
     */
    public ISelector getSelector() {
        return s;
    }

    /**
     * @description returns the DML
     * @return the DML
     */
    public IDML getDML() {
        return d;
    }

    /**
     * @description reset the DML and Selector
     */
    public void reset() {
        resetDML();
        resetSelector();
    }

    /**
     * @description reset the DML
     */
    public void resetDML() {
        ((MockDML) d).resetHandlers();
    }

    /**
     * @description reset the Selector
     */
    public void resetSelector() {
        ((MockSelector) s).resetCallState();
    }

    /**
     * @description returns if the record is deleted
     * @param recordId the record id
     * @return if the record is deleted
     */
    public Boolean isDeleted(Id recordId) {
        return ((MockDML) d).isDeleted(recordId);
    }

    /**
     * @description returns the record by id
     * @param recordId the record id
     * @return the record
     */
    public SObject selectRecordById(Id recordId) {
        return ((MockDML) d).selectRecordById(recordId);
    }

    /**
     * @description returns the deleted record by id
     * @param recordId the record id
     * @return the deleted record
     */
    public SObject selectDeletedRecordById(Id recordId) {
        return ((MockDML) d).selectDeletedRecordById(recordId);
    }

    /**
     * @description returns the number of records in the database
     * @return the number of records
     */
    public Integer size() {
        return ((MockDML) d).count();
    }

    /**
     * @description registers a query in the mock database
     * @param queryString the query string
     * @param records the records to return
     */
    public void registerQuery(String queryString, List<SObject> records) {
        ((MockSelector) s).registerQuery(queryString, records);
    }

    /**
     * @description registers a failed query in the mock database
     * @param queryString the query string
     */
    public void registerFailedQuery(String queryString) {
        ((MockSelector) s).registerFailedQuery(queryString);
    }

    /**
     * @description registers an aggregate query in the mock database
     * @param queryString the query string
     * @param records the records to return
     */
    public void registerAggregateQuery(String queryString, List<Aggregate> records) {
        ((MockSelector) s).registerAggregateQuery(queryString, records);
    }

    /**
     * @description registers a failed aggregate query in the mock database
     * @param queryString the query string
     */
    public void registerFailedAggregateQuery(String queryString) {
        ((MockSelector) s).registerFailedAggregateQuery(queryString);
    }

    /**
     * @description registers a count query in the mock database
     * @param queryString the query string
     * @param count the count to return
     */
    public void registerCountQuery(String queryString, Integer count) {
        ((MockSelector) s).registerCountQuery(queryString, count);
    }

    /**
     * @description registers a failed count query in the mock database
     * @param queryString the query string
     */
    public void registerFailedCountQuery(String queryString) {
        ((MockSelector) s).registerFailedCountQuery(queryString);
    }

    /**
     * @description returns the number of deleted records in the database
     * @return the number of deleted records
     */
    public Integer deletedSize() {
        return ((MockDML) d).deletedCount();
    }

    /**
     * @description Returns whether a specific DML operation was performed
     * @param type the DML type
     * @return if the DML operation was performed
     */
    public Boolean didDML(Types.DML type) {
        return ((MockDML) d).wasCalled(type);
    }

    /**
     * @description Returns whether any DML operation was performed
     * @return if any DML operation was performed
     */
    public Boolean didAnyDML() {
        return ((MockDML) d).wasCalled();
    }

    /**
     * @description Returns whether a specific query was performed
     * @param queryString the query string
     * @return if the query was performed
     */
    public Boolean calledQuery(String queryString) {
        return ((MockSelector) s).wasCalled(queryString);
    }

    /**
     * @description Returns whether any query was performed
     * @return if any query was performed
     */
    public Boolean calledAnyQuery() {
        return ((MockSelector) s).wasCalled();
    }
}