/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

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