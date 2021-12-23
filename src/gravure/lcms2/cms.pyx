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
from enum import Enum, IntEnum, IntFlag, unique
import cython
cimport cython


from gravure.lcms2.tags import Tag, TagEnum
from gravure.lcms2.constant cimport *
from gravure.lcms2.icctag cimport *
import gravure.lcms2._errors as _errors
from gravure.lcms2._errors import UndefinedError, FileError, RangeError, InternalError, NullError, ReadError, SeekError, WriteError, UnknownExtensionError, ColorSpaceCheckError, AlreadyDefinedError, BadSignatureError, CorruptionDetectedError, NotSuitableError
from gravure.lcms2._errors import _init_logger
from gravure.lcms2.profile import DeviceAttribute, Profile


include "constant.pxi"
include "colortype.pxi"
include "icctag.pxi"


__constants__ = ['VERSION', 'D50X', 'D50Y', 'D50Z',
                 'PERCEPTUAL_BLACK_X', 'PERCEPTUAL_BLACK_Y',
                 'PERCEPTUAL_BLACK_Z', 'MAXCHANNELS']

__enums__ = [# From 'colortype.pxi'
             'COLORTYPE',
             # From 'icctag.pxi'
             'ICCDef', 'TagTypeSignature', 'TagSignature',
             'TechnologySignature', 'ColorSpaceSignature',
             'ProfileClassSignature', 'PlatformSignature', 'Referencegamut',
             'ColorimetricIntentImageStateTag', 'StageSignature',
             'CurveSegSignature', 'ResponseCurveTypeSignature',
             # From 'profile.pyx'
             'DeviceAttribute'
             ]

__classes__ = ['Tag', 'TagEnum', 'Profile']

__all__ = __constants__ + __enums__ + __classes__ + _errors.__all__

_init_logger()
