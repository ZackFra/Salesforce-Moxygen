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
 * @description This class is responsible for parsing a list of values.
 * @author Zackary Frazier
 * @since 4/12/2024
 * @group Soql Engine
 */
public with sharing class ValueListParser extends SubParser {
    /**
     * @description Parses a list of values.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);

        Intermediary value = new ValueParser().parse(query);
        query = value.subquery;
        query = skipWhitespace(query);

        if (isNext(query, Token.COMMA)) {
            query = consume(query, Token.COMMA);
            Intermediary restOfList = parse(query);
            value.head.left = restOfList.head;
            value.subquery = restOfList.subquery;
        }
        query = value.subquery;
        return new Intermediary(
            new NodeBuilder()
                .setId(NodeType.VALUE_LIST)
                .setNodeType(NodeType.VALUE_LIST)
                .setLeft(value.head)
                .build(),
            query
        );
    }
}
