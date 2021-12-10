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
    # Definitions in ICC spec
    int c_cmsMagicNumber "cmsMagicNumber"
    int c_lcmsSignature "lcmsSignature"

    # Base ICC type definitions
    ctypedef enum cmsTagTypeSignature:
        cmsSigChromaticityType
        cmsSigColorantOrderType
        cmsSigColorantTableType
        cmsSigCrdInfoType
        cmsSigCurveType
        cmsSigDataType
        cmsSigDictType
        cmsSigDateTimeType
        cmsSigDeviceSettingsType
        cmsSigLut16Type
        cmsSigLut8Type
        cmsSigLutAtoBType
        cmsSigLutBtoAType
        cmsSigMeasurementType
        cmsSigMultiLocalizedUnicodeType
        cmsSigMultiProcessElementType
        cmsSigNamedColorType
        cmsSigNamedColor2Type
        cmsSigParametricCurveType
        cmsSigProfileSequenceDescType
        cmsSigProfileSequenceIdType
        cmsSigResponseCurveSet16Type
        cmsSigS15Fixed16ArrayType
        cmsSigScreeningType
        cmsSigSignatureType
        cmsSigTextType
        cmsSigTextDescriptionType
        cmsSigU16Fixed16ArrayType
        cmsSigUcrBgType
        cmsSigUInt16ArrayType
        cmsSigUInt32ArrayType
        cmsSigUInt64ArrayType
        cmsSigUInt8ArrayType
        cmsSigVcgtType
        cmsSigViewingConditionsType
        cmsSigXYZType

    # Base ICC tag definitions
    ctypedef enum cmsTagSignature:
        cmsSigAToB0Tag
        cmsSigAToB1Tag
        cmsSigAToB2Tag
        cmsSigBlueColorantTag
        cmsSigBlueMatrixColumnTag
        cmsSigBlueTRCTag
        cmsSigBToA0Tag
        cmsSigBToA1Tag
        cmsSigBToA2Tag
        cmsSigCalibrationDateTimeTag
        cmsSigCharTargetTag
        cmsSigChromaticAdaptationTag
        cmsSigChromaticityTag
        cmsSigColorantOrderTag
        cmsSigColorantTableTag
        cmsSigColorantTableOutTag
        cmsSigColorimetricIntentImageStateTag
        cmsSigCopyrightTag
        cmsSigCrdInfoTag
        cmsSigDataTag
        cmsSigDateTimeTag
        cmsSigDeviceMfgDescTag
        cmsSigDeviceModelDescTag
        cmsSigDeviceSettingsTag
        cmsSigDToB0Tag
        cmsSigDToB1Tag
        cmsSigDToB2Tag
        cmsSigDToB3Tag
        cmsSigBToD0Tag
        cmsSigBToD1Tag
        cmsSigBToD2Tag
        cmsSigBToD3Tag
        cmsSigGamutTag
        cmsSigGrayTRCTag
        cmsSigGreenColorantTag
        cmsSigGreenMatrixColumnTag
        cmsSigGreenTRCTag
        cmsSigLuminanceTag
        cmsSigMeasurementTag
        cmsSigMediaBlackPointTag
        cmsSigMediaWhitePointTag
        cmsSigNamedColorTag
        cmsSigNamedColor2Tag
        cmsSigOutputResponseTag
        cmsSigPerceptualRenderingIntentGamutTag
        cmsSigPreview0Tag
        cmsSigPreview1Tag
        cmsSigPreview2Tag
        cmsSigProfileDescriptionTag
        cmsSigProfileDescriptionMLTag
        cmsSigProfileSequenceDescTag
        cmsSigProfileSequenceIdTag
        cmsSigPs2CRD0Tag
        cmsSigPs2CRD1Tag
        cmsSigPs2CRD2Tag
        cmsSigPs2CRD3Tag
        cmsSigPs2CSATag
        cmsSigPs2RenderingIntentTag
        cmsSigRedColorantTag
        cmsSigRedMatrixColumnTag
        cmsSigRedTRCTag
        cmsSigSaturationRenderingIntentGamutTag
        cmsSigScreeningDescTag
        cmsSigScreeningTag
        cmsSigTechnologyTag
        cmsSigUcrBgTag
        cmsSigViewingCondDescTag
        cmsSigViewingConditionsTag
        cmsSigVcgtTag
        cmsSigMetaTag
        cmsSigArgyllArtsTag

    # ICC Technology tag
    ctypedef enum cmsTechnologySignature:
        cmsSigDigitalCamera
        cmsSigFilmScanner
        cmsSigReflectiveScanner
        cmsSigInkJetPrinter
        cmsSigThermalWaxPrinter
        cmsSigElectrophotographicPrinter
        cmsSigElectrostaticPrinter
        cmsSigDyeSublimationPrinter
        cmsSigPhotographicPaperPrinter
        cmsSigFilmWriter
        cmsSigVideoMonitor
        cmsSigVideoCamera
        cmsSigProjectionTelevision
        cmsSigCRTDisplay
        cmsSigPMDisplay
        cmsSigAMDisplay
        cmsSigPhotoCD
        cmsSigPhotoImageSetter
        cmsSigGravure
        cmsSigOffsetLithography
        cmsSigSilkscreen
        cmsSigFlexography
        cmsSigMotionPictureFilmScanner
        cmsSigMotionPictureFilmRecorder
        cmsSigDigitalMotionPictureCamera
        cmsSigDigitalCinemaProjector

    # ICC Color spaces
    ctypedef enum cmsColorSpaceSignature:
        cmsSigXYZData
        cmsSigLabData
        cmsSigLuvData
        cmsSigYCbCrData
        cmsSigYxyData
        cmsSigRgbData
        cmsSigGrayData
        cmsSigHsvData
        cmsSigHlsData
        cmsSigCmykData
        cmsSigCmyData
        cmsSigMCH1Data
        cmsSigMCH2Data
        cmsSigMCH3Data
        cmsSigMCH4Data
        cmsSigMCH5Data
        cmsSigMCH6Data
        cmsSigMCH7Data
        cmsSigMCH8Data
        cmsSigMCH9Data
        cmsSigMCHAData
        cmsSigMCHBData
        cmsSigMCHCData
        cmsSigMCHDData
        cmsSigMCHEData
        cmsSigMCHFData
        cmsSigNamedData
        cmsSig1colorData
        cmsSig2colorData
        cmsSig3colorData
        cmsSig4colorData
        cmsSig5colorData
        cmsSig6colorData
        cmsSig7colorData
        cmsSig8colorData
        cmsSig9colorData
        cmsSig10colorData
        cmsSig11colorData
        cmsSig12colorData
        cmsSig13colorData
        cmsSig14colorData
        cmsSig15colorData
        cmsSigLuvKData

    # ICC Profile Class
    ctypedef enum cmsProfileClassSignature:
        cmsSigInputClass
        cmsSigDisplayClass
        cmsSigOutputClass
        cmsSigLinkClass
        cmsSigAbstractClass
        cmsSigColorSpaceClass
        cmsSigNamedColorClass

    # ICC Platforms
    ctypedef enum cmsPlatformSignature:
        cmsSigMacintosh
        cmsSigMicrosoft
        cmsSigSolaris
        cmsSigSGI
        cmsSigTaligent
        cmsSigUnices

    enum:
        # Reference gamut
        cmsSigPerceptualReferenceMediumGamut
        # For cmsSigColorimetricIntentImageStateTag
        cmsSigSceneColorimetryEstimates
        cmsSigSceneAppearanceEstimates
        cmsSigFocalPlaneColorimetryEstimates
        cmsSigReflectionHardcopyOriginalColorimetry
        cmsSigReflectionPrintOutputColorimetry

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
    enum:
        cmsSigStatusA
        cmsSigStatusE
        cmsSigStatusI
        cmsSigStatusT
        cmsSigStatusM
        cmsSigDN
        cmsSigDNP
        cmsSigDNN
        cmsSigDNNP
