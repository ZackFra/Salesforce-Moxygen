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
@IsTest
private with sharing class CommonTest {
    @IsTest
    private static void testNullCheck() {
        String str = null;
        Map<String, Object> args = new Map<String, Object>{ 'str' => str };
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            Common.nullCheck(args);
        } catch (IllegalArgumentException ex) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'IllegalArgumentException should be thrown'
        );
    }

    @IsTest
    static void testPutReadOnlyField() {
        Account acc = new Account(Name = 'Test Account');

        Test.startTest();
        Account updatedAcct = (Account) Common.putReadOnlyField(
            acc,
            'IsDeleted',
            true
        );
        Test.stopTest();

        Assert.isTrue(updatedAcct.IsDeleted, 'IsDeleted should be true');
    }

    @IsTest
    static void testPutReadOnlyFields() {
        Account acc = new Account(Name = 'Test Account');

        Test.startTest();
        Account updatedAcct = (Account) Common.putReadOnlyFields(
            acc,
            new Map<String, Object>{
                'IsDeleted' => true,
                'LastModifiedDate' => Datetime.now()
            }
        );
        Test.stopTest();

        Assert.isTrue(updatedAcct.IsDeleted, 'IsDeleted should be true');
        Assert.isNotNull(
            updatedAcct.LastModifiedDate,
            'LastModifiedDate should not be null'
        );
    }

    @IsTest
    static void testMapFromRecord() {
        Account acc = new Account(Name = 'Test Account');

        Test.startTest();
        Map<String, Object> accMap = Common.mapFromRecord(acc);
        Test.stopTest();

        for (String key : acc.getPopulatedFieldsAsMap().keySet()) {
            Assert.areEqual(
                acc.get(key),
                accMap.get(key),
                key + 'should be the same'
            );
        }
    }

    @IsTest
    static void testRecordFromMap() {
        Map<String, Object> accMap = new Map<String, Object>{
            'Name' => 'Test Account'
        };

        Test.startTest();
        Account acc = (Account) Common.recordFromMap(accMap, 'Account');
        Test.stopTest();

        for (String key : accMap.keySet()) {
            Assert.areEqual(
                acc.get(key),
                accMap.get(key),
                key + ' should be the same'
            );
        }
    }

    // A user with the th_TH locale reads year() and yearGmt() in the Buddhist
    // calendar, 543 years after the stored year, and Date.newInstance and
    // DateTime.newInstanceGmt read their year argument as a Buddhist year.
    // The SOQL and Apex strings must hold the stored year in both directions.
    private static User thaiUser() {
        User u = new User(
            FirstName = 'Thai',
            LastName = 'Locale',
            Alias = 'thloc',
            Email = 'thai.locale@example.com',
            Username = 'thai.locale' +
                DateTime.now().getTime() +
                '@example.com',
            TimeZoneSidKey = 'GMT',
            LocaleSidKey = 'th_TH',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = UserInfo.getProfileId()
        );
        insert u;
        return u;
    }

    @IsTest
    static void testDateToSoqlStringWritesStoredYearForThaiLocale() {
        String actual;
        Test.startTest();
        System.runAs(thaiUser()) {
            actual = Common.dateToSoqlString(Date.valueOf('2026-11-11'));
        }
        Test.stopTest();
        Assert.areEqual('2026-11-11', actual, 'Incorrect SOQL date string');
    }

    @IsTest
    static void testDateTimeToSoqlStringWritesStoredYearForThaiLocale() {
        String actual;
        Test.startTest();
        System.runAs(thaiUser()) {
            actual = Common.dateTimeToSoqlString(
                DateTime.valueOfGmt('2026-11-11 15:04:14')
            );
        }
        Test.stopTest();
        Assert.areEqual(
            '2026-11-11T15:04:14Z',
            actual,
            'Incorrect SOQL date time string'
        );
    }

    @IsTest
    static void testDateTimeToApexStringWritesStoredYearForThaiLocale() {
        String actual;
        Test.startTest();
        System.runAs(thaiUser()) {
            actual = Common.dateTimeToApexString(
                DateTime.valueOfGmt('2026-11-11 15:04:14')
            );
        }
        Test.stopTest();
        Assert.areEqual(
            '2026-11-11 15:04:14',
            actual,
            'Incorrect Apex date time string'
        );
    }

    @IsTest
    static void testParseDateKeepsWrittenYearForThaiLocale() {
        Date actual;
        Test.startTest();
        System.runAs(thaiUser()) {
            actual = Common.parseDate('2026-11-11');
        }
        Test.stopTest();
        Assert.areEqual('2026-11-11', String.valueOf(actual), 'Incorrect date');
    }

    @IsTest
    static void testParseDateTimeKeepsWrittenYearForThaiLocale() {
        DateTime actual;
        Test.startTest();
        System.runAs(thaiUser()) {
            actual = Common.parseDateTime('2026-11-11T15:04:14Z');
        }
        Test.stopTest();
        Assert.areEqual(
            '2026-11-11 15:04:14',
            String.valueOfGmt(actual),
            'Incorrect date time'
        );
    }

    @IsTest
    static void testParseDateTimeWithOffsetsKeepsWrittenYearForThaiLocale() {
        DateTime ahead;
        DateTime behind;
        Test.startTest();
        System.runAs(thaiUser()) {
            ahead = Common.parseDateTime('2026-11-11T15:04:14+02:30');
            behind = Common.parseDateTime('2026-11-11T15:04:14-02:30');
        }
        Test.stopTest();
        Assert.areEqual(
            '2026-11-11 12:34:14',
            String.valueOfGmt(ahead),
            'Incorrect date time for a positive offset'
        );
        Assert.areEqual(
            '2026-11-11 17:34:14',
            String.valueOfGmt(behind),
            'Incorrect date time for a negative offset'
        );
    }
}
