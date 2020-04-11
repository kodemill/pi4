.PHONY = clean all

# OUT := 
SCAD_SRCS := $(wildcard *.scad)
OUT := $(SCAD_SRCS:%.scad=%.amf)

all: ${OUT}
	@echo "Generating output files..."

%.amf: %.scad
	openscad -o $@ $<

clean:
	@echo "Cleaning up..."
	rm -rvf *.amf


