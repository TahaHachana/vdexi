module vdexi

import time

// Milliseconds to seconds divisor
const divisor = 1000

fn time_from_unix_milliseconds(millis i64) time.Time {
	return time.unix(millis / vdexi.divisor)
}

fn try_parse_unix_milliseconds(finished ?i64) ?time.Time {
	return if finished != none {
		time_from_unix_milliseconds(finished)
	} else {
		none
	}
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
		starts: time_from_unix_milliseconds(r.starts)
		finished: try_parse_unix_milliseconds(r.finished)
		robot_id: r.robot_id
		run_id: r.run_id
	}
}

fn (r RawGetEventsResponse) to_get_events_response() GetEventsResponse {
	return GetEventsResponse{
		id: r.id
		state: r.state
		starts: time_from_unix_milliseconds(r.starts)
		finished: try_parse_unix_milliseconds(r.finished)
		robot_id: r.robot_id
		run_id: r.run_id
		events: r.events.map(|e| e.to_event())
	}
}

fn (r RawEvent) to_event() Event {
	return Event{
		system: r.system
		user_id: r.user_id
		message: r.message
		created: time_from_unix_milliseconds(r.created)
	}
}

fn (d DexiFormat) str() string {
    match d {
        .json { return 'json' }
		.xml { return 'xml' }
		.csv { return 'csv' }
		.scsv { return 'scsv' }
		.csv_gz { return 'csv.gz' }
		.json_gz { return 'json.gz' }
    }
}
