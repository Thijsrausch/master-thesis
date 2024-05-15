-- CREATE EXPERIMENT
INSERT INTO experiments(name, github, author)
VALUES('pos-artifacts', 'https://github.com/gallenmu/pos-artifacts', 'gallenmu')

-- CREATE EXPERIMENT RUN

INSERT INTO experiment_run(experiment_id, run_number, start, stop, researcher)
VALUES(1, 1, '2020-10-07 22:22:39', '2020-10-07 23:00:00', 'gallenmu'); -- stop time unknown

INSERT INTO test_generator(experiment_run_id)
VALUES(1);

INSERT INTO test_generator_config(test_generator_id, protocol, ingress, egress, warm_up)
VALUES(1, 'moongen', 0, 1, 0);

INSERT INTO test_generator_setup(test_generator_id, setup_script)
VALUES(1, 'https://github.com/gallenmu/pos-artifacts/blob/gh-pages/experiment/loadgen/setup.sh');

INSERT INTO dut(experiment_run_id)
VALUES(1);

INSERT INTO dut_config(dut_id, experiment_script, global_variables, loop_variables)
VALUES(1, 'https://github.com/gallenmu/pos-artifacts/blob/gh-pages/experiment/experiment.sh', '{
    "moongen_repo": "https://github.com/gallenmu/MoonGen",
    "moongen_repo_commit": "21641c9c3432fa8a5f93b135cf38b5247750d0a0",
    "moongen_dir": "/root/moongen",
    "loadgen": {
        "ingress_dev": 1,
        "egress_dev": 0,
        "ingress_if": "ens4",
        "egress_if": "ens5",
        "ingress_mac": "52:54:00:78:0a:23",
        "egress_mac": "52:54:00:78:0a:20",
        "ingress_ip": "10.0.0.20",
        "egress_ip": "10.0.1.23",
        "enable_ip_sw_chksum_calc": true,
        "enable_offload": false
    },
    "dut": {
        "ingress_if": "ens4",
        "egress_if": "ens5",
        "ingress_mac": "52:54:00:80:0a:22",
        "egress_mac": "52:54:00:80:0a:21",
        "ingress_ip": "10.0.1.22",
        "egress_ip": "10.0.0.21"
    }
}'::jsonb, '{
    "pkt_rate": [10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000, 180000, 190000, 200000, 210000, 220000, 230000, 240000, 250000, 260000, 270000, 280000, 290000, 300000],
    "pkt_sz": [64, 1500]
}'::jsonb); -- should this have experiment script?

INSERT INTO dut_setup(dut_id, setup_script)
VALUES(1, 'https://github.com/gallenmu/pos-artifacts/blob/gh-pages/experiment/dut/setup.sh');

INSERT INTO measurement(experiment_run_id, dut_id, measurement_script)
VALUES(1, 1, 'https://github.com/gallenmu/pos-artifacts/blob/gh-pages/experiment/dut/measurement.sh');
