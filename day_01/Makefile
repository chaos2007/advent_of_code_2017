# Unit tests are written in funit, use gems to install.
export FSFLAG = -I
export FC=gfortran
export CXX="g++"
export CC="gcc"


test:
	funit

all:
	gfortran main.f90 class_number_string.f90
	./a.out

clean:
	rm -rf a.out
	rm *.o *.mod
	funit --clean


