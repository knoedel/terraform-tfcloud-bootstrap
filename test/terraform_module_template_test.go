package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// ---------------------------------------------------------------------------------------------------------------------
// BASIC TERRATEST
// ---------------------------------------------------------------------------------------------------------------------

func TestTerraformINSERT_NAME_OF_MODULE(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/simple/",
		NoColor:      true,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
