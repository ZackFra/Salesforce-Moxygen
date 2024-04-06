/**
 * @description before we create an aggregate, wean a proto-aggregate,
 *              i.e. a Map<String, Object> that will be used to store the aggregate
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class ProtoAggregate {
    public Map<String, Object> prototype = new Map<String, Object>();

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

}