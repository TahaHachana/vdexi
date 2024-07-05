module vdexi

import os
import thomaspeissl.dotenv

const account_id_var = 'DEXI_ACCOUNT_ID'
const api_key_var = 'DEXI_API_KEY'
const access_key_var = 'DEXI_ACCESS_KEY'
const test_execution_var = 'TEST_EXECUTION_ID'
const delete_execution_var = 'DELETE_EXECUTION_ID'

struct TestClient {
	dexi_client DexiClient
	account_id  string
	api_key     string
	access_key  string
}

fn load_env_vars() (string, string, string) {
	dotenv.load()
	account_id := os.getenv(vdexi.account_id_var)
	api_key := os.getenv(vdexi.api_key_var)
	access_key := os.getenv(vdexi.access_key_var)
	return account_id, api_key, access_key
}

fn load_env_var(var_name string) string {
	dotenv.load()
	return os.getenv(var_name)
}

fn TestClient.new() TestClient {
	account_id, api_key, access_key := load_env_vars()
	client := DexiClient.new(account_id, api_key)
	return TestClient{
		dexi_client: client
		account_id: account_id
		api_key: api_key
		access_key: access_key
	}
}

const test_client = TestClient.new()

// fn test_get_execution() {
// 	execution_id := load_env_var(test_execution_var)
// 	execution := test_client.dexi_client.get_execution(execution_id)!
// 	assert execution.id == execution_id
// }

// fn test_delete_execution() {
// 	execution_id := load_env_var(delete_execution_var)
// 	exit_code := test_client.dexi_client.delete_execution(execution_id)!
// 	assert exit_code == 0
// }

// fn test_get_events() {
// 	execution_id := load_env_var(vdexi.test_execution_var)
// 	events := vdexi.test_client.dexi_client.get_events(execution_id)!
// 	assert events.id == execution_id
// }
