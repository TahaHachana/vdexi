module vdexi

import net.http

const access_header = 'X-DexiIO-Access'
const account_header = 'X-DexiIO-Account'

fn build_request(method http.Method, request_url string, access_key string, account_id string) http.Request {
	mut req := http.Request{
		method: method
		url: request_url
	}
	req.add_custom_header(access_header, access_key) or { panic(err) }
	req.add_custom_header(account_header, account_id) or { panic(err) }
	return req
}

fn build_get_request(request_url string, access_key string, account_id string) http.Request {
	return build_request(http.Method.get, request_url, access_key, account_id)
}

fn build_delete_request(request_url string, access_key string, account_id string) http.Request {
	return build_request(http.Method.delete, request_url, access_key, account_id)
}

pub fn get_request(request_url string, access_key string, account_id string) !string {
	req := build_get_request(request_url, access_key, account_id)

	response := req.do() or { return error('GET request to ${request_url} failed: ${err}') }

	status_code := response.status_code
	if status_code != 200 {
		return error('GET request to ${request_url} failed with status code ${status_code}')
	}

	return response.body
}

pub fn delete_request(request_url string, access_key string, account_id string) ! {
	req := build_delete_request(request_url, access_key, account_id)

	response := req.do() or { return error('DELETE request to ${request_url} failed: ${err}') }

	status_code := response.status_code
	if status_code != 200 {
		return error('DELETE request to ${request_url} failed with status code ${status_code}')
	}
}
