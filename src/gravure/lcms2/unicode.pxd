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
from libc.stddef cimport wchar_t
from gravure.lcms2.types cimport *

cdef extern from "lcms2.h":
    # for Multilocalized Unicode management
    const char[3]  cmsNoLanguage
    const char[3]  cmsNoCountry
    
    # Localized info
    ctypedef enum cmsInfoType:
                 cmsInfoDescription
                 cmsInfoManufacturer
                 cmsInfoModel
                 cmsInfoCopyright

    cmsUInt32Number cmsGetProfileInfo(cmsHPROFILE hProfile, cmsInfoType Info, const char LanguageCode[3], const char CountryCode[3], wchar_t* Buffer, cmsUInt32Number BufferSize)

cdef int BYTE_KIND

cdef object unicode_from_wchar(const wchar_t *buffer, Py_ssize_t size) with gil
cdef object get_profile_info(cmsHPROFILE handle, cmsInfoType info) with gil
