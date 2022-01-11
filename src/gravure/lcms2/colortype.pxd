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
    unsigned int FLOAT_SH(int a)
    unsigned int OPTIMIZED_SH(int s)
    unsigned int COLORSPACE_SH(int s)
    unsigned int SWAPFIRST_SH(int s)
    unsigned int FLAVOR_SH(int s)
    unsigned int PLANAR_SH(int p)
    unsigned int ENDIAN16_SH(int e)
    unsigned int DOSWAP_SH(int e)
    unsigned int EXTRA_SH(int e)
    unsigned int CHANNELS_SH(int c)
    unsigned int BYTES_SH(int b)           

    int T_FLOAT(unsigned int a)
    int T_OPTIMIZED(unsigned int o)
    int T_COLORSPACE(unsigned int s)
    int T_SWAPFIRST(unsigned int s)
    int T_FLAVOR(unsigned int s)
    int T_PLANAR(unsigned int p)
    int T_ENDIAN16(unsigned int e)
    int T_DOSWAP(unsigned int e)
    int T_EXTRA(unsigned int e)
    int T_CHANNELS(unsigned int c)
    int T_BYTES(unsigned int b)

    enum:
        # Pixel types
        PT_ANY  # Don't check colorspace
        PT_GRAY
        PT_RGB
        PT_CMY
        PT_CMYK
        PT_YCbCr
        PT_YUV  # Lu'v'
        PT_XYZ
        PT_Lab
        PT_YUVK  # Lu'v'K
        PT_HSV
        PT_HLS
        PT_Yxy
        PT_MCH1
        PT_MCH2
        PT_MCH3
        PT_MCH4
        PT_MCH5
        PT_MCH6
        PT_MCH7
        PT_MCH8
        PT_MCH9
        PT_MCH10
        PT_MCH11
        PT_MCH12
        PT_MCH13
        PT_MCH14
        PT_MCH15
        PT_LabV2  # Identical to PT_Lab, but using the V2 old encoding

    enum:
        # Some (not all!) representations
        TYPE_GRAY_8
        TYPE_GRAY_8_REV
        TYPE_GRAY_16
        TYPE_GRAY_16_REV
        TYPE_GRAY_16_SE
        TYPE_GRAYA_8
        TYPE_GRAYA_16
        TYPE_GRAYA_16_SE
        TYPE_GRAYA_8_PLANAR
        TYPE_GRAYA_16_PLANAR

        TYPE_RGB_8
        TYPE_RGB_8_PLANAR
        TYPE_BGR_8
        TYPE_BGR_8_PLANAR
        TYPE_RGB_16
        TYPE_RGB_16_PLANAR
        TYPE_RGB_16_SE
        TYPE_BGR_16
        TYPE_BGR_16_PLANAR
        TYPE_BGR_16_SE

        TYPE_RGBA_8
        TYPE_RGBA_8_PLANAR
        TYPE_RGBA_16
        TYPE_RGBA_16_PLANAR
        TYPE_RGBA_16_SE

        TYPE_ARGB_8
        TYPE_ARGB_8_PLANAR
        TYPE_ARGB_16

        TYPE_ABGR_8
        TYPE_ABGR_8_PLANAR
        TYPE_ABGR_16
        TYPE_ABGR_16_PLANAR
        TYPE_ABGR_16_SE

        TYPE_BGRA_8
        TYPE_BGRA_8_PLANAR
        TYPE_BGRA_16
        TYPE_BGRA_16_SE

        TYPE_CMY_8
        TYPE_CMY_8_PLANAR
        TYPE_CMY_16
        TYPE_CMY_16_PLANAR
        TYPE_CMY_16_SE

        TYPE_CMYK_8
        TYPE_CMYKA_8
        TYPE_CMYK_8_REV
        TYPE_YUVK_8
        TYPE_CMYK_8_PLANAR
        TYPE_CMYK_16
        TYPE_CMYK_16_REV
        TYPE_YUVK_16
        TYPE_CMYK_16_PLANAR
        TYPE_CMYK_16_SE

        TYPE_KYMC_8
        TYPE_KYMC_16
        TYPE_KYMC_16_SE

        TYPE_KCMY_8
        TYPE_KCMY_8_REV
        TYPE_KCMY_16
        TYPE_KCMY_16_REV
        TYPE_KCMY_16_SE

        TYPE_CMYK5_8
        TYPE_CMYK5_16
        TYPE_CMYK5_16_SE
        TYPE_KYMC5_8
        TYPE_KYMC5_16
        TYPE_KYMC5_16_SE

        TYPE_CMYK6_8
        TYPE_CMYK6_8_PLANAR
        TYPE_CMYK6_16
        TYPE_CMYK6_16_PLANAR
        TYPE_CMYK6_16_SE

        TYPE_CMYK7_8
        TYPE_CMYK7_16
        TYPE_CMYK7_16_SE
        TYPE_KYMC7_8
        TYPE_KYMC7_16
        TYPE_KYMC7_16_SE

        TYPE_CMYK8_8
        TYPE_CMYK8_16
        TYPE_CMYK8_16_SE
        TYPE_KYMC8_8
        TYPE_KYMC8_16
        TYPE_KYMC8_16_SE

        TYPE_CMYK9_8
        TYPE_CMYK9_16
        TYPE_CMYK9_16_SE
        TYPE_KYMC9_8
        TYPE_KYMC9_16
        TYPE_KYMC9_16_SE

        TYPE_CMYK10_8
        TYPE_CMYK10_16
        TYPE_CMYK10_16_SE
        TYPE_KYMC10_8
        TYPE_KYMC10_16
        TYPE_KYMC10_16_SE

        TYPE_CMYK11_8
        TYPE_CMYK11_16
        TYPE_CMYK11_16_SE
        TYPE_KYMC11_8
        TYPE_KYMC11_16
        TYPE_KYMC11_16_SE

        TYPE_CMYK12_8
        TYPE_CMYK12_16
        TYPE_CMYK12_16_SE
        TYPE_KYMC12_8
        TYPE_KYMC12_16
        TYPE_KYMC12_16_SE

        # Colorimetric
        TYPE_XYZ_16
        TYPE_Lab_8
        TYPE_LabV2_8
        TYPE_ALab_8
        TYPE_ALabV2_8
        TYPE_Lab_16
        TYPE_LabV2_16
        TYPE_Yxy_16

        # YCbCr
        TYPE_YCbCr_8
        TYPE_YCbCr_8_PLANAR
        TYPE_YCbCr_16
        TYPE_YCbCr_16_PLANAR
        TYPE_YCbCr_16_SE

        # YUV
        TYPE_YUV_8
        TYPE_YUV_8_PLANAR
        TYPE_YUV_16
        TYPE_YUV_16_PLANAR
        TYPE_YUV_16_SE

        # HLS
        TYPE_HLS_8
        TYPE_HLS_8_PLANAR
        TYPE_HLS_16
        TYPE_HLS_16_PLANAR
        TYPE_HLS_16_SE

        # HSV
        TYPE_HSV_8
        TYPE_HSV_8_PLANAR
        TYPE_HSV_16
        TYPE_HSV_16_PLANAR
        TYPE_HSV_16_SE

        # Named color index.
        # Only 16 bits allowed (don't check colorspace)
        TYPE_NAMED_COLOR_INDEX

        # Float formatters.
        TYPE_XYZ_FLT
        TYPE_Lab_FLT
        TYPE_LabA_FLT
        TYPE_GRAY_FLT
        TYPE_RGB_FLT
        TYPE_RGBA_FLT
        TYPE_ARGB_FLT
        TYPE_BGR_FLT
        TYPE_BGRA_FLT
        TYPE_ABGR_FLT
        TYPE_CMYK_FLT

        # Floating point formatters.
        # NOTE THAT 'BYTES' FIELD IS SET TO ZERO
        # ON DLB because 8 bytes overflows the bitfield
        TYPE_XYZ_DBL
        TYPE_Lab_DBL
        TYPE_GRAY_DBL
        TYPE_RGB_DBL
        TYPE_BGR_DBL
        TYPE_CMYK_DBL

        # IEEE 754-2008 "half"
        TYPE_GRAY_HALF_FLT
        TYPE_RGB_HALF_FLT
        TYPE_RGBA_HALF_FLT
        TYPE_CMYK_HALF_FLT
        TYPE_ARGB_HALF_FLT
        TYPE_BGR_HALF_FLT
        TYPE_BGRA_HALF_FLT
        TYPE_ABGR_HALF_FLT
