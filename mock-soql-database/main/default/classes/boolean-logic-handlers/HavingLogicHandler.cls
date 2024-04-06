/**
 * @description This class is used to handle the having clause logic
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class HavingLogicHandler extends BooleanLogicHandler {

    /**
     * @description Constructor
     * @param options 
     */
    public HavingLogicHandler(BooleanLogicOptions options) {
        super(options);
    }

    /**
     * @description This method is used to check if the having condition is met
     * @param operatorNode The operator node
     * @return Boolean
     * @throws Exception
     * @see MockDatabaseUtils.OperatorHandlerFactory
     */
    public override Boolean isCompareConditionMet(Node operatorNode) {
        ProtoAggregate aggr = (ProtoAggregate) this.obj;

        Node aggrNode = operatorNode.left;
        Map<String, Object> aggrNodeValue = this.db.utils.getAggrNodeValue(aggrNode, this.selectNode);
        String alias = (String) aggrNodeValue.get('alias');

        Object value = aggr.get(alias);
        Node valueNode = operatorNode.right;
        Object expectedValue;

        if(valueNode.nodeType == 'bind variable') {
            expectedValue = String.valueOf(params.get(valueNode.id));
        } else {
            expectedValue = valueNode.id;
        }
        
        OperatorHandlerFactory handlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = handlerFactory.getHandler(operatorNode.id);
        return handler.handle(value, expectedValue);
    }
}