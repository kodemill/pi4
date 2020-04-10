.PHONY = clean all

SCAD_SRCS := $(wildcard *.scad)
STLS := $(SCAD_SRCS:%.scad=%.stl)

all: ${STLS}
	@echo "Generating stls..."

%.stl: %.scad
	openscad -o $@ $<

clean:
	@echo "Cleaning up..."
	rm -rvf *.stl


