### wdS ###

# Clock
set_property PACKAGE_PIN W5 [get_ports {clk_n}]
	set_property IOSTANDARD LVCMOS33 [get_ports {clk_n}]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_n}]

# wd signals for Register File
set_property PACKAGE_PIN V17 [get_ports {wd[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[0]}]
set_property PACKAGE_PIN V16 [get_ports {wd[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[1]}]
set_property PACKAGE_PIN W16 [get_ports {wd[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[2]}]
set_property PACKAGE_PIN W17 [get_ports {wd[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[3]}]
set_property PACKAGE_PIN W15 [get_ports {wd[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[4]}]
set_property PACKAGE_PIN V15 [get_ports {wd[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[5]}]
set_property PACKAGE_PIN W14 [get_ports {wd[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[6]}]
set_property PACKAGE_PIN W13 [get_ports {wd[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {wd[7]}]

# Addr3ite signals for Register File
set_property PACKAGE_PIN T3 [get_ports {Addr3[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr3[0]}]
set_property PACKAGE_PIN T2 [get_ports {Addr3[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr3[1]}]
set_property PACKAGE_PIN R3 [get_ports {Addr3[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr3[2]}]

# Addr3ite enable
set_property PACKAGE_PIN T18 [get_ports {we}]
	set_property IOSTANDARD LVCMOS33 [get_ports {we}]

# Read signals for Register File
set_property PACKAGE_PIN U1 [get_ports {Addr1[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr1[0]}]
set_property PACKAGE_PIN T1 [get_ports {Addr1[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr1[1]}]
set_property PACKAGE_PIN R2 [get_ports {Addr1[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr1[2]}]

### OUTPUTS ###

# RD1
set_property PACKAGE_PIN U16 [get_ports {RD1[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[0]}]
set_property PACKAGE_PIN E19 [get_ports {RD1[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[1]}]
set_property PACKAGE_PIN U19 [get_ports {RD1[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[2]}]
set_property PACKAGE_PIN V19 [get_ports {RD1[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[3]}]
set_property PACKAGE_PIN W18 [get_ports {RD1[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[4]}]
set_property PACKAGE_PIN U15 [get_ports {RD1[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[5]}]
set_property PACKAGE_PIN U14 [get_ports {RD1[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[6]}]
set_property PACKAGE_PIN V14 [get_ports {RD1[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD1[7]}]


### UNUSED ###

# Addr2
set_property PACKAGE_PIN J1 [get_ports {Addr2[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr2[0]}]
set_property PACKAGE_PIN L1 [get_ports {Addr2[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr2[1]}]
set_property PACKAGE_PIN J2 [get_ports {Addr2[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Addr2[2]}]

# RD2
set_property PACKAGE_PIN G2 [get_ports {RD2[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[0]}]
set_property PACKAGE_PIN H1 [get_ports {RD2[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[1]}]
set_property PACKAGE_PIN K2 [get_ports {RD2[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[2]}]
set_property PACKAGE_PIN H2 [get_ports {RD2[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[3]}]
set_property PACKAGE_PIN G3 [get_ports {RD2[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[4]}]
set_property PACKAGE_PIN A14 [get_ports {RD2[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[5]}]
set_property PACKAGE_PIN A16 [get_ports {RD2[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[6]}]
set_property PACKAGE_PIN B15 [get_ports {RD2[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RD2[7]}]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
