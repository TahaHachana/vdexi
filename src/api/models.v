module api

import time
import utils

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

pub fn (r RawExecution) to_execution() Execution {
	state := match r.state {
		'QUEUED' { ExecutionState.queued }
		'PENDING' { ExecutionState.pending }
		'RUNNING' { ExecutionState.running }
		'FAILED' { ExecutionState.failed }
		'STOPPED' { ExecutionState.stopped }
		else { ExecutionState.ok }
	}

	return Execution{
		id: r.id
		state: state
		starts: time.unix(r.starts / 1000)
		finished: utils.try_parse_unix_milliseconds(r.finished)
		robot_id: r.robot_id
		run_id: r.run_id
	}
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
