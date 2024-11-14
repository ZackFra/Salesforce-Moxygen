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
 * @description Handles the limit for the aggregate query 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AggregateLimitHandler implements ILimitHandler {
    LimitOptions options;

    /**
     * @description Constructor for the AggregateLimitHandler
     * @param options `LimitOptions`
     */
    public AggregateLimitHandler(LimitOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the limit for the aggregate query
     * @return  `Object` - The object with the limit applied
     */
    public Object handleLimit() {
        Object obj = options.getObj();
        Integer limitSize = options.getLimitSize();

        List<ProtoAggregate> resultsList = new List<ProtoAggregate>((List<ProtoAggregate>) obj);
        while(resultsList.size() > limitSize) {
            resultsList.remove(resultsList.size()-1);
        }
        return resultsList;
    }
}