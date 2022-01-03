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
from enum import Enum
from pathlib import Path
from contextlib import contextmanager

from gravure.lcms2._errors import raise_error, UndefinedError, errors_count
from gravure.lcms2.unicode cimport get_profile_info, cmsInfoType
from gravure.lcms2.tags import Tag


class DeviceAttribute(Enum):
    Reflective = cmsReflective
    Transparency = cmsTransparency
    Glossy = cmsGlossy
    Matte = cmsMatte


cdef class ctx():
    cdef object path
    cdef object mode
    cdef Profile pro

    def __init__(self, file, mode):
        if isinstance(file, Path):
            self.path = str(file)
        else:
            raise (ValueError("file should be a pathlib.Path object."))
        self.mode = mode

    def __enter__(self):
        cdef const char* c_name
        cdef const char* c_access
        b_file = self.path.encode('UTF-8')
        c_name = b_file
        b_mode =  self.mode.encode('UTF-8')
        c_access = b_mode
        self.pro = Profile.profile_from_file(c_name, c_access)
        if not self.pro:
            raise_error(IOError("Unknown error in opening profile"))
        return self.pro

    def __exit__(self, exc_type, exc_val, exc_tb):
        # exit - cleanup is done by __dealloc__
        return False


cdef class Profile():
    """ICC Profile Class.
    """

    def __cinit__(Profile self):
        pass

    def __init__(Profile self):
        pass

    def __dealloc__(Profile self):
        if self.open_profile and self.handle is not NULL:
            ret = cmsCloseProfile(self.handle)
            self.handle = NULL

    @staticmethod
    cdef Profile profile_from_file(const char *c_name, const char *c_access):
       cdef Profile instance
       cdef cmsHPROFILE c_handle
       c_handle = cmsOpenProfileFromFile(c_name, c_access)
       if c_handle is NULL:
           instance = None
       else:
           # Call to __new__ bypasses __init__ constructor
           instance = Profile.__new__(Profile)
           instance.handle = c_handle
           instance.open_profile = True
       return instance

    @classmethod
    def open(cls, file, mode="r"):
        return ctx(file, mode)

    @property
    def description(self):
        return get_profile_info(self.handle, info=cmsInfoType.cmsInfoDescription)

    @property
    def manufacturer(self):
        return get_profile_info(self.handle, info=cmsInfoType.cmsInfoManufacturer)

    @property
    def model(self):
        return get_profile_info(self.handle, info=cmsInfoType.cmsInfoModel)

    @property
    def copyright(self):
        return get_profile_info(self.handle, info=cmsInfoType.cmsInfoCopyright)

    @property
    def header_manufacturer(self):
        return Tag(cmsGetHeaderManufacturer(self.handle))
