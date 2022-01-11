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
from enum import Enum, IntEnum, unique
from gravure.lcms2.constant cimport cmsMAXCHANNELS


@unique
class PixelType(IntEnum):
    ANY = PT_ANY
    GRAY = PT_GRAY
    RGB = PT_RGB
    CMY = PT_CMY
    CMYK = PT_CMYK
    YCbCr = PT_YCbCr
    YUV = PT_YUV
    XYZ = PT_XYZ
    Lab = PT_Lab
    YUVK = PT_YUVK
    HSV = PT_HSV
    HLS = PT_HLS
    Yxy = PT_Yxy
    MCH1 = PT_MCH1
    MCH2 = PT_MCH2
    MCH3 = PT_MCH3
    MCH4 = PT_MCH4
    MCH5 = PT_MCH5
    MCH6 = PT_MCH6
    MCH7 = PT_MCH7
    MCH8 = PT_MCH8
    MCH9 = PT_MCH9
    MCH10 = PT_MCH10
    MCH11 = PT_MCH11
    MCH12 = PT_MCH12
    MCH13 = PT_MCH13
    MCH14 = PT_MCH14
    MCH15 = PT_MCH15
    LabV2 = PT_LabV2


class ColorType(int):
    def __new__(cls, value=0, colorspace=None, channels=None, sbytes=None,
                isfloat=False, extra=0, planar=False, swap_endianness=False,
                swap_first=False, do_swap=False, flavor=0):
        if not isinstance(value, int) or value<0:
            raise ValueError(f"can't create a ColorType from {value}")

        minargs = (colorspace is not None, channels is not None, sbytes is not None)
        if any(minargs):
            if all(minargs):
                if not isinstance(colorspace, PixelType):
                    raise ValueError(f"{colorspace} is not a valide Pixeltype")
                if channels not in range(1, cmsMAXCHANNELS + 1):
                    raise ValueError(f"channels should be in the range[1, {cmsMAXCHANNELS}]")
                if sbytes not in [1, 2, 4, 8]:
                    raise ValueError(f"sbytes should be 1, 2, 4 or 8")
                # NOTE THAT 'BYTES' FIELD IS SET TO ZERO ON DLB
                # because 8 bytes overflows the bitfield
                sbytes = 0 if sbytes==8 else sbytes
                if extra not in range(0, cmsMAXCHANNELS + 1):
                    raise ValueError(f"extra should be in the range[0, {cmsMAXCHANNELS}]")

                value = value | FLOAT_SH(1) if isfloat else value
                value = value | COLORSPACE_SH(colorspace)
                value = value | EXTRA_SH(extra) if extra else value
                value = value | CHANNELS_SH(channels)
                value = value | BYTES_SH(sbytes)
                value = value | FLAVOR_SH(1) if flavor else value
                value = value | ENDIAN16_SH(1) if swap_endianness else value
                value = value | DOSWAP_SH(1) if do_swap else value
                value = value | SWAPFIRST_SH(1) if swap_first else value
                value = value | PLANAR_SH(1) if planar else value
            else:
                raise ValueError("Need at least colorspace, channels and sbytes to be set to create a new ColorType from flags")
        return int.__new__(cls, value)


    def __repr__(self):
        return f"ColorType({self})"


    def __str__(self):
        return str(int(self))


    @property
    def colorspace(self):
        """
        The color space used by this ColorType as a member of the gravure.lcms2.colortype.PixelType enum.
        """
        return PixelType(T_COLORSPACE(self))


    @property
    def channels(self):
        """
        Return the numbers of channels (Samples per pixel) holded by this ColorType.
        """
        return T_CHANNELS(self)


    @property
    def extra(self):
        """
        Return the numbers of extra channels (ie: alpha channels) holded by this ColorType. .
        """
        return T_EXTRA(self)


    @property
    def sbytes(self):
        """
        Return bytes per sample, the numbers of bytes use to store a channel's value for this ColorType. .
        """
        tbytes = T_BYTES(self)
        # NOTE THAT 'BYTES' FIELD IS SET TO ZERO ON DLB
        # because 8 bytes overflows the bitfield
        if tbytes == 0:
            tbytes = 8
        return tbytes


    @property
    def planar(self):
        """
        Return True if this ColorType holds values as planar, False if chunky.
        """
        return bool(T_PLANAR(self))


    @property
    def flavor(self):
        """
        Return 0 for this ColorType if values of zero means black, 1 if white.
        """
        return T_FLAVOR(self)


    @property
    def isfloat(self):
        """
        Determine if this ColorType use floating point values.
        """
        return bool(T_FLOAT(self))


    @property
    def do_swap(self):
        """
        Determine if this ColorType have its components swapped (ie: BGR, KYMC).
        """
        return bool(T_DOSWAP(self))


    @property
    def swap_first(self):
        """
        Determine if this ColorType have its last component swapped first (ie: RGBA -> ARGB or CMYK -> KCMY).
        """
        return bool(T_SWAPFIRST(self))

    @property
    def swap_endianness(self):
        """
        Determine if this ColorType have its 16bts endianness swapped.
        """
        return bool(T_ENDIAN16(self))

    @property
    def nbytes(self):
        """
        size in bytes for this ColorType necessary to store all channels values for a sample.
        """
        return self.bytes_per_sample * (self.channels + self.extra_channels)


