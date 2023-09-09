PROJ = adder_subtractor_32
VERSION = 2012
all:
	iverilog -g$(VERSION) -s top -o $(PROJ).out top.sv $(PROJ).sv $(PROJ)_tb.sv
	vvp $(PROJ).out

clean:
	rm -f $(PROJ).out