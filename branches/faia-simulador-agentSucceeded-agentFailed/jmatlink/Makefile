CC=cc
LD=ld

# MATLAB
MATLAB=/opt/matlab
MLIB=-L$(MATLAB)/bin/glnx86 -L$(MATLAB)/extern/lib/glnx86 -L$(MATLAB)/sys/os/glnx86/
MINCLUDE=-I$(MATLAB)/extern/include

# JAVA
JAVA=/usr/lib/jvm/java-6-sun
JINCLUDE=-I$(JAVA)/include -I$(JAVA)/include/linux

libJMatlink.so: JMatLink.o
	$(LD) -O -Wl,-flat_namespace -undefined suppress -G $(MLIB) -leng -lmx -o libJMatLink.so JMatLink.o
	\rm JMatLink.o

JMatLink.o: JMatLink.c JMatLink.h
	$(CC) -fPIC -shared $(JINCLUDE) $(MINCLUDE) -c JMatLink.c

clean:
	@rm -rf *.o *.so

