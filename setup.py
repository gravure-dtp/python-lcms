#!/usr/bin/env python3
#
# -*- coding: utf-8 -*-
#
#       Copyright (c) Gilles Coissac 2021 <info@gillescoissac.fr>
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.
#
import sys, os
from pathlib import Path
import subprocess as sp
from pkg_resources import parse_version
from setuptools import setup, Extension, find_packages
from setuptools_scm import get_version as scm_get_version


def get_root():
    return Path(__file__).parent.resolve().absolute()


def get_description():
    with open("README.md", "r") as f:
        long_description = f.read()
    return long_description


def get_version():
    return scm_get_version(
        root=".",
        version_scheme="guess-next-dev",
        local_scheme="no-local-version",
    )


def get_pkg_lib(lib):
    args = ["pkg-config", "--short-errors", "--libs-only-l", lib]
    try:
        cp = sp.run(args, shell=False, check=True, text=True, capture_output=True)
    except sp.CalledProcessError as e:
        print(f"pkg-config error: {e.stderr}")
        name = ""
    else:
        name = cp.stdout.replace("-l", "")
    print(f"pkg-config lib:{name}")
    return name


def get_pkg_includedir(lib):
    args = ["pkg-config", "--variable=includedir", lib]
    try:
        cp = sp.run(args, shell=False, check=True, text=True, capture_output=True)
    except sp.CalledProcessError as e:
        print(f"pkg-config error: {e.stderr}")
        name = ""
    else:
        name = cp.stdout
    print(f"pkg-config includedir:{name}")
    return name


def get_pkg_libdir(lib):
    args = ["pkg-config", "--variable=libdir", lib]
    try:
        cp = sp.run(args, shell=False, check=True, text=True, capture_output=True)
    except sp.CalledProcessError as e:
        print(f"pkg-config error: {e.stderr}")
        name = ""
    else:
        name = cp.stdout
    print(f"pkg-config libdir:{name}")
    return name


def create_c_files():
    Options.docstrings = True
    Options.annotate = False
    # Redirection of cython compilation errors in file
    save_stderr = sys.stderr
    sys.stderr = open(".errors_log", "w")
    try:
        cythonize(
            [
                "src/gravure/lcms2/tags.pyx",
                "src/gravure/lcms2/_errors.pyx",
                "src/gravure/lcms2/unicode.pyx",
                "src/gravure/lcms2/profile.pyx",
                "src/gravure/lcms2/cms.pyx",
            ],
            include_path=[get_pkg_includedir("lcms2"), "src/gravure/lcms2"],
            nthreads=mp.cpu_count(),
            compiler_directives={
                "language_level": 3,
                "binding": False,
                "boundscheck": True,
                "wraparound": True,
                "overflowcheck": True,
                "initializedcheck": True,
                "nonecheck": False,
                "embedsignature": True,
                "optimize.use_switch": False,
                "optimize.unpack_method_calls": True,
                "warn.undeclared": False,
                "warn.unreachable": True,
                "warn.maybe_uninitialized": True,
                "warn.unused": True,
                "warn.unused_arg": True,
                "warn.unused_result": True,
                "warn.multiple_declarators": True,
            },
        )
    except Cython.Compiler.Errors.CompileError as e:
        print(
            f"Errors when generating c source files '{e}', look at '.errors_log'"
            " files in your project directory for details."
        )
        raise (e)
    sys.stderr = save_stderr


# Cython requierement
try:
    import Cython
except:
    print("Cython is not detected")
else:
    min_cython = "0.29.21"
    if parse_version(Cython.__version__) >= parse_version(min_cython):
        from Cython.Build import cythonize
        from Cython.Compiler import Options
        import multiprocessing as mp

        print(f"Cython version {Cython.__version__} found")
        print("Cythonyzing source files ...")
        create_c_files()
    else:
        print(
            f"Need cython version {min_cython} to generate c files, found version {Cython.__version__}"
        )


