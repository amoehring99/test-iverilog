# configuration
SHELL = /bin/bash
FPGA_PKG = sg48
FPGA_TYPE = up5k
FPGA_FREQ = 12
PCF = icebreaker.pcf

# included modules
ADD_SRC = adder_subtractor_32.sv
ADD_TB = adder_subtractor_32_tb.sv

top: top.rpt top.bin
top_tb: top_tb.rpt top_tb.bin

%.json: %.sv $(ADD_SRC)
	yosys -ql $(basename $@)-yosys.log -p 'synth_ice40 -top $(basename $@) -json $@' $< $(ADD_SRC)

%.asc: %.json ${PCF}
	nextpnr-ice40 -ql  $(basename $@).nplog --${FPGA_TYPE} --package ${FPGA_PKG} --freq $(FPGA_FREQ) --asc $@ --pcf ${PCF} --json $<

%.rpt: %.asc
	icetime -d ${FPGA_TYPE} -c $(FPGA_FREQ) -mtr $@ $<

%.bin: %.asc
	icepack $< $(subst top_,,$@)

%_tb: %.sv $(subst _tb,,$@).sv
	iverilog -o $@ $^

%.vcd: %_tb
	vvp -N $< +vcd=$@

%_syn.v: $.json
	yosys -p 'read_json $^; write_verilog $@'

%_syntb: %_tb.sv %_syn.sv
	iverilog -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

%_syntb.vcd: %_syntb
	vvp -N $< +vcd=$@

prog: $(PROJ).bin
	iceprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

all: top_foo top_bar

clean:
	rm -f $(PROJ).yslog $(PROJ).nplog $(PROJ).json $(PROJ).asc $(PROJ).rpt $(PROJ).bin
	rm -f $(PROJ)_tb $(PROJ)_tb.vcd $(PROJ)_syn.v $(PROJ)_syntb $(PROJ)_syntb.vcd

.SECONDARY:
.PHONY: all prog clean