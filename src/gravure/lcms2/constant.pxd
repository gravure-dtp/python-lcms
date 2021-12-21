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

cdef extern from "lcms2.h":
    # Lib version
    int LCMS_VERSION

    # CMS FLAGS
    #bint CMS_IS_WINDOWS_
    #bint CMS_USE_BIG_ENDIAN
    #bint CMS_NO_PTHREADS

    # D50 XYZ normalized to Y=1.0
    float cmsD50X
    float cmsD50Y
    float cmsD50Z

    # V4 perceptual black
    float cmsPERCEPTUAL_BLACK_X
    float cmsPERCEPTUAL_BLACK_Y
    float cmsPERCEPTUAL_BLACK_Z

    # Maximum number of channels in ICC profiles
    int cmsMAXCHANNELS

    # for Multilocalized Unicode management
    const char[3]  cmsNoLanguage
    const char[3]  cmsNoCountry
