@unique
class ICCDef(TagEnum):
    """Enumeration of definitions in ICC spec.
    """
    cmsMagicNumber = c_cmsMagicNumber
    lcmsSignature = c_lcmsSignature

@unique
class TagTypeSignature(TagEnum):
    """Enumeration of base ICC type definitions.
    """
    ChromaticityType = cmsSigChromaticityType
    ColorantOrderType = cmsSigColorantOrderType
    ColorantTableType = cmsSigColorantTableType
    CrdInfoType = cmsSigCrdInfoType
    CurveType = cmsSigCurveType
    DataType = cmsSigDataType
    DictType = cmsSigDictType
    DateTimeType = cmsSigDateTimeType
    DeviceSettingsType = cmsSigDeviceSettingsType
    Lut16Type = cmsSigLut16Type
    Lut8Type = cmsSigLut8Type
    LutAtoBType = cmsSigLutAtoBType
    LutBtoAType = cmsSigLutBtoAType
    MeasurementType = cmsSigMeasurementType
    MultiLocalizedUnicodeType = cmsSigMultiLocalizedUnicodeType
    MultiProcessElementType = cmsSigMultiProcessElementType
    NamedColorType = cmsSigNamedColorType
    NamedColor2Type = cmsSigNamedColor2Type
    ParametricCurveType = cmsSigParametricCurveType
    ProfileSequenceDescType = cmsSigProfileSequenceDescType
    ProfileSequenceIdType = cmsSigProfileSequenceIdType
    ResponseCurveSet16Type = cmsSigResponseCurveSet16Type
    S15Fixed16ArrayType = cmsSigS15Fixed16ArrayType
    ScreeningType = cmsSigScreeningType
    SignatureType = cmsSigSignatureType
    TextType = cmsSigTextType
    TextDescriptionType = cmsSigTextDescriptionType
    U16Fixed16ArrayType = cmsSigU16Fixed16ArrayType
    UcrBgType = cmsSigUcrBgType
    UInt16ArrayType = cmsSigUInt16ArrayType
    UInt32ArrayType = cmsSigUInt32ArrayType
    UInt64ArrayType = cmsSigUInt64ArrayType
    UInt8ArrayType = cmsSigUInt8ArrayType
    VcgtType = cmsSigVcgtType
    ViewingConditionsType = cmsSigViewingConditionsType
    XYZType = cmsSigXYZType


@unique
class TagSignature(TagEnum):
    """Enumeration of base ICC tag definitions.
    """
    AToB0Tag = cmsSigAToB0Tag
    AToB1Tag = cmsSigAToB1Tag
    AToB2Tag = cmsSigAToB2Tag
    BlueColorantTag = cmsSigBlueColorantTag
    BlueMatrixColumnTag = cmsSigBlueMatrixColumnTag
    BlueTRCTag = cmsSigBlueTRCTag
    BToA0Tag = cmsSigBToA0Tag
    BToA1Tag = cmsSigBToA1Tag
    BToA2Tag = cmsSigBToA2Tag
    CalibrationDateTimeTag = cmsSigCalibrationDateTimeTag
    CharTargetTag = cmsSigCharTargetTag
    ChromaticAdaptationTag = cmsSigChromaticAdaptationTag
    ChromaticityTag = cmsSigChromaticityTag
    ColorantOrderTag = cmsSigColorantOrderTag
    ColorantTableTag = cmsSigColorantTableTag
    ColorantTableOutTag = cmsSigColorantTableOutTag
    ColorimetricIntentImageStateTag = cmsSigColorimetricIntentImageStateTag
    CopyrightTag = cmsSigCopyrightTag
    CrdInfoTag = cmsSigCrdInfoTag
    DataTag = cmsSigDataTag
    DateTimeTag = cmsSigDateTimeTag
    DeviceMfgDescTag = cmsSigDeviceMfgDescTag
    DeviceModelDescTag = cmsSigDeviceModelDescTag
    DeviceSettingsTag = cmsSigDeviceSettingsTag
    DToB0Tag = cmsSigDToB0Tag
    DToB1Tag = cmsSigDToB1Tag
    DToB2Tag = cmsSigDToB2Tag
    DToB3Tag = cmsSigDToB3Tag
    BToD0Tag = cmsSigBToD0Tag
    BToD1Tag = cmsSigBToD1Tag
    BToD2Tag = cmsSigBToD2Tag
    BToD3Tag = cmsSigBToD3Tag
    GamutTag = cmsSigGamutTag
    GrayTRCTag = cmsSigGrayTRCTag
    GreenColorantTag = cmsSigGreenColorantTag
    GreenMatrixColumnTag = cmsSigGreenMatrixColumnTag
    GreenTRCTag = cmsSigGreenTRCTag
    LuminanceTag = cmsSigLuminanceTag
    MeasurementTag = cmsSigMeasurementTag
    MediaBlackPointTag = cmsSigMediaBlackPointTag
    MediaWhitePointTag = cmsSigMediaWhitePointTag
    NamedColorTag = cmsSigNamedColorTag
    NamedColor2Tag = cmsSigNamedColor2Tag
    OutputResponseTag = cmsSigOutputResponseTag
    PerceptualRenderingIntentGamutTag = cmsSigPerceptualRenderingIntentGamutTag
    Preview0Tag = cmsSigPreview0Tag
    Preview1Tag = cmsSigPreview1Tag
    Preview2Tag = cmsSigPreview2Tag
    ProfileDescriptionTag = cmsSigProfileDescriptionTag
    ProfileDescriptionMLTag = cmsSigProfileDescriptionMLTag
    ProfileSequenceDescTag = cmsSigProfileSequenceDescTag
    ProfileSequenceIdTag = cmsSigProfileSequenceIdTag
    Ps2CRD0Tag = cmsSigPs2CRD0Tag
    Ps2CRD1Tag = cmsSigPs2CRD1Tag
    Ps2CRD2Tag = cmsSigPs2CRD2Tag
    Ps2CRD3Tag = cmsSigPs2CRD3Tag
    Ps2CSATag = cmsSigPs2CSATag
    Ps2RenderingIntentTag = cmsSigPs2RenderingIntentTag
    RedColorantTag = cmsSigRedColorantTag
    RedMatrixColumnTag = cmsSigRedMatrixColumnTag
    RedTRCTag = cmsSigRedTRCTag
    SaturationRenderingIntentGamutTag = cmsSigSaturationRenderingIntentGamutTag
    ScreeningDescTag = cmsSigScreeningDescTag
    ScreeningTag = cmsSigScreeningTag
    TechnologyTag = cmsSigTechnologyTag
    UcrBgTag = cmsSigUcrBgTag
    ViewingCondDescTag = cmsSigViewingCondDescTag
    ViewingConditionsTag = cmsSigViewingConditionsTag
    VcgtTag = cmsSigVcgtTag
    MetaTag = cmsSigMetaTag
    ArgyllArtsTag = cmsSigArgyllArtsTag


