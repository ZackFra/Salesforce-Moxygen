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
 * @description Interface for the Selector class, which is used to query the database 
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public interface ISelector {
    /**
     * @description Queries the database and returns a list of SObjects
     * @param queryString `String` The query string to be executed
     * @return  `List<SObject>`
     */
    List<SObject> query(String queryString);

    /**
     * @description Queries the database and returns a list of SObjects
     * @param queryString `String` The query string to be executed
     * @param accessLevel Access level to be used for the query
     * @return  `List<SObject>`
     */
    List<SObject> query(String queryString, System.AccessLevel accessLevel);

    /**
     * @description Queries the database and returns a list of SObjects, with bind variables
     * @param queryString `String` The query string to be executed
     * @param bindMap The bind variables to be used in the query
     * @param accessLevel Access level to be used for the query
     * @return  `List<SObject>`
     */
    List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
    
    /**
     * @description Queries the database and returns a list of Aggregates
     * @param queryString `String` The query string to be executed
     * @return  `List<Aggregate>`
     */
    List<Aggregate> queryAggregate(String queryString);

    /**
     * @description Queries the database and returns a list of Aggregates
     * @param queryString `String` The query string to be executed
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `List<Aggregate>`
     */
    List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel);

    /**
     * @description Queries the database and returns a list of Aggregates, with bind variables
     * @param queryString `String` The query string to be executed
     * @param bindMap `Map<String, Object>` The bind variables to be used in the query
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `List<Aggregate>`
     */
    List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);

    /**
     * @description `countQuery` Queries the database and returns the number of records returned
     * @param queryString `String` The query string to be executed
     * @return  `Integer`
     */
    Integer countQuery(String queryString);

    /**
     * @description Queries the database and returns the number of records returned
     * @param queryString `String` The query string to be executed
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `Integer`
     */
    Integer countQuery(String queryString, System.AccessLevel accessLevel);

    /**
     * @description Queries the database and returns the number of records returned, with bind variables
     * @param queryString `String` The query string to be executed
     * @param bindMap `Map<String, Object>` The bind variables to be used in the query
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `Integer`
     */
    Integer countQueryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
}