module utils

import net.http

pub fn get_request(url string, access_key string, account_id string) !string {
	mut req := http.Request{
		method: http.Method.get
		url: url
	}
	req.add_custom_header('X-DexiIO-Access', access_key)!
	req.add_custom_header('X-DexiIO-Account', account_id)!
	response := req.do() or {
		panic('Failed to send GET request: ${err}')
		// return ''
	}

	return response.body
}
