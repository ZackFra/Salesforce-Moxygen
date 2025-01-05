package models

type InstanceUpgradeResponse struct {
	Message         string `json:"message"`
	NextUpgradeDate string `json:"nextUpgradeDate"`
}
