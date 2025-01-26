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
 * @description before we create an aggregate, wean a proto-aggregate,
 *              i.e. a Map<String, Object> that will be used to store the aggregate
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Utilities
 */
public with sharing class ProtoAggregate {
    public Map<String, Object> prototype = new Map<String, Object>();

    List<SObject> records = new List<SObject>();

    /**
     * @description Constructor
     * @param prototype
     */
    public ProtoAggregate(Map<String, Object> prototype) {
        this.prototype = prototype;
    }

    /**
     * @description Constructor
     */
    public ProtoAggregate() {
        this.prototype = new Map<String, Object>();
    }

    /**
     * @description put a key-value pair in the proto-aggregate
     * @param key
     * @param value
     */
    public void put(String key, Object value) {
        this.prototype.put(key, value);
    }

    /**
     * @description get a value from the proto-aggregate
     * @param key
     * @return  `Object`
     */
    public Object get(String key) {
        return this.prototype.get(key);
    }

    /**
     * @description remove a key-value pair from the proto-aggregate
     * @param key
     */
    public void remove(String key) {
        this.prototype.remove(key);
    }

    /**
     * @description clear the proto-aggregate
     */
    public void clear() {
        this.prototype.clear();
    }

    /**
     * @description get the size of the proto-aggregate
     * @return  `Integer`
     */
    public Integer size() {
        return this.prototype.size();
    }

    /**
     * @description check if the proto-aggregate is empty
     * @return  `Boolean`
     */
    public Boolean isEmpty() {
        return this.prototype.isEmpty();
    }

    /**
     * @description check if the proto-aggregate contains a key
     * @param key
     * @return  `Boolean`
     */
    public Boolean containsKey(String key) {
        return this.prototype.containsKey(key);
    }

    /**
     * @description check if the proto-aggregate contains a value
     * @return  `Set<String>`
     */
    public Set<String> keySet() {
        return this.prototype.keySet();
    }

    /**
     * @description get the values of the proto-aggregate
     * @return  `List<Object>`
     */
    public List<Object> values() {
        return this.prototype.values();
    }

    /**
     * @description Returns the proto-aggregate as a `Map<String, Object>`
     * @return  `Map<String, Object>`
     */
    public Map<String, Object> getPrototype() {
        return this.prototype;
    }

    /**
     * @description Gets the internal list of records that comprise of this proto-aggregate
     * @return `List<SObject>`
     */
    public List<SObject> getRecords() {
        return this.records;
    }

    /**
     * @description Adds a record to the internal list of records
     * @param record `SObject`
     */
    public void addRecord(SObject record) {
        this.records.add(record);
    }
}
