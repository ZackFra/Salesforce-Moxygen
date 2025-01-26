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
 * @description Handler for offsetting aggregate results
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class AggregateOffsetHandler implements IOffsetHandler {
    OffsetOptions options;

    /**
     * @description Constructor for AggregateOffsetHandler
     * @param options `OffsetOptions`
     */
    public AggregateOffsetHandler(OffsetOptions options) {
        this.options = options;
    }

    /**
     * @description Handles offsetting aggregate results
     * @return  `Object`
     */
    public Object handleOffset() {
        Integer offset = options.offset;
        Object obj = options.obj;

        List<ProtoAggregate> aggrResults = new List<ProtoAggregate>(
            (List<ProtoAggregate>) obj
        );
        while (offset > 0) {
            aggrResults.remove(0);
            offset--;
        }
        return aggrResults;
    }
}
