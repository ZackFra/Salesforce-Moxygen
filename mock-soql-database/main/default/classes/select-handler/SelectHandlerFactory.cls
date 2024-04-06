/**
 * @description Factory class to create appropriate select handler based on the field node type 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class SelectHandlerFactory {
    private FieldSelector fSelector;

    /**
     * @description Constructor
     * @param fSelector 
     */
    public SelectHandlerFactory(FieldSelector fSelector) {
        this.fSelector = fSelector;
    }

    /**
     * @description Creates appropriate select handler based on the field node type 
     * @return  `ISelectHandler`
     */
    public ISelectHandler createHandler() {
        Node fieldNode = fSelector.fieldNode;

        Boolean isTypeOf = (fieldNode.nodeType == 'typeof');
        Boolean isChildSubQuery = (fieldNode.nodeType == 'subquery');
        Boolean isParentSubQuery = (fieldNode.id.contains('.'));
        
        if(isTypeOf) {
            return new PolymorphicSelectHandler(fSelector);
        } else if(isChildSubQuery) {
            return new ChildSubQuerySelectHandler(fSelector);
        } else if(isParentSubQuery) {
            return new ParentSubQuerySelectHandler(fSelector);
        } else {
            return new FieldSelectHandler(fSelector);
        }
    }
}