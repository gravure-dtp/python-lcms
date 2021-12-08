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
    # Base types
    ctypedef unsigned char  cmsUInt8Number
    ctypedef signed char    cmsInt8Number
    ctypedef float          cmsFloat32Number
    ctypedef double         cmsFloat64Number
    ctypedef unsigned int   cmsUInt16Number
    ctypedef int            cmsInt16Number
    ctypedef unsigned int   cmsUInt32Number
    ctypedef int            cmsInt32Number
    ctypedef unsigned int   cmsUInt64Number
    ctypedef int            cmsInt64Number

    # Derivative types
    ctypedef cmsUInt32Number      cmsSignature;
    ctypedef cmsUInt16Number      cmsU8Fixed8Number;
    ctypedef cmsInt32Number       cmsS15Fixed16Number;
    ctypedef cmsUInt32Number      cmsU16Fixed16Number

    # Boolean
    ctypedef int                  cmsBool

    # Multi process elements types
    ctypedef enum cmsStageSignature:
        cmsSigCurveSetElemType
        cmsSigMatrixElemType
        cmsSigCLutElemType
        cmsSigBAcsElemType
        cmsSigEAcsElemType

        # Custom from here, not in the ICC Spec
        cmsSigXYZ2LabElemType
        cmsSigLab2XYZElemType
        cmsSigNamedColorElemType
        cmsSigLabV2toV4
        cmsSigLabV4toV2

        # Identities
        cmsSigIdentityElemType

        # Float to floatPCS
        cmsSigLab2FloatPCS
        cmsSigFloatPCS2Lab
        cmsSigXYZ2FloatPCS
        cmsSigFloatPCS2XYZ
        cmsSigClipNegativesElemType


    # Types of CurveElements
    ctypedef enum cmsCurveSegSignature:
        cmsSigFormulaCurveSeg
        cmsSigSampledCurveSeg
        cmsSigSegmentedCurve


    # Used in ResponseCurveType
    cdef enum:
        cmsSigStatusA
        cmsSigStatusE
        cmsSigStatusI
        cmsSigStatusT
        cmsSigStatusM
        cmsSigDN
        cmsSigDNP
        cmsSigDNN
        cmsSigDNNP


    # Device attributes, currently defined
    # values correspond to the low 4 bytes
    # of the 8 byte attribute quantity
    cdef enum:
        cmsReflective
        cmsTransparency
        cmsGlossy
        cmsMatte
