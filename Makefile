all: synth pnr bitstream burn

synth:
	yosys -p "read_verilog $(file).v; synth_gowin -json $(file).json"

pnr:
	nextpnr-himbaechel --json $(file).json --write pnr$(file).json --device "GW2AR-LV18QN88C8/I7" --vopt family=GW2A-18C --vopt cst=$(file).cst 

bitstream:
	gowin_pack -d GW2A-18C -o $(file).fs pnr$(file).json

burn:
	openFPGALoader --cable-index 0 $(file).fs

clean:
	rm $(file).json $(file).fs $(file).vcd $(file)

sim:
	iverilog $(file).v $(file)_tb.v -o $(file)_tb
	vvp $(file)_tb