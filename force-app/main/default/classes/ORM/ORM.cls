/**
 * @description ORM class is responsible for creating and returning the Selector and DML objects
 *              ORM is short for Object Relationshal Mapping, i.e. Salesforce's database
 */
public inherited sharing class ORM implements IORM {
    ISelector s;
    IDML d;
    /**
     * @description Constructor for ORM class
     */
    public ORM() {
        this.s = new Selector();
        this.d = new DML();
    }

    /**
     * @description Returns the Selector object
     */
    public ISelector getSelector() {
        return s;
    }

    /**
     * @description Returns the DML object
     */
    public IDML getDML() {
        return d;
    }
}