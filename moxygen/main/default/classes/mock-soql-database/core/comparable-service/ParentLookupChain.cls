public class ParentLookupChain {
    private String finalField;
    private List<String> fieldParts;

    public ParentLookupChain(String lookupChain) {
        List<String> fieldParts = this.fieldLookupChain.split('\\.');
        String finalField = fieldParts[fieldParts.size()-1];
        fieldParts.remove(fieldParts.size()-1);
        this(finalField, fieldParts);
    }

    public ParentLookupChain(String finalField, List<String> fieldParts) {
        this.finalField = finalField;
        this.fieldParts = fieldParts;
    }

    public String getFinalField() {
        return finalField;
    }

    public List<String> getFieldParts() {
        return fieldParts.clone();
    }
}