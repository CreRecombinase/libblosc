AC_INIT("DESCRIPTION")

AC_ARG_WITH([libblosc],
	[AS_HELP_STRING([--with-libblosc],
		[build and use libblosc @<:@no@:>@])],
	[use_libzbioc=$withval], [use_libblosc=yes])

if test "${use_libblosc}" = yes; then
  : ${R_HOME=`R RHOME`}
  if test -z "${R_HOME}"; then
    echo "could not determine R_HOME"
    exit 1
  fi
  R_CC=`"${R_HOME}/bin/R" CMD config CC`
  R_CFLAGS=`"${R_HOME}/bin/R" CMD config CPICFLAGS`
  GWD=`pwd`

  cd src/c-blosc-1.12.1 && \
  mkdir build && cd build && \
  CC=${R_CC} CFLAGS=${R_CFLAGS} cmake -DCMAKE_INSTALL_PREFIX=${GWD}/src/blosc  -DBUILD_TESTS=OFF -DBUILD_BENCHMARKS=OFF --build .. && \
  cd ../../..


fi
AC_MSG_NOTICE([${use_libblosc}])
LIBZBIOC=${use_libblosc}
AC_SUBST(LIBBLOSC)
AC_OUTPUT(src/Makevars)
