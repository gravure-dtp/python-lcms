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
from gravure.lcms2.enum import TagEnum

import cython
cimport cython

from icctag cimport *
from errors import LcmsError
from profile import DeviceAttribute
from profile cimport *

include "constant.pxi"
include "colortype.pxi"
include "icctag.pxi"


__all__ = [
            # From 'constant.pxi'
            'VERSION',
            'D50X', 'D50Y', 'D50Z',
            'PERCEPTUAL_BLACK_X', 'PERCEPTUAL_BLACK_Y', 'PERCEPTUAL_BLACK_Z',
            'MAXCHANNELS'
            # From 'colortype.pxi'
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
