PROJ = adder_subtractor_32
VERSION = 2012
iverilog:
	iverilog -g$(VERSION) -s top -o $(PROJ).out top.sv $(PROJ).sv $(PROJ)_tb.sv
	vvp $(PROJ).out

gtkwave:
	make iverilog
	gtkwave $(PROJ).vcd

clean:
	rm -f $(PROJ).out
	rm -f $(PROJ).vcd