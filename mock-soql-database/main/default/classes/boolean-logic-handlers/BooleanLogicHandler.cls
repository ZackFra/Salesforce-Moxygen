/**
 * @description A class to handle boolean logic, when it comes to HAVING and WHERE clauses, it's all the same except for the comparison
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public virtual with sharing class BooleanLogicHandler {

    /** 
     * @description Parameters for bind variables in the query
     */
    public Map<String, Object> params;

    /**
     * @description The object being compared (either SObject or Aggregate)
     */
    public Object obj;

    /**
     * @description The head conditional node
     */
    public Node head;

    /**
     * @description The database to use for queries
     */
    public MockDatabase db;

    /**
     * @description The select node to compare against
     */
    public Node selectNode;

    /**
     * @description Constructor
     * @param options The options for the handler
     */
    public BooleanLogicHandler(BooleanLogicOptions options) {
        this.obj = options.obj;
        this.params = options.params;
        this.head = options.head;
        this.db = options.db;
        this.selectNode = options.selectNode;
    }

    /**
     * @description Evaluate the conditional expression
     * @return Whether the conditional expression is met
     */
    public Boolean evaluate() {
        if(this.head == null) {
            return true;
        }
        return isConditionMet(head.left);
    }

    /**
     * @description Evaluate the conditional expression, intended to be overridden
     * @param node The node to evaluate
     * @return Whether the conditional expression is met
     */
    public virtual Boolean isCompareConditionMet(Node node) {
        return true;
        // override me
    }


    private Boolean isAndConditionMet(Node node) {
        Node leftNode = node.left;
        Node rightNode = node.right;

        return (
            isConditionMet(leftNode) &&
            isConditionMet(rightNode)
        );
    }

    private Boolean isOrConditionMet(Node node) {
        Node leftNode = node.left;
        Node rightNode = node.right;

        return (
            isConditionMet(leftNode) ||
            isConditionMet(rightNode)
        );
    }

    private Boolean isConditionalSubExprMet(Node node) {
        return isConditionMet(node.left);
    }

    private Boolean isConditionMet(Node node) {
        if(node.nodeType == 'operator') {
            return isCompareConditionMet(node);
        } else if(node.nodeType == 'and') {
            return isAndConditionMet(node);
        } else if(node.nodeType == 'or') {
            return isOrConditionMet(node);
        } else if(node.nodeType == 'conditional subexpression') {
            return isConditionalSubExprMet(node);
        } if(node.nodeType == 'not') {
            return !isConditionMet(node.left);
        }

        throw new QueryException('Invalid where condition');
    }
}