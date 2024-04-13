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
 * @description ORM class is responsible for creating and returning the Selector and DML objects
 *              ORM is short for Object Relationshal Mapping, i.e. Salesforce's database
 */
public inherited sharing class ORM {

    @TestVisible
    private static Boolean isUnitTest = Test.isRunningTest();

    /**
     * @description Returns if the current context is a unit test 
     * @return  `Boolean`
     */
    public static Boolean isUnitTest() {
        return isUnitTest;
    }

    /**
     * @description Sets the isUnitTest flag to false
     */
    @TestVisible
    private static void doIntegrationTest() {
        ORM.isUnitTest = false;
    }


    private class NoAccessException extends Exception {}

    /**
     * @description Validates that the current context is a unit test 
     * @exception NoAccessException
     */
    public static void validateUnitTestContext() {
        if(!ORM.isUnitTest) {
            throw new NoAccessException('This method is only available in a unit test context.');
        }
    }
}