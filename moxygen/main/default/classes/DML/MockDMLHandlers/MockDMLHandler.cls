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
 * @description MockDMLHandler is an abstract class that provides a base class for mocking DML operations.
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public abstract class MockDMLHandler {
    protected Map<String, Map<Id, SObject>> mockObjects;
    protected Set<Id> deletedRecords;
    protected SaveResultService srService = new SaveResultService();

    protected Boolean wasCalled = false;

    /**
     * @description Returns true if the method was called, otherwise false.
     * @return  `Boolean`
     */
    public Boolean wasCalled() {
        return this.wasCalled;
    }

    /**
     * @description Sets the mockObjects map to the provided map.
     * @param mockObjects 
     */
    public void setMockObjects(Map<String, Map<Id, SObject>> mockObjects) {
        this.mockObjects = mockObjects;
    }

    /**
     * @description Sets the deletedRecords set to the provided set.
     * @param deletedRecords The set of Ids to set the deletedRecords to.
     */
    public void setDeletedRecords(Set<Id> deletedRecords) {
        this.deletedRecords = deletedRecords;
    }
}