/**
 * @description : Class to hold the head of a parsed query and the remaining subquery
 */
public class Intermediary {
    public Node head;
    public String subquery;

    /**
     * @description : Constructor for an Intermediary
     * @param head : Node, the head of the parsed query
     * @param subquery : String, the remaining subquery
     */
    public Intermediary(Node head, String subquery) {
        this.head = head;
        this.subquery = subquery;
    }
}