@unique
class TechnologySignature(TagEnum):
    """Enumeration of ICC Technology tag.
    """
    DigitalCamera = cmsSigDigitalCamera
    FilmScanner = cmsSigFilmScanner
    ReflectiveScanner = cmsSigReflectiveScanner
    InkJetPrinter = cmsSigInkJetPrinter
    ThermalWaxPrinter = cmsSigThermalWaxPrinter
    ElectrophotographicPrinter = cmsSigElectrophotographicPrinter
    ElectrostaticPrinter = cmsSigElectrostaticPrinter
    DyeSublimationPrinter = cmsSigDyeSublimationPrinter
    PhotographicPaperPrinter = cmsSigPhotographicPaperPrinter
    FilmWriter = cmsSigFilmWriter
    VideoMonitor = cmsSigVideoMonitor
    VideoCamera = cmsSigVideoCamera
    ProjectionTelevision = cmsSigProjectionTelevision
    CRTDisplay = cmsSigCRTDisplay
    PMDisplay = cmsSigPMDisplay
    AMDisplay = cmsSigAMDisplay
    PhotoCD = cmsSigPhotoCD
    PhotoImageSetter = cmsSigPhotoImageSetter
    Gravure = cmsSigGravure
    OffsetLithography = cmsSigOffsetLithography
    Silkscreen = cmsSigSilkscreen
    Flexography = cmsSigFlexography
    MotionPictureFilmScanner = cmsSigMotionPictureFilmScanner
    MotionPictureFilmRecorder = cmsSigMotionPictureFilmRecorder
    DigitalMotionPictureCamera = cmsSigDigitalMotionPictureCamera
    DigitalCinemaProjector = cmsSigDigitalCinemaProjector


