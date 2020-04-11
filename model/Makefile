.PHONY = clean all

# OUT := 
SCAD_SRCS := $(wildcard *.scad)
OUT := $(SCAD_SRCS:%.scad=%.3mf)

all: ${OUT}
	@echo "Generating output files..."

%.3mf: %.scad
	openscad -o $@ $<

clean:
	@echo "Cleaning up..."
	rm -rvf *.3mf


