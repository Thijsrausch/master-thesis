CREATE TABLE experiments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
	github TEXT NOT NULL, -- only source? TUM has on GitLab (multiple connectors?)
	author TEXT NOT NULL -- github account - can be multiple how to handle
);

CREATE TABLE experiment_run (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL,
    run_number INTEGER NOT NULL,
    start TIMESTAMP NOT NULL,
    stop TIMESTAMP,
    researcher TEXT NOT NULL, -- the researchers who triggered the run??
    FOREIGN KEY (experiment_id) REFERENCES experiments(id)
);

CREATE TABLE test_generator (
    id SERIAL PRIMARY KEY,
    experiment_run_id INTEGER NOT NULL,
    FOREIGN KEY (experiment_run_id) REFERENCES experiment_run(id)
);

CREATE TABLE test_generator_setup (
	id SERIAL PRIMARY KEY,
    test_generator_id INTEGER NOT NULL,
    setup_script TEXT,
    FOREIGN KEY (test_generator_id) REFERENCES test_generator(id)
);

CREATE TABLE test_generator_config (
	id SERIAL PRIMARY KEY,
    test_generator_id INTEGER NOT NULL,
	protocol TEXT NOT NULL,
    ingress INTEGER,
    egress INTEGER,
    warm_up INTEGER, -- little variables, what if there are more?
    FOREIGN KEY (test_generator_id) REFERENCES test_generator(id)
);

CREATE TABLE dut (
	id SERIAL PRIMARY KEY,
	experiment_run_id INTEGER NOT NULL,
	FOREIGN KEY (experiment_run_id) REFERENCES experiment_run(id)
);

CREATE TABLE dut_setup (
    id SERIAL PRIMARY KEY,
    dut_id INTEGER NOT NULL,
    setup_script TEXT,
    FOREIGN KEY (dut_id) REFERENCES dut(id)
); -- can also have variables in POS artifacts has none. How to accommodate?

CREATE TABLE dut_config (
    id SERIAL PRIMARY KEY,
    dut_id INTEGER NOT NULL,
    experiment_script TEXT, -- parse script?
    global_variables JSON, -- long last, variyng - how to handle?
    loop_variables JSON, -- same q
    FOREIGN KEY (dut_id) REFERENCES dut(id)
);

CREATE TABLE measurement (
    id SERIAL PRIMARY KEY,
    experiment_run_id INTEGER NOT NULL,
    dut_id INTEGER NOT NULL,
    measurement_script TEXT,
    FOREIGN KEY (experiment_run_id) REFERENCES experiment_run(id),
    FOREIGN KEY (dut_id) REFERENCES dut(id)
); -- measurement can also be in test_generator -- how to accommodate for that?
