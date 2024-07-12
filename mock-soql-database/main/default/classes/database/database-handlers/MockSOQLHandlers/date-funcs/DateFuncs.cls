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
  * @description Repository of aggregate date functions 
  * @author Zackary Frazier
  * @since 4/28/2024
  */
public inherited sharing class DateFuncs {

    public static Integer execute(String dateFunc, Object dateOrDateTimeValue) {
        switch on dateFunc {
            when 'calendar_month' {
                return calendarMonth(dateOrDateTimeValue);
            } when 'calendar_year' {
                return calendarYear(dateOrDateTimeValue);
            } when 'calendar_quarter' {
                return calendarQuarter(dateOrDateTimeValue);
            } when else {
                throw new QueryException('Invalid date function');
            }
        }
    }

    /**
     * @description CALENDAR_MONTH function
     * @param value `Date|DateTime`
     * @return  `Integer`
     * @exception QueryException
     */
    public static Integer calendarMonth(Object value) {
        Integer calendarMonth;
        if(value instanceof Date) {
            Date dateValue = (Date) value;
            calendarMonth = dateValue.month();
        } else if(value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarMonth = dateTimeValue.monthGmt();
        } else {
            throw new QueryException('Invalid value type for calendar month calculation');
        }
        return calendarMonth;
    }

    /**
     * @description CALENDAR_YEAR function
     * @param value `Date|DateTime`
     * @return  `Integer`
     * @exception QueryException
     */
    public static Integer calendarYear(Object value) {
        Integer calendarYear;
        if(value instanceof Date) {
            Date dateValue = (Date) value;
            calendarYear = dateValue.year();
        } else if(value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarYear = dateTimeValue.yearGmt();
        } else {
            throw new QueryException('Invalid value type for calendar year calculation');
        }
        return calendarYear;
    }

    /**
     * @description Calculates the calendar quarter of a given Date or DateTime
     * @param value `Date|DateTime`
     * @return  `Integer`
     * @exception QueryException
     */
    public static Integer calendarQuarter(Object value) {
        Integer calendarQuarter;
        if(value instanceof Date) {
            Date dateValue = (Date) value;
            calendarQuarter = 1 + (dateValue.month() / 3);
        } else if(value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarQuarter = 1 + (dateTimeValue.monthGmt() / 3);
        } else {
            throw new QueryException('Invalid value type for calendar quarter calculation');
        }
        return calendarQuarter;
    }
}