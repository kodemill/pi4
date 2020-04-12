.PHONY = clean all

# OUT := 
SCAD_SRCS := $(wildcard *.scad)
OUT := $(SCAD_SRCS:%.scad=%.stl)

all: ${OUT}
	@echo "Generating output files..."

%.stl: %.scad
	openscad -o $@ $<

clean:
	@echo "Cleaning up..."
	rm -rvf *.stl


