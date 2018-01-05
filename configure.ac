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

  RHDF5_LIBS=`echo 'Rhdf5lib::pkgconfig("PKG_C_LIBS")'|\
    "${R_HOME}/bin/R" --vanilla --slave`
  RHDF5_INCLUDE_DIRS=`echo 'cat(sprintf("%s/Rhdf5lib/include/",subset(installed.packages(),rownames(installed.packages())=="Rhdf5lib",select="LibPath"))) '|\
    "${R_HOME}/bin/R" --vanilla --slave`

  cd src/hdf5-blosc && \
  mkdir build && cd build && \
  CC=${R_CC} CFLAGS=${R_CFLAGS} cmake -DCMAKE_INSTALL_PREFIX=${GWD}/src/blosc_f -DHDF5_INCLUDE_DIRS=${RHDF5_INCLUDE_DIRS} -DHDF5_LIBRARIES=${RHDF5_LIBS} -DBUILD_TESTS=OFF -DPLUGIN_INSTALL_PATH=${GWD}/src/blosc_f --build .. && \
  cd ../../..


fi
AC_MSG_NOTICE([${use_libblosc}])
LIBZBIOC=${use_libblosc}
AC_SUBST(LIBBLOSC)
AC_OUTPUT(src/Makevars)
