public with sharing class ParentLookupResolver {
    
    public ParentLookupChain splitParentLookupChain(String fieldLookupChain) {
        List<String> fieldParts = fieldLookupChain.split('\\.');
        String finalField = fieldParts[fieldParts.size()-1];
        fieldParts.remove(fieldParts.size()-1);
        return new ParentLookupChain(finalField, fieldParts);
    }

    public class ParentLookupChain {
        private String finalField;
        private List<String> fieldParts;

        public ParentLookupChain(String finalField, List<String> fieldParts) {
            this.finalField = finalField;
            this.fieldParts = fieldParts;
        }

        public String getFinalField() {
            return finalField;
        }

        public List<String> getFieldParts() {
            return fieldParts;
        }
    }
}