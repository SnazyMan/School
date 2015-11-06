# file: GNUMakefile
#

# define a target for the application
#
all: foo

# define a target to link the application
#
foo: foo.o foo_00.o
	#link foo.o and foo_00.o into foo
	g++ foo.o foo_00.o -o foo

# define a target to compile the application
#
foo.o: foo.cc foo.h
	#compile foo.cc into foo.o with level 2 optimization
	g++ -O2 -c foo.cc -o foo.o
foo_00.o: foo_00.cc foo.h
	#compile foo_00.cc into foo_00.o with level 2 optimization
	g++ -O2 -c foo_00.cc -o foo_00.o

# define a target to clean the directory
#
clean:
	#remove foo.o, foo_00.o, foo
	rm -f foo.o foo_00.o
	rm -f foo

#
# end of file


