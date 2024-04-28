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
 * @description This class is responsible for parsing a SOQL query
 * @author Zackary Frazier
 * @since 4/12/2024
 */
@SuppressWarnings('PMD.CognitiveComplexity, PMD.StdCyclomaticComplexity')
public inherited sharing class QueryParser extends SubParser {

    /**
     * @description Parses a SOQL query
     * @param query 
     * @return  `Intermediary`
     * @exception ParsingException
     */
    @SuppressWarnings('PMD.StdCyclomaticComplexity, PMD.NcssMethodCount, PMD.CyclomaticComplexity')
    public override Intermediary parse(String query) {
        // NOTE: The order of the parsers is important, makes this hard to refactor further

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
        
        // WITH SECURITY_ENFORCED is only allowed at the top level of a query
        Intermediary withSecurityEnforcedIntermediary = new WithSecurityEnforcedParser().parse(query);
        Boolean isTopLevelQuery = ((lookahead(withSecurityEnforcedIntermediary.subquery, 1).trim()) != '');
        Boolean isSecurityEnforced = (withSecurityEnforcedIntermediary != null);
        if(isSecurityEnforced && !isTopLevelQuery) {
            throw new ParsingException(withSecurityEnforcedIntermediary.subquery, null);
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