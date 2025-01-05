package models

type SalesforceResponse struct {
	Status   int
	Result   *InstanceUpgradeResponse
	Warnings []string
}
