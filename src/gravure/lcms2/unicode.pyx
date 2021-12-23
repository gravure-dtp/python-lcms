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
from cpython.mem cimport PyMem_Malloc, PyMem_Free

from gravure.lcms2._errors import raise_error, UndefinedError, errors_count


cdef extern from *:
    ctypedef struct PyObject
    PyObject* PyUnicode_FromKindAndData(int kind, const void *buffer, Py_ssize_t size)

    enum:
        PyUnicode_1BYTE_KIND
        PyUnicode_2BYTE_KIND
        PyUnicode_4BYTE_KIND


if sizeof(wchar_t)==1:
    BYTE_KIND = PyUnicode_1BYTE_KIND
elif sizeof(wchar_t)==2:
    BYTE_KIND = PyUnicode_2BYTE_KIND
elif sizeof(wchar_t)==4:
    BYTE_KIND = PyUnicode_4BYTE_KIND


cdef object unicode_from_wchar(const wchar_t *buffer, Py_ssize_t size) with gil:
    return <object> PyUnicode_FromKindAndData(BYTE_KIND, buffer, size // BYTE_KIND)


cdef object get_profile_info(cmsHPROFILE handle, cmsInfoType info) with gil:
    cdef wchar_t *buffer
    cdef int buffer_size
    py_string = ""

    # 1st request the size of the cstring
    buffer_size = cmsGetProfileInfo(handle, info, b"en", b"US", NULL, 0)
    if buffer_size == 0:
        if errors_count():
            raise_error(UndefinedError("get_profile_info()"))
        return py_string

    buffer = <wchar_t*> PyMem_Malloc(buffer_size * sizeof(wchar_t))
    if not buffer:
        raise MemoryError("get_profile_info()")

    try:
        # 2nd request the cstring
        buffer_size = cmsGetProfileInfo(handle, info, b"en", b"US", buffer, buffer_size)
        if buffer_size == 0:
            if errors_count():
                raise_error(UndefinedError("get_profile_info()"))
        else:
            py_string = unicode_from_wchar(buffer, buffer_size)
    finally:
        # last free buffer
        PyMem_Free(buffer)
    return py_string
