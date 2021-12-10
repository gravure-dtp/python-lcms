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
cimport types

cdef extern from "lcms2.h":
    # Colorspaces
    ctypedef struct cmsCIEXYZ:
        cmsFloat64Number X
        cmsFloat64Number Y
        cmsFloat64Number Z

    ctypedef struct cmsCIExyY:
        cmsFloat64Number x
        cmsFloat64Number y
        cmsFloat64Number Y

    ctypedef struct cmsCIELab:
        cmsFloat64Number L
        cmsFloat64Number a
        cmsFloat64Number b

    ctypedef struct cmsCIELCh:
        cmsFloat64Number L
        cmsFloat64Number C
        cmsFloat64Number h

    ctypedef struct cmsJCh:
        cmsFloat64Number J
        cmsFloat64Number C
        cmsFloat64Number h

    ctypedef struct cmsCIEXYZTRIPLE:
        cmsCIEXYZ  Red
        cmsCIEXYZ  Green
        cmsCIEXYZ  Blue

    ctypedef struct cmsCIExyYTRIPLE:
        cmsCIExyY  Red
        cmsCIExyY  Green
        cmsCIExyY  Blue

    # Illuminant types for structs below
    enum:
        cmsILLUMINANT_TYPE_UNKNOWN
        cmsILLUMINANT_TYPE_D50
        cmsILLUMINANT_TYPE_D65
        cmsILLUMINANT_TYPE_D93
        cmsILLUMINANT_TYPE_F2
        cmsILLUMINANT_TYPE_D55
        cmsILLUMINANT_TYPE_A
        cmsILLUMINANT_TYPE_E
        cmsILLUMINANT_TYPE_F8

    ctypedef struct cmsICCMeasurementConditions:
        cmsUInt32Number  Observer    # 0 = unknown, 1=CIE 1931, 2=CIE 1964
        cmsCIEXYZ        Backing     # Value of backing
        cmsUInt32Number  Geometry    # 0=unknown, 1=45/0, 0/45 2=0d, d/0
        cmsFloat64Number Flare       # 0..1.0
        cmsUInt32Number  IlluminantType

    ctypedef struct cmsICCViewingConditions:
        cmsCIEXYZ       IlluminantXYZ   # Not the same struct as CAM02,
        cmsCIEXYZ       SurroundXYZ     # This is for storing the tag
        cmsUInt32Number IlluminantType  # viewing condition
