.PHONY = clean all

SRC := $(wildcard *.scad)
OUT := $(SRC:%.scad=%.stl)

all: ${OUT}
	@echo "Generating output files..."

%.stl: %.scad
	openscad -o $@ $<

clean:
	@echo "Cleaning up..."
	rm -rvf *.stl


