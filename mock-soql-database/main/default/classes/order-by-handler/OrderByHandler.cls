/**
 * @description Abstract class for OrderByHandler 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public abstract class OrderByHandler {
    protected OrderByOptions options;
    /**
     * @description Constructor for OrderByHandler
     * @param options `OrderByOptions`
     */
    public OrderByHandler(OrderByOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the OrderBy 
     * @return  `Object`
     */
    public abstract Object handleOrderBy();
    protected abstract Object sortByOrderBy();
}