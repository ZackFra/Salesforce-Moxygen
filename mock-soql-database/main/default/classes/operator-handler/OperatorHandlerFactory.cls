/**
 * @description Provides a factory for creating operator handlers. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class OperatorHandlerFactory {

    final static Map<String, IOperatorHandler> HANDLERS = new Map<String, IOperatorHandler>{
        '=' => new EqualityHandler(),
        '<>' => new InequalityHandler(),
        '!=' => new InequalityHandler(),
        'like' => new LikeHandler(),
        'in' => new InHandler(),
        'not in' => new NotInHandler(),
        '>' => new GreaterThanHandler(),
        '<' => new LessThanHandler(),
        '>=' => new GreaterThanOrEqualHandler(),
        '<=' => new LessThanOrEqualHandler(),
        'includes' => new IncludesHandler(),
        'excludes' => new ExcludesHandler()
    };
    /**
     * @description Creates an operator handler based on the operator provided.
     * @param operator `String`
     * @return  `IOperatorHandler`
     * @exception QueryException
     */
    public IOperatorHandler getHandler(String operator) {
        if (HANDLERS.containsKey(operator)) {
            return handlers.get(operator);
        }
        throw new QueryException('Invalid operator');
    }
}