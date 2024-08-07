module vdexi

import time

struct RawExecution {
	id       string @[json: '_id']
	state    string
	starts   i64
	finished ?i64
	robot_id string @[json: 'robotId']
	run_id   string @[json: 'runId']
}

enum ExecutionState {
	queued
	pending
	running
	failed
	stopped
	ok
}

struct Execution {
pub:
	id       string         @[json: '_id']
	state    ExecutionState
	starts   time.Time
	finished ?time.Time
	robot_id string
	run_id   string
}

struct RawExecutionResult {
	rows       []RawExecution
	offset     int
	total_rows int
}

struct ExecutionResult {
	rows       []Execution
	offset     int
	total_rows int
}

struct ExecutionStats {
	created          i64
	created_by       string
	created_by_name  string
	last_modified    i64
	modified_by      string
	modified_by_name string
	robot_id         string
	robot_name       string
	run_id           string
	run_name         string
	state            string
	starts           ?i64
	finished         ?i64
	archived         bool
	page_visits      i64
	requests         i64
	time_used        i64
	traffic_used     i64
	results_current  i64
	results_failed   i64
	results_total    i64
	time_taken       i64
	eta              ?i64
	concurrency      i64
}

struct Run {
	id         string @[json: '_id']
	name       string
	robot_id   string
	robot_name string
}

struct GetRunsResponse {
	rows       []Run
	offset     int
	total_rows int
}

struct RawEvent {
pub:
	system  bool
	user_id string
	message string
	created i64
}

struct Event {
pub:
	system  bool
	user_id string
	message string
	created time.Time
}

struct RawGetEventsResponse {
pub:
	id       string     @[json: '_id']
	state    string
	starts   i64
	finished ?i64
	robot_id string     @[json: 'robotId']
	run_id   string     @[json: 'runId']
	events   []RawEvent
}

struct GetEventsResponse {
pub:
	id       string     @[json: '_id']
	state    string
	starts   time.Time
	finished ?time.Time
	robot_id string     @[json: 'robotId']
	run_id   string     @[json: 'runId']
	events   []Event
}

pub enum DexiFormat {
	json
	xml
	csv
	scsv
	csv_gz
	json_gz
}

