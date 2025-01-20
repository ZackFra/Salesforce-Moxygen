interface HardisDuplicateResponse extends SalesforceResponse {
    result: {
        duplicates: {
            [key: string]: string[]
        }
    }
}