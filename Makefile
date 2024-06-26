include Make.inc

all:
	make assembly
	make lib
	make tests
	make examples

assembly:
	$(CC) -S $(AFLAGS) src/recurrence/recurrence_default.c -o src/recurrence/recurrence_default.s
	$(CC) -S $(AFLAGS) $(MSSE) src/recurrence/recurrence_SSE.c -o src/recurrence/recurrence_SSE.s
	$(CC) -S $(AFLAGS) $(MSSE2) src/recurrence/recurrence_SSE2.c -o src/recurrence/recurrence_SSE2.s
	$(CC) -S $(AFLAGS) $(MAVX) src/recurrence/recurrence_AVX.c -o src/recurrence/recurrence_AVX.s
	$(CC) -S $(AFLAGS) $(MAVX) $(MFMA) src/recurrence/recurrence_AVX_FMA.c -o src/recurrence/recurrence_AVX_FMA.s
	$(CC) -S $(AFLAGS) $(MAVX512F) src/recurrence/recurrence_AVX512F.c -o src/recurrence/recurrence_AVX512F.s
	$(CC) -S $(AFLAGS) src/recurrence/recurrence_NEON.c -o src/recurrence/recurrence_NEON.s

	$(CC) -S $(AFLAGS) src/permute/permute_default.c -o src/permute/permute_default.s
	$(CC) -S $(AFLAGS) $(MSSE) src/permute/permute_SSE.c -o src/permute/permute_SSE.s
	$(CC) -S $(AFLAGS) $(MSSE2) src/permute/permute_SSE2.c -o src/permute/permute_SSE2.s
	$(CC) -S $(AFLAGS) $(MAVX) src/permute/permute_AVX.c -o src/permute/permute_AVX.s
	$(CC) -S $(AFLAGS) $(MAVX512F) src/permute/permute_AVX512F.c -o src/permute/permute_AVX512F.s
	$(CC) -S $(AFLAGS) src/permute/permute_NEON.c -o src/permute/permute_NEON.s

	$(CC) -S $(AFLAGS) src/rotations/rotations_default.c -o src/rotations/rotations_default.s
	$(CC) -S $(AFLAGS) $(MSSE2) src/rotations/rotations_SSE2.c -o src/rotations/rotations_SSE2.s
	$(CC) -S $(AFLAGS) $(MAVX) src/rotations/rotations_AVX.c -o src/rotations/rotations_AVX.s
	$(CC) -S $(AFLAGS) $(MAVX) $(MFMA) src/rotations/rotations_AVX_FMA.c -o src/rotations/rotations_AVX_FMA.s
	$(CC) -S $(AFLAGS) $(MAVX512F) src/rotations/rotations_AVX512F.c -o src/rotations/rotations_AVX512F.s
	$(CC) -S $(AFLAGS) src/rotations/rotations_NEON.c -o src/rotations/rotations_NEON.s

lib:
	$(CC) $(CFLAGS) $(LIBFLAGS) $(ASM) $(SRC) $(LDFLAGS) $(LDLIBS) -o lib$(LIB).$(SLIB)

tests:
	$(CC) src/ftutilities.c test/test_fmm.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_fmm
	$(CC) src/ftutilities.c test/test_recurrence.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_recurrence
	$(CC) src/ftutilities.c test/test_transforms.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_transforms
	$(CC) src/ftutilities.c test/test_permute.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_permute
	$(CC) src/ftutilities.c test/test_rotations.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_rotations
	$(CC) src/ftutilities.c test/test_elliptic.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_elliptic
	$(CC) src/ftutilities.c test/test_tridiagonal.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_tridiagonal
	$(CC) src/ftutilities.c test/test_hierarchical.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_hierarchical
	$(CC) src/ftutilities.c test/test_banded.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_banded
	$(CC) src/ftutilities.c test/test_dprk.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_dprk
	$(CC) src/ftutilities.c test/test_tdc.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_tdc
	$(CC) src/ftutilities.c test/test_drivers.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_drivers
	$(CC) src/ftutilities.c test/test_fftw.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_fftw
	$(CC) src/ftutilities.c test/test_isometries.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_isometries
	$(CC) src/ftutilities.c test/test_helmholtzhodge.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o test_helmholtzhodge

examples:
	$(CC) src/ftutilities.c examples/additiontheorem.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o additiontheorem
	$(CC) src/ftutilities.c examples/annulus.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o annulus
	$(CC) src/ftutilities.c examples/calculus.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o calculus
	$(CC) src/ftutilities.c examples/holomorphic.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o holomorphic
	$(CC) src/ftutilities.c examples/nonlocaldiffusion.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o nonlocaldiffusion
	$(CC) src/ftutilities.c examples/spinweighted.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o spinweighted
	$(CC) src/ftutilities.c examples/subspaceangles.c $(CFLAGS) -L$(LIBDIR) -l$(LIB) $(LDFLAGS) $(LDLIBS) -o subspaceangles

runtests:
	./test_fmm
	./test_recurrence
	./test_transforms
	./test_permute
	./test_rotations
	./test_elliptic
	./test_tridiagonal
	./test_hierarchical
	./test_banded
	./test_dprk
	./test_tdc
	OMP_NUM_THREADS=$(FT_NUM_THREADS) ./test_drivers 1 3 0
	OMP_NUM_THREADS=$(FT_NUM_THREADS) ./test_fftw 1 3 0
	OMP_NUM_THREADS=$(FT_NUM_THREADS) ./test_isometries 1 3
	OMP_NUM_THREADS=$(FT_NUM_THREADS) ./test_helmholtzhodge 1 3

runexamples:
	./additiontheorem
	./annulus
	./calculus
	./holomorphic
	./nonlocaldiffusion
	./spinweighted
	./subspaceangles

coverage:
	$(COV) $(SRC) -o $(LIBDIR)

clean:
	rm -f lib$(LIB).*
	rm -f additiontheorem
	rm -f annulus
	rm -f calculus
	rm -f holomorphic
	rm -f nonlocaldiffusion
	rm -f spinweighted
	rm -f subspaceangles
	rm -f test_*
	find . -type f -name '*.s' -delete
	find . -type f -name '*.gcda' -delete
	find . -type f -name '*.gcno' -delete
	find . -type f -name '*.gcov' -delete

.PHONY: all assembly lib tests examples runtests runexamples coverage clean
