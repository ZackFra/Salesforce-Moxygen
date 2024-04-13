public inherited sharing class QueryParser extends SubParser {
    public override Intermediary parse(String query) {

        Intermediary selectIntermediary = new SelectParser().parse(query);
        query = selectIntermediary.subquery;

        Intermediary fromIntermediary = new FromParser().parse(query);
        query = fromIntermediary.subquery;
        
        Intermediary nextLink = selectIntermediary;

        nextLink.head.right = fromIntermediary.head;
        nextLink = fromIntermediary;

        Intermediary scopeIntermediary = new ScopeParser().parse(query);
        if(scopeIntermediary != null) {
            query = scopeIntermediary.subquery;
            nextLink.head.right = scopeIntermediary.head;
            nextLink = scopeIntermediary;
        }
        
        Intermediary whereIntermediary = new WhereParser().parse(fromIntermediary.subquery);
        if(whereIntermediary != null) {
            query = whereIntermediary.subquery;
            nextLink.head.right = whereIntermediary.head;
            nextLink = whereIntermediary;
        }

        // throws exception if WITH [DATA CATEGORY] is added to the query
        new WithDataCategoryParser().parse(query);
        
        Intermediary groupByIntermediary = new GroupByParser().parse(query);
        if(groupByIntermediary != null) {
            query = groupByIntermediary.subquery;
            nextLink.head.right = groupByIntermediary.head;
            nextLink = groupByIntermediary;
            
            Intermediary havingIntermediary = new HavingParser().parse(query);
            if(havingIntermediary != null) {
                query = havingIntermediary.subquery;
                nextLink.head.right = havingIntermediary.head;
                nextLink = havingIntermediary;
            }
        }
        
        Intermediary orderByIntermediary = new OrderByParser().parse(query);
        if(orderByIntermediary != null) {
            query = orderByIntermediary.subquery;
            nextLink.head.right = orderByIntermediary.head;
            nextLink = orderByIntermediary;
        }
        
        Intermediary limitIntermediary = new LimitParser().parse(query);
        if(limitIntermediary != null) {
            query = limitIntermediary.subquery;
            nextLink.head.right = limitIntermediary.head;
            nextLink = limitIntermediary;
        }

        Intermediary offsetIntermediary = new OffsetParser().parse(query);
        if(offsetIntermediary != null) {
            query = offsetIntermediary.subquery;
            nextLink.head.right = offsetIntermediary.head;
            nextLink = offsetIntermediary;
        }

        Intermediary forViewOrReferenceIntermediary = new ForViewOrReferenceParser().parse(query);
        if(forViewOrReferenceIntermediary != null) {
            query = forViewOrReferenceIntermediary.subquery;
            nextLink.head.right = forViewOrReferenceIntermediary.head;
            nextLink = forViewOrReferenceIntermediary;
        }

        // will throw an exception if UPDATE TRACKING or UPDATE VIEWSTAT is added to the query
        new UpdateTrackingOrViewStatParser().parse(query);
        
        Intermediary forUpdateIntermediary = new ForUpdateParser().parse(query);
        if(forUpdateIntermediary != null) {
            query = forUpdateIntermediary.subquery;
            nextLink.head.right = forUpdateIntermediary.head;
            nextLink = forUpdateIntermediary;
        }
        
        // head node, so to speak
        selectIntermediary.subquery = nextLink.subquery;
		if(nextLink.subquery != '' && lookahead(nextLink.subquery, 1) != ')') {
            throw new ParsingException(nextLink.subquery, null);
        }
        // just making sure everything is lowercase
        applyCasing(selectIntermediary.head);
        
        return selectIntermediary;
    }
}