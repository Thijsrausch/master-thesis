CREATE TABLE var (
    id SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE loop_var (
    id SERIAL PRIMARY KEY,
	dut_id INTEGER NOT NULL, -- normally foreign key for dut table
    var_id INTEGER NOT NULL,
    value JSON,
    FOREIGN KEY (var_id) REFERENCES var(id)
);

INSERT INTO var (name) VALUES ('ip_address');
INSERT INTO var (name) VALUES ('subnet_mask');
INSERT INTO var (name) VALUES ('gateway');
INSERT INTO var (name) VALUES ('dns_server');
INSERT INTO var (name) VALUES ('pkt_size');
INSERT INTO var (name) VALUES ('port_number');
INSERT INTO var (name) VALUES ('protocol');
INSERT INTO var (name) VALUES ('interface_status');
INSERT INTO var (name) VALUES ('pkt_rate');
INSERT INTO var (name) VALUES ('connection_speed');

-- experiment 1
-- Insert for 'ip_address' with a sample value
INSERT INTO loop_var (dut_id, var_id, value) VALUES (1, 1, '"192.168.1.1"');

-- Insert for 'pkt_size' with a range of values
INSERT INTO loop_var (dut_id, var_id, value) VALUES (1, 5, '[10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000, 180000, 190000, 200000, 210000, 220000, 230000, 240000, 250000, 260000, 270000, 280000, 290000, 300000]');

-- Insert for 'pkt_rate' with two values
INSERT INTO loop_var (dut_id, var_id, value) VALUES (1, 9, '[64, 1500]');

-- experiment 2 (other dut)
-- Insert random data for 'dns_server'
INSERT INTO loop_var (dut_id, var_id, value) VALUES (2, 4, '"8.8.8.8"');

-- Insert random data for 'gateway'
INSERT INTO loop_var (dut_id, var_id, value) VALUES (2, 3, '"192.168.1.254"');

-- Insert random data for 'connection_speed'
INSERT INTO loop_var (dut_id, var_id, value) VALUES (2, 10, '"1 Gbps"');

-- Insert random data for 'port_number'
INSERT INTO loop_var (dut_id, var_id, value) VALUES (2, 6, '8080');

-- Insert random data for 'protocol'
INSERT INTO loop_var (dut_id, var_id, value) VALUES (2, 7, '"TCP"');

SELECT var.name, loop_var.value
FROM loop_var
JOIN var ON loop_var.var_id = var.id
WHERE dut_id = 1;

SELECT var.name, loop_var.value
FROM loop_var
JOIN var ON loop_var.var_id = var.id
WHERE dut_id = 2;

