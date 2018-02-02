.onLoad <-
  function(libname, pkgname)
  {
    ## make DLL available for Windows; others use static library
    if ("windows" == .Platform$OS.type) {
      dll <- file.path(libname, pkgname, "libs", .Platform$r_arch,
                       "zlib1bioc.dll")
      dyn.load(dll)
    }
  }

pkgconfig <-
  function(opt=c("PKG_CFLAGS", "PKG_LIBS_static",
                 "PKG_LIBS_shared"))
  {
    opt <- match.arg(opt)
    pth <- system.file("libs", package="libblosc", mustWork=TRUE)
    if (nzchar(.Platform$r_arch)) {
      arch <- sprintf("/%s", .Platform$r_arch)
    } else {
      arch <- ""
    }
    uname <-
      if ("windows" == .Platform$OS.type) "windows"
    else if ("Darwin" == system("uname -s", intern=TRUE)) "darwin"
    else "other"

    PKG_CFLAGS <-
      switch(uname, darwin="",
             sprintf('-I"%s"',
                     system.file("include", package="libblosc")))

    PKG_LIBS_static <-
      switch(uname,
             darwin="-lz",
             sprintf('"%s%s/libblosc.a"', pth, arch))

    # PKG_LIBS_shared <-
    #   switch(uname,
    #          windows=sprintf('-L"%s%s" -lblosc', pth, arch),
    #          darwin="-lz",
    #          sprintf('-L"%s%s" -Wl,-rpath,"%s%s" -lblosc', pth,
    #                  arch, pth, arch))
    PKG_LIBS_shared <-
      switch(uname,
             darwin="-lz",
             sprintf('"%s%s/libblosc.so"', pth, arch))

    cat(list(PKG_CFLAGS=PKG_CFLAGS, PKG_LIBS_static=PKG_LIBS_static,
             PKG_LIBS_shared=PKG_LIBS_shared)[[opt]])
  }
