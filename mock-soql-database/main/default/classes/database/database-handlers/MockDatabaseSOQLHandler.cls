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

public inherited sharing class MockDatabaseSOQLHandler {
    MockRecordQueryHandler recordQueryHandler = new MockRecordQueryHandler();
    MockCountQueryHandler countQueryHandler = new MockCountQueryHandler();
    MockAggregateQueryHandler aggregateQueryHandler = new MockAggregateQueryHandler();

    public List<SObject> query(String query) {
        return recordQueryHandler.query(query);
    }

    public List<SObject> query(String query, System.AccessLevel accessLevel) {
        return recordQueryHandler.query(query, accessLevel);
    }

    public List<SObject> queryWithBinds(String query, Map<String, Object> binds, System.AccessLevel accessLevel) {
        return recordQueryHandler.queryWithBinds(query, binds, accessLevel);
    }

    public Integer countQuery(String query) {
        return countQueryHandler.countQuery(query);
    }

    public Integer countQuery(String query, System.AccessLevel accessLevel) {
        return countQueryHandler.countQuery(query, accessLevel);
    }

    public Integer countQueryWithBinds(String query, Map<String, Object> binds, System.AccessLevel accessLevel) {
        return countQueryHandler.countQueryWithBinds(query, binds, accessLevel);
    }

    public List<Aggregate> aggregateQuery(String query) {
        return aggregateQueryHandler.aggregateQuery(query);
    }

    public List<Aggregate> aggregateQuery(String query, System.AccessLevel accessLevel) {
        return aggregateQueryHandler.aggregateQuery(query, accessLevel);
    }

    public List<Aggregate> aggregateQueryWithBinds(String query, Map<String, Object> binds, System.AccessLevel accessLevel) {
        return aggregateQueryHandler.aggregateQueryWithBinds(query, binds, accessLevel);
    }

    /**
     * @description Internal, do not use this method
     * @param head `Node`
     * @param params `Map<String, Object>`
     * @return  `List<SObject>`
     */
    public List<SObject> doSelectQueryInternal(Node head, Map<String, Object> params) {
        return recordQueryHandler.doQuery(head, params);
    }
}