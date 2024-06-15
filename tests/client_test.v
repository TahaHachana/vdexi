import os
import thomaspeissl.dotenv
import src.api

fn load_env_vars() (string, string, string) {
    dotenv.load()
    account_id := os.getenv("DEXI_ACCOUNT_ID")
    api_key := os.getenv("DEXI_API_KEY")
    access_key := os.getenv("DEXI_ACCESS_KEY")
    return account_id, api_key, access_key
}

fn test_client_new() {
	dotenv.load()
	account_id, api_key, access_key := load_env_vars()
	client := api.DexiClient.new(account_id, api_key)
	assert client.account_id == account_id
	assert client.api_key == api_key
	assert client.access_key == access_key
	assert client.base_url == api.base_url
}

fn test_get_execution() {
	dotenv.load()
	execution_id := os.getenv("TEST_EXECUTION_ID")
	account_id, api_key, access_key := load_env_vars()
	client := api.DexiClient.new(account_id, api_key)
	execution := client.get_execution(execution_id)!
	assert execution.id == execution_id
}