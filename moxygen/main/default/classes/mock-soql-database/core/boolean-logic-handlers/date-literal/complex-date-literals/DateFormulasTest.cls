@isTest
private class DateFormulasTest {
    @isTest
    static void ensureInvertWillInvertDays() {
        DateFormulas.Invert invert = new DateFormulas.Invert();
        Integer dayValue = 5;
        Integer invertedDayValue = invert.apply(dayValue);
        Assert.areEqual(-5, invertedDayValue, 'Invert should invert the day value');
    }

    @isTest
    static void ensureWeeksConvertsToWeeks() {
        DateFormulas.Weeks weeks = new DateFormulas.Weeks();
        Integer dayValue = 5;
        Integer weeksValue = weeks.apply(dayValue);
        Assert.areEqual(35, weeksValue, 'Weeks should convert the day value to weeks');
    }

    @isTest 
    static void ensureInvertWeeksConvertsToInvertedWeeks() {
        DateFormulas.InvertWeeks invertWeeks = new DateFormulas.InvertWeeks();
        Integer dayValue = 5;
        Integer invertedWeeksValue = invertWeeks.apply(dayValue);
        Assert.areEqual(-35, invertedWeeksValue, 'InvertWeeks should convert the day value to inverted weeks');
    }

    @isTest
    static void ensureMonthsAgoCalculatesCorrectly() {
        DateFormulas.MonthsAgo monthsAgo = new DateFormulas.MonthsAgo();
        Integer monthValue = 5;
        Integer days = monthsAgo.apply(monthValue);
        Date today = Gmt.today();
        Date fiveMonthsAgo = today.addMonths(-monthValue);
        Assert.areEqual(fiveMonthsAgo, today.addDays(days), 'MonthsAgo should calculate the days between the current date and the date value, subtracting months');
    }
}