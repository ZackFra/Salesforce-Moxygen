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

// test comment

/**
 * @description Aggregate class to represent the result of an aggregate query
 * @author Zackary Frazier
 * @since 4/5/2024
 */
public inherited sharing class Aggregate {
    
    private Map<String, Object> data;
    
    /**
     * @description Standard constructor, creates an Aggregate object from an AggregateResult
     * @param ar the AggregateResult to create the Aggregate from
     */
    public Aggregate(AggregateResult ar) {
        data = ar.getPopulatedFieldsAsMap();
    }

    /**
     * @description Constructor for testing purposes, creates an Aggregate object from a Map
     * @param data the data to create the Aggregate from
     */
    public Aggregate(Map<String, Object> data) {
        this.data = data;
    }

    /**
     * @description Constructor for testing purposes, creates an Aggregate object from a ProtoAggregate 
     * @param ar 
     */
    public Aggregate(ProtoAggregate ar) {
        this.data = ar.getPrototype();
    }

    /**
     * @description get the value of a field
     * @param field the field to get
     * @return the value of the field
     */
    public Object get(String field) {
        return data.get(field);
    }

    /**
     * @description get the value of the aggregate as a String
     * @return the value of the field as a string
     */
    public override String toString() {
        return data.toString();
    }

    @TestVisible
    private Set<String> keySet() {
        return data.keySet();
    }
}