def get_extensions():
    return [
        Extension(
            "tags",
            sources=["src/gravure/lcms2/tags.c"],
            # libraries=[get_pkg_lib("lcms2")],
            include_dirs=[get_pkg_includedir("lcms2")],
            library_dirs=[get_pkg_libdir("lcms2")],
            extra_objects=["/usr/lib/x86_64-linux-gnu/liblcms2.so"],
            extra_link_args=[f"-L{get_pkg_libdir('lcms2')}"],
        ),
        Extension(
            "_errors",
            sources=["src/gravure/lcms2/_errors.c"],
            # libraries=[get_pkg_lib("lcms2")],
            include_dirs=[get_pkg_includedir("lcms2")],
            library_dirs=[get_pkg_libdir("lcms2")],
            extra_objects=["/usr/lib/x86_64-linux-gnu/liblcms2.so"],
            extra_link_args=[f"-L{get_pkg_libdir('lcms2')}"],
        ),
        Extension(
            "unicode",
            sources=["src/gravure/lcms2/unicode.c"],
            # libraries=[get_pkg_lib("lcms2")],
            include_dirs=[get_pkg_includedir("lcms2")],
            library_dirs=[get_pkg_libdir("lcms2")],
            extra_objects=["/usr/lib/x86_64-linux-gnu/liblcms2.so"],
            extra_link_args=[f"-L{get_pkg_libdir('lcms2')}"],
        ),
        Extension(
            "profile",
            sources=["src/gravure/lcms2/profile.c"],
            # libraries=[get_pkg_lib("lcms2")],
            include_dirs=[get_pkg_includedir("lcms2")],
            library_dirs=[get_pkg_libdir("lcms2")],
            extra_objects=["/usr/lib/x86_64-linux-gnu/liblcms2.so"],
            extra_link_args=[f"-L{get_pkg_libdir('lcms2')}"],
        ),
        Extension(
            "cms",
            sources=["src/gravure/lcms2/cms.c"],
            # libraries=[get_pkg_lib("lcms2")],
            include_dirs=[get_pkg_includedir("lcms2")],
            library_dirs=[get_pkg_libdir("lcms2")],
            extra_objects=["/usr/lib/x86_64-linux-gnu/liblcms2.so"],
            extra_link_args=[f"-L{get_pkg_libdir('lcms2')}"],
        ),
    ]


# os.environ[
#     "LIBRARY_PATH"
# ] = f"{os.environ.get('LIBRARY_PATH', '')}:{get_pkg_libdir('lcms2')}"

setup(
    #
    name="gravure.lcms2",
    version=get_version(),
    #
    package_dir={"": "src"},
    packages=find_packages(
        where="src",
        include=["gravure.lcms2"],
    ),
    # until cython 3.0 implicit namespace
    # packages is not yet supported
    namespace_packages=["gravure"],
    ext_package="gravure.lcms2",
    ext_modules=get_extensions(),
    # for use of cimport *.pxd
    # package_data={"gravure/lcms2": ["*.pxd"]},
    zip_safe=False,
    #
    python_requires=">=3.7",
    tests_require="pytest",
    #
    description="a Python binding to the little cms 2 library",
    long_description=get_description(),
    license="GPLv3+",
    platforms=["any"],
    #
    author="Gilles Coissac",
    author_email="info@gillescoissac.fr",
    maintainer="Gilles Coissac",
    maintainer_email="info@gillescoissac.fr",
    url="https://github.com/gravure-dtp/python-lcms2",
    download_url="https://github.com/gravure-dtp/python-lcms2",
    #
    keywords="lcms color icc cms print",
    classifiers=[
        "Environment :: Console",
        "Operating System :: POSIX :: Linux",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: Microsoft :: Windows",
        "Programming Language :: C",
        "Programming Language :: Cython",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.6",
        "Topic :: Multimedia :: Graphics :: Graphics Conversion" "Topic :: Printing",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
)


# END
