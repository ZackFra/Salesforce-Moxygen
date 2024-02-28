public with sharing class ORM implements IORM {
    ISelector s;
    IDML d;
    public ORM() {
        this.s = new Selector();
        this.d = new DML();
    }

    public ISelector getSelector() {
        return s;
    }

    public IDML getDML() {
        return d;
    }
}