module vdexi

import crypto.md5
import json

const base_url = 'https://api.dexi.io'

pub struct DexiClient {
pub:
	base_url   string = vdexi.base_url
	account_id string
	api_key    string
	access_key string
}

pub fn DexiClient.new(account_id string, api_key string) DexiClient {
	return DexiClient{
		account_id: account_id
		api_key: api_key
		access_key: md5.hexhash(account_id + api_key)
	}
}

// Returns the id, state, start and finish time of an execution.
pub fn (d DexiClient) get_execution(execution_id string) !Execution {
	request_url := '${d.base_url}/executions/${execution_id}'
	resp := get_request(request_url, d.access_key, d.account_id) or { panic(err) }

	raw_execution := json.decode(RawExecution, resp) or {
		return error('Failed to parse the execution data: ${err}')
	}

	return raw_execution.to_execution()
}

// Deletes an execution permanently.
pub fn (d DexiClient) delete_execution(execution_id string) !int {
	request_url := '${d.base_url}/executions/${execution_id}'
	delete_request(request_url, d.access_key, d.account_id) or { panic(err) }
	return 0
}

// Get execution events information.
pub fn (d DexiClient) get_events(execution_id string) !GetEventsResponse {
	request_url := '${d.base_url}/executions/${execution_id}/events'
	resp := get_request(request_url, d.access_key, d.account_id) or { panic(err) }

	raw_events := json.decode(RawGetEventsResponse, resp) or {
		return error('Failed to parse the events data: ${err}')
	}
	return raw_events.to_get_events_response()
}

// https://app.dexi.io/#/api/sections/executions/getResult