class ColorTypeEnum(ColorType, Enum):
    """Enum where members are also (and must be) gravure.lcms2.colortype.ColorType object.
    """


class Type(ColorTypeEnum):
    GRAY_8 = TYPE_GRAY_8
    GRAY_8_REV = TYPE_GRAY_8_REV
    GRAY_16 = TYPE_GRAY_16
    GRAY_16_REV = TYPE_GRAY_16_REV
    GRAY_16_SE = TYPE_GRAY_16_SE
    GRAYA_8 = TYPE_GRAYA_8
    GRAYA_16 = TYPE_GRAYA_16
    GRAYA_16_SE = TYPE_GRAYA_16_SE
    GRAYA_8_PLANAR = TYPE_GRAYA_8_PLANAR
    GRAYA_16_PLANAR = TYPE_GRAYA_16_PLANAR

    RGB_8 = TYPE_RGB_8
    RGB_8_PLANAR = TYPE_RGB_8_PLANAR
    BGR_8 = TYPE_BGR_8
    BGR_8_PLANAR = TYPE_BGR_8_PLANAR
    RGB_16 = TYPE_RGB_16
    RGB_16_PLANAR = TYPE_RGB_16_PLANAR
    RGB_16_SE = TYPE_RGB_16_SE
    BGR_16 = TYPE_BGR_16
    BGR_16_PLANAR = TYPE_BGR_16_PLANAR
    BGR_16_SE = TYPE_BGR_16_SE

    RGBA_8 = TYPE_RGBA_8
    RGBA_8_PLANAR = TYPE_RGBA_8_PLANAR
    RGBA_16 = TYPE_RGBA_16
    RGBA_16_PLANAR = TYPE_RGBA_16_PLANAR
    RGBA_16_SE = TYPE_RGBA_16_SE

    ARGB_8 = TYPE_ARGB_8
    ARGB_8_PLANAR = TYPE_ARGB_8_PLANAR
    ARGB_16 = TYPE_ARGB_16

    ABGR_8 = TYPE_ABGR_8
    ABGR_8_PLANAR = TYPE_ABGR_8_PLANAR
    ABGR_16 = TYPE_ABGR_16
    ABGR_16_PLANAR = TYPE_ABGR_16_PLANAR
    ABGR_16_SE = TYPE_ABGR_16_SE

    BGRA_8 = TYPE_BGRA_8
    BGRA_8_PLANAR = TYPE_BGRA_8_PLANAR
    BGRA_16 = TYPE_BGRA_16
    BGRA_16_SE = TYPE_BGRA_16_SE

    CMY_8 = TYPE_CMY_8
    CMY_8_PLANAR = TYPE_CMY_8_PLANAR
    CMY_16 = TYPE_CMY_16
    CMY_16_PLANAR = TYPE_CMY_16_PLANAR
    CMY_16_SE = TYPE_CMY_16_SE

    CMYK_8 = TYPE_CMYK_8
    CMYKA_8 = TYPE_CMYKA_8
    CMYK_8_REV = TYPE_CMYK_8_REV
    YUVK_8 = TYPE_YUVK_8
    CMYK_8_PLANAR = TYPE_CMYK_8_PLANAR
    CMYK_16 = TYPE_CMYK_16
    CMYK_16_REV = TYPE_CMYK_16_REV
    YUVK_16 = TYPE_YUVK_16
    CMYK_16_PLANAR = TYPE_CMYK_16_PLANAR
    CMYK_16_SE = TYPE_CMYK_16_SE

    KYMC_8 = TYPE_KYMC_8
    KYMC_16 = TYPE_KYMC_16
    KYMC_16_SE = TYPE_KYMC_16_SE

    KCMY_8 = TYPE_KCMY_8
    KCMY_8_REV = TYPE_KCMY_8_REV
    KCMY_16 = TYPE_KCMY_16
    KCMY_16_REV = TYPE_KCMY_16_REV
    KCMY_16_SE = TYPE_KCMY_16_SE

    CMYK5_8 = TYPE_CMYK5_8
    CMYK5_16 = TYPE_CMYK5_16
    CMYK5_16_SE = TYPE_CMYK5_16_SE
    KYMC5_8 = TYPE_KYMC5_8
    KYMC5_16 = TYPE_KYMC5_16
    KYMC5_16_SE = TYPE_KYMC5_16_SE

    CMYK6_8 = TYPE_CMYK6_8
    CMYK6_8_PLANAR = TYPE_CMYK6_8_PLANAR
    CMYK6_16 = TYPE_CMYK6_16
    CMYK6_16_PLANAR = TYPE_CMYK6_16_PLANAR
    CMYK6_16_SE = TYPE_CMYK6_16_SE

    CMYK7_8 = TYPE_CMYK7_8
    CMYK7_16 = TYPE_CMYK7_16
    CMYK7_16_SE = TYPE_CMYK7_16_SE
    KYMC7_8 = TYPE_KYMC7_8
    KYMC7_16 = TYPE_KYMC7_16
    KYMC7_16_SE = TYPE_KYMC7_16_SE

    CMYK8_8 = TYPE_CMYK8_8
    CMYK8_16 = TYPE_CMYK8_16
    CMYK8_16_SE = TYPE_CMYK8_16_SE
    KYMC8_8 = TYPE_KYMC8_8
    KYMC8_16 = TYPE_KYMC8_16
    KYMC8_16_SE = TYPE_KYMC8_16_SE

    CMYK9_8 = TYPE_CMYK9_8
    CMYK9_16 = TYPE_CMYK9_16
    CMYK9_16_SE = TYPE_CMYK9_16_SE
    KYMC9_8 = TYPE_KYMC9_8
    KYMC9_16 = TYPE_KYMC9_16
    KYMC9_16_SE = TYPE_KYMC9_16_SE

    CMYK10_8 = TYPE_CMYK10_8
    CMYK10_16 = TYPE_CMYK10_16
    CMYK10_16_SE = TYPE_CMYK10_16_SE
    KYMC10_8 = TYPE_KYMC10_8
    KYMC10_16 = TYPE_KYMC10_16
    KYMC10_16_SE = TYPE_KYMC10_16_SE

    CMYK11_8 = TYPE_CMYK11_8
    CMYK11_16 = TYPE_CMYK11_16
    CMYK11_16_SE = TYPE_CMYK11_16_SE
    KYMC11_8 = TYPE_KYMC11_8
    KYMC11_16 = TYPE_KYMC11_16
    KYMC11_16_SE = TYPE_KYMC11_16_SE

    CMYK12_8 = TYPE_CMYK12_8
    CMYK12_16 = TYPE_CMYK12_16
    CMYK12_16_SE = TYPE_CMYK12_16_SE
    KYMC12_8 = TYPE_KYMC12_8
    KYMC12_16 = TYPE_KYMC12_16
    KYMC12_16_SE = TYPE_KYMC12_16_SE

    # Colorimetric
    XYZ_16 = TYPE_XYZ_16
    Lab_8 = TYPE_Lab_8
    LabV2_8 = TYPE_LabV2_8
    ALab_8 = TYPE_ALab_8
    ALabV2_8 = TYPE_ALabV2_8
    Lab_16 = TYPE_Lab_16
    LabV2_16 = TYPE_LabV2_16
    Yxy_16 = TYPE_Yxy_16

    # YCbCr
    YCbCr_8 = TYPE_YCbCr_8
    YCbCr_8_PLANAR = TYPE_YCbCr_8_PLANAR
    YCbCr_16 = TYPE_YCbCr_16
    YCbCr_16_PLANAR = TYPE_YCbCr_16_PLANAR
    YCbCr_16_SE = TYPE_YCbCr_16_SE

    # YUV
    YUV_8 = TYPE_YUV_8
    YUV_8_PLANAR = TYPE_YUV_8_PLANAR
    YUV_16 = TYPE_YUV_16
    YUV_16_PLANAR = TYPE_YUV_16_PLANAR
    YUV_16_SE = TYPE_YUV_16_SE

    # HLS
    HLS_8 = TYPE_HLS_8
    HLS_8_PLANAR = TYPE_HLS_8_PLANAR
    HLS_16 = TYPE_HLS_16
    HLS_16_PLANAR = TYPE_HLS_16_PLANAR
    HLS_16_SE = TYPE_HLS_16_SE

    # HSV
    HSV_8 = TYPE_HSV_8
    HSV_8_PLANAR = TYPE_HSV_8_PLANAR
    HSV_16 = TYPE_HSV_16
    HSV_16_PLANAR = TYPE_HSV_16_PLANAR
    HSV_16_SE = TYPE_HSV_16_SE

    # Named color index.
    # Only 16 bits allowed (don't check colorspace)
    NAMED_COLOR_INDEX = TYPE_NAMED_COLOR_INDEX

    # Float formatters.
    XYZ_FLT = TYPE_XYZ_FLT
    Lab_FLT = TYPE_Lab_FLT
    LabA_FLT = TYPE_LabA_FLT
    GRAY_FLT = TYPE_GRAY_FLT
    RGB_FLT = TYPE_RGB_FLT
    RGBA_FLT = TYPE_RGBA_FLT
    ARGB_FLT = TYPE_ARGB_FLT
    BGR_FLT = TYPE_BGR_FLT
    BGRA_FLT = TYPE_BGRA_FLT
    ABGR_FLT = TYPE_ABGR_FLT
    CMYK_FLT = TYPE_CMYK_FLT

    # Floating point formatters.
    # NOTE THAT 'BYTES' FIELD IS SET TO ZERO
    # ON DLB because 8 bytes overflows the bitfield
    XYZ_DBL = TYPE_XYZ_DBL
    Lab_DBL = TYPE_Lab_DBL
    GRAY_DBL = TYPE_GRAY_DBL
    RGB_DBL = TYPE_RGB_DBL
    BGR_DBL = TYPE_BGR_DBL
    CMYK_DBL = TYPE_CMYK_DBL

    # IEEE 754-2008 "half"
    GRAY_HALF_FLT = TYPE_GRAY_HALF_FLT
    RGB_HALF_FLT = TYPE_RGB_HALF_FLT
    RGBA_HALF_FLT = TYPE_RGBA_HALF_FLT
    CMYK_HALF_FLT = TYPE_CMYK_HALF_FLT
    ARGB_HALF_FLT = TYPE_ARGB_HALF_FLT
    BGR_HALF_FLT = TYPE_BGR_HALF_FLT
    BGRA_HALF_FLT = TYPE_BGRA_HALF_FLT
    ABGR_HALF_FLT = TYPE_ABGR_HALF_FLT
