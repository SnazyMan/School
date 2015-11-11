# file: GNUMakefile
#

# define a target for the application
#
all: foo

# define a target to link the application
#
foo: foo.o foo_00.o
	#linking the two programs and calling the final function foo
	g++ foo.o foo_00.o -o foo

# define a target to compile the application
#
foo.o: foo.cc lamp_class.h
	#compile foo.cc into .o with optimization level 2
	g++ -O2 -c foo.cc -o foo.o
foo_00.o: foo_00.cc lamp_class.h
	#compile foo_00.cc into .o with optimization level 2	
	g++ -O2 -c foo_00.cc -o foo_00.o

# define a target to clean the directory
#
clean:
	#rm foo.o , foo_oo, foo
	rm -f foo.o foo_00.o
	rm -f foo
#
# end of file
