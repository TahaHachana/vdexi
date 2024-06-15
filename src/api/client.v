module api

import crypto.md5
import json
import utils

const base_url = 'https://api.dexi.io'

pub struct DexiClient {
pub:
	base_url   string = api.base_url
	account_id string
	api_key    string
	access_key string
}

fn DexiClient.new(account_id string, api_key string) DexiClient {
	return DexiClient{
		account_id: account_id
		api_key: api_key
		access_key: md5.hexhash(account_id + api_key)
	}
}

pub fn (d DexiClient) get_execution(execution_id string) !Execution {
	url := d.base_url + '/executions/' + execution_id
	resp := utils.get_request(url, d.access_key, d.account_id)!
	rawe := json.decode(RawExecution, resp) or { panic('Failed to decode response: ${resp}') }
	e := rawe.from_raw_execution()
	return e
}
