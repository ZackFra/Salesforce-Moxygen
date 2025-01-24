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

@isTest
private class ParserUtilsTest {
    @isTest
    private static void testSkipWhitespace() {
        String query = '   SELECT Id FROM Account';
        Test.startTest();
        query = ParserUtils.skipWhitespace(query);
        Test.stopTest();

        Assert.areEqual(
            'SELECT Id FROM Account',
            query,
            'skipWhitespace should remove leading whitespace'
        );
    }

    @IsTest
    private static void testValidCharForFieldOrObject() {
        String validChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_';
        Test.startTest();
        for (Integer i = 0; i < validChars.length(); i++) {
            String c = validChars.substring(i, i + 1);
            Assert.isTrue(
                ParserUtils.validCharForFieldOrObject(c),
                c + ' should be a valid character for a field or object'
            );
        }
        Test.stopTest();
    }

    @IsTest
    private static void testInvalidCharForFieldOrObject() {
        String invalidChars = '@#$%^&**()!-+=[]{}|;:,.<>?/\\~`"\'\t\n\r';
        Test.startTest();
        for (Integer i = 0; i < invalidChars.length(); i++) {
            String c = invalidChars.substring(i, i + 1);
            Assert.isFalse(
                ParserUtils.validCharForFieldOrObject(c),
                c + ' should be an invalid character for a field or object'
            );
        }
        Test.stopTest();
    }
}
