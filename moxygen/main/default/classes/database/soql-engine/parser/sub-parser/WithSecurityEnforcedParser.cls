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
 * @description This class is responsible for parsing the WITH SECURITY_ENFORCED clause in a SOQL query.
 * @author Zackary Frazier
 * @since 4/28/2024
 * @group Soql Engine
 */
public with sharing class WithSecurityEnforcedParser extends SubParser {
    /**
     * @description Parses the WITH SECURITY_ENFORCED clause in a SOQL query
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhiteSpace(query);
        if (lookahead(query, 4) != 'with') {
            return null;
        }

        query = consume(query, 'with');
        query = skipWhiteSpace(query);
        if (!isNext(query, 'security_enforced')) {
            throw new ParsingException(
                'WITH must be followed by SECURITY_ENFORCED'
            );
        }
        query = consume(query, 'security_enforced');
        query = skipWhiteSpace(query);
        return new Intermediary(
            new NodeBuilder()
                .setNodeType('with security_enforced')
                .setId('with security_enforced')
                .build(),
            query
        );
    }
}
