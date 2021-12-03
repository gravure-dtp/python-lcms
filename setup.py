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
import os
import sys
import subprocess as sp
from pathlib import Path
import multiprocessing as mp

from setuptools import Extension, setup, find_namespace_packages


def get_pkg_lib(lib):
    args = ["pkg-config", "--short-errors", "--libs-only-l", lib]
    try:
        cp = sp.run(args + [lib], shell=False, check=True, text=True)
    except sp.CalledProcessError as e:
        print(f"pkg-config error: {e.stderr}")
        name = ""
    else:
        name = cp.stdout.replace("-l", "")
    return name


def get_root():
    return Path(__file__).parent.resolve().absolute()


def get_version():
    with open(get_root() / "VERSION", "r") as file:
        version = file.read().strip()
    return version


def get_description():
    return open("README.txt").read()


# Redirection of cython compilation errors in file
sys.stderr = open(".errors_log", "w")


# COMPILATION PATHS
SRC_DIR = "src"
INCLUDE_DIRS = ["/usr/include", "include", SRC_DIR]
DYN_LIBRARY_DIRS = ["/usr/lib", "/usr/lib/x86_64-linux-gnu"]
LIBRARIES = []
EXTRA_OBJECTS = ["/usr/lib/x86_64-linux-gnu/liblcms2.so"]
COMPILE_ARGS = []
X_LINK_ARGS = []
CYTHON_DIRECTIVES = {"language_level": 3, "embedsignature": False}


# CYTHON EXTENSIONS
extensions = [
    Extension(
        "cms",
        sources=[os.path.join(SRC_DIR, "cms.pyx")],
        include_dirs=INCLUDE_DIRS,
        libraries=LIBRARIES,
        runtime_library_dirs=DYN_LIBRARY_DIRS,
        extra_objects=EXTRA_OBJECTS,
        cython_directives=CYTHON_DIRECTIVES,
        extra_compile_args=["-Wall"],
    ),
]


# SETUP
setup(
    name="gravure.lcms2",
    version=get_version(),
    #
    package_dir={"": SRC_DIR},
    packages=find_namespace_packages(
        where=SRC_DIR, include=["gravure.lcms2"], exclude=[]
    ),
    ext_package="gravure.lcms2",
    ext_modules=extensions,
    package_data={"gravure/lcms2": ["*.pxd"]},
    zip_safe=False,  # for use off cimport *.pxd
    #
    python_requires=[">=3.6"],
    install_requires=[],  # ['sphinx>=1.1'] # Project uses reStructuredText and sphinx 1.1
    extra_require=[],
    # test_suite = '',
    # tests_require = 'nose'
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
    keywords="print rip printer driver gutenprint",
    classifiers=[
        "Environment :: X11 Applications :: Gnome",
        "Environment :: X11 Applications :: GTK",
        "Intended Audience :: End Users/Desktop",
        "Natural Language :: English",
        "Operating System :: POSIX :: Linux",
        "Programming Language :: C",
        "Programming Language :: Cython",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.6",
        "Topic :: Artistic Software",
        "Topic :: Desktop Environment :: Gnome",
        "Topic :: Printing",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
)

# END
