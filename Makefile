SYNTH = yosys
PNR = nextpnr-himbaechel
bitstream = gowin_pack
burn = openFPGALoader
family = GW2A-18C

# Use src=folder to specify the source folder.
PNR_DIR = pnr
BITFILE_DIR = bitfiles

subdirs= $(src)

SOURCES := $(shell find $(src) $(subdirs) -name '*.v')
CST_SRC := $(shell find $(src) $(subdirs) -name '*.cst')

.PHONY: all clean

all: synth pnr bitstream 

clean:
	rm -rf $(PNR_DIR) $(BITFILE_DIR)
	echo "Cleaned PNR and BIT files folder"

synth:
	mkdir -p $(PNR_DIR)
	$(SYNTH) -p "read_verilog $(SOURCES); synth_gowin -json $(PNR_DIR)/$(src).json"

pnr:
	nextpnr-himbaechel --json $(PNR_DIR)/$(src).json --write pnr$(PNR_DIR)/$(SRC).json --device "GW2AR-LV18QN888C8/17" --vopt family=$(family) --vopt cst=$(CST_SRC)

bitstream:
	mkdir $(BITFILES_DIR)
	gowin_pack -d $(family) -o $(BITFILE_DIR)/$(src).fs pnr$(PNR_DIR)/$(SRC).json
