module utils

import time

pub fn parse_unix_milliseconds(finished ?i64) ?time.Time {
	return if finished != none {
		time.unix(finished / 1000)
	} else {
		none
	}
}
