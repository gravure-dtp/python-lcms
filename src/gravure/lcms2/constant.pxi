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


VERSION = LCMS_VERSION
D50X = cmsD50X
D50Y = cmsD50Y
D50Z = cmsD50Z
PERCEPTUAL_BLACK_X = cmsPERCEPTUAL_BLACK_X
PERCEPTUAL_BLACK_Y = cmsPERCEPTUAL_BLACK_Y
PERCEPTUAL_BLACK_Z = cmsPERCEPTUAL_BLACK_Z
MAXCHANNELS = cmsMAXCHANNELS
