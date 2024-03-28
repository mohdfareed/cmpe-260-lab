## Switches
set_property PACKAGE_PIN V17 [get_ports {A[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {A[0]}]
set_property PACKAGE_PIN V16 [get_ports {A[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {A[1]}]
set_property PACKAGE_PIN W16 [get_ports {A[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {A[2]}]
set_property PACKAGE_PIN W17 [get_ports {A[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {A[3]}]
set_property PACKAGE_PIN W15 [get_ports {B[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {B[0]}]
set_property PACKAGE_PIN V15 [get_ports {B[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {B[1]}]
set_property PACKAGE_PIN W14 [get_ports {B[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {B[2]}]
set_property PACKAGE_PIN W13 [get_ports {B[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {B[3]}]

## OP
set_property PACKAGE_PIN W2 [get_ports {OP[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OP[0]}]
set_property PACKAGE_PIN U1 [get_ports {OP[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OP[1]}]
set_property PACKAGE_PIN T1 [get_ports {OP[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OP[2]}]
set_property PACKAGE_PIN R2 [get_ports {OP[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OP[3]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {Y[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Y[0]}]
set_property PACKAGE_PIN E19 [get_ports {Y[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Y[1]}]
set_property PACKAGE_PIN U19 [get_ports {Y[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Y[2]}]
set_property PACKAGE_PIN V19 [get_ports {Y[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Y[3]}]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
