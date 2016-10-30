.SILENT:

.PHONY: all clean res run

X64 = x64

all: data bin
bin: c_home run

SRC=src/intro.s src/c_home.s src/exodecrunch.s src/menu.s src/utils.s src/data.s src/music_table.s

data:
	-cp res/mainscreen-*.bin src/
	-cp res/alarm-map.bin src/
	-cp res/sprites.bin src/
	-exomizer mem -o src/mainscreen-map.bin.exo res/mainscreen-map.prg
	-exomizer mem -o src/mainscreen-charset.bin.exo res/mainscreen-charset.prg
	-exomizer mem -o src/intro-charset.bin.exo res/intro-charset.prg
	-exomizer mem -o src/intro-map.bin.exo res/intro-map.prg

c_home: ${SRC}
	echo "Compiling..."
	cl65 -d -g -Ln bin/$@.sym -o bin/$@.prg -u __EXEHDR__ -t c64 -C $@.cfg $^
	echo "Compressing executable..."
	exomizer sfx sys -x1 -Di_line_number=2016 -o bin/$@_exo.prg bin/$@.prg

run:
	echo "Running game"
	$(X64) -verbose -moncommands bin/c_home.sym bin/c_home.prg

clean:
	rm -f bin/*.sym src/*.o