@unique
class ColorSpaceSignature(TagEnum):
    """Enumeration of ICC Color spaces.
    """
    XYZData = cmsSigXYZData
    LabData = cmsSigLabData
    LuvData = cmsSigLuvData
    YCbCrData = cmsSigYCbCrData
    YxyData = cmsSigYxyData
    RgbData = cmsSigRgbData
    GrayData = cmsSigGrayData
    HsvData = cmsSigHsvData
    HlsData = cmsSigHlsData
    CmykData = cmsSigCmykData
    CmyData = cmsSigCmyData
    MCH1Data = cmsSigMCH1Data
    MCH2Data = cmsSigMCH2Data
    MCH3Data = cmsSigMCH3Data
    MCH4Data = cmsSigMCH4Data
    MCH5Data = cmsSigMCH5Data
    MCH6Data = cmsSigMCH6Data
    MCH7Data = cmsSigMCH7Data
    MCH8Data = cmsSigMCH8Data
    MCH9Data = cmsSigMCH9Data
    MCHAData = cmsSigMCHAData
    MCHBData = cmsSigMCHBData
    MCHCData = cmsSigMCHCData
    MCHDData = cmsSigMCHDData
    MCHEData = cmsSigMCHEData
    MCHFData = cmsSigMCHFData
    NamedData = cmsSigNamedData
    _1colorData = cmsSig1colorData
    _2colorData = cmsSig2colorData
    _3colorData = cmsSig3colorData
    _4colorData = cmsSig4colorData
    _5colorData = cmsSig5colorData
    _6colorData = cmsSig6colorData
    _7colorData = cmsSig7colorData
    _8colorData = cmsSig8colorData
    _9colorData = cmsSig9colorData
    _10colorData = cmsSig10colorData
    _11colorData = cmsSig11colorData
    _12colorData = cmsSig12colorData
    _13colorData = cmsSig13colorData
    _14colorData = cmsSig14colorData
    _15colorData = cmsSig15colorData
    LuvKData = cmsSigLuvKData


@unique
class ProfileClassSignature(TagEnum):
    """Enumeration of ICC Profile Class.
    """
    InputClass = cmsSigInputClass
    DisplayClass = cmsSigDisplayClass
    OutputClass = cmsSigOutputClass
    LinkClass = cmsSigLinkClass
    AbstractClass = cmsSigAbstractClass
    ColorSpaceClass = cmsSigColorSpaceClass
    NamedColorClass = cmsSigNamedColorClass


@unique
class PlatformSignature(TagEnum):
    """Enumeration of ICC Platforms.
    """
    Macintosh = cmsSigMacintosh
    Microsoft = cmsSigMicrosoft
    Solaris = cmsSigSolaris
    SGI = cmsSigSGI
    Taligent = cmsSigTaligent
    Unices = cmsSigUnices


@unique
class Referencegamut(TagEnum):
    """Enumeration of Reference gamut.
    """
    PerceptualReferenceMediumGamut = cmsSigPerceptualReferenceMediumGamut


@unique
class ColorimetricIntentImageStateTag(TagEnum):
    """Enumeration of used For TagSignature.ColorimetricIntentImageStateTag.
    """
    SceneColorimetryEstimates = cmsSigSceneColorimetryEstimates
    SceneAppearanceEstimates = cmsSigSceneAppearanceEstimates
    FocalPlaneColorimetryEstimates = cmsSigFocalPlaneColorimetryEstimates
    ReflectionHardcopyOriginalColorimetry = cmsSigReflectionHardcopyOriginalColorimetry
    ReflectionPrintOutputColorimetry = cmsSigReflectionPrintOutputColorimetry


@unique
class StageSignature(TagEnum):
    """Enumeration of multi process elements types.

    Only CurveSetElemType, MatrixElemType, CLutElemType, BAcsElemType
    and EAcsElemType are part of the ICC specs. Others are custom to LCMS2.
    """
    CurveSetElemType = cmsSigCurveSetElemType
    MatrixElemType = cmsSigMatrixElemType
    CLutElemType = cmsSigCLutElemType
    BAcsElemType = cmsSigBAcsElemType
    EAcsElemType = cmsSigEAcsElemType
    # Custom from here, not in the ICC Spec
    XYZ2LabElemType = cmsSigXYZ2LabElemType
    Lab2XYZElemType = cmsSigLab2XYZElemType
    NamedColorElemType = cmsSigNamedColorElemType
    LabV2toV4 = cmsSigLabV2toV4
    LabV4toV2 = cmsSigLabV4toV2
    # Identities
    IdentityElemType = cmsSigIdentityElemType
    # Float to floatPCS
    Lab2FloatPCS = cmsSigLab2FloatPCS
    FloatPCS2Lab = cmsSigFloatPCS2Lab
    XYZ2FloatPCS = cmsSigXYZ2FloatPCS
    FloatPCS2XYZ = cmsSigFloatPCS2XYZ
    ClipNegativesElemType = cmsSigClipNegativesElemType


@unique
class CurveSegSignature(TagEnum):
    """Enumeration of types of CurveElements.
    """
    FormulaCurveSeg = cmsSigFormulaCurveSeg
    SampledCurveSeg = cmsSigSampledCurveSeg
    SegmentedCurve = cmsSigSegmentedCurve


@unique
class ResponseCurveTypeSignature(TagEnum):
    """Enumeration of used in ResponseCurveType.
    """
    StatusA = cmsSigStatusA
    StatusE = cmsSigStatusE
    StatusI = cmsSigStatusI
    StatusT = cmsSigStatusT
    StatusM = cmsSigStatusM
    DN = cmsSigDN
    DNP = cmsSigDNP
    DNN = cmsSigDNN
    DNNP = cmsSigDNNP
