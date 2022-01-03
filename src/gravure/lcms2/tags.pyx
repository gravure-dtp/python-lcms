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
from enum import Enum, EnumMeta


class Tag(int):
    def __new__(cls, value):
        if isinstance(value, int):
            if not len(hex(value)) in (9, 10) or value < 0:
                raise ValueError("Tag value hould be a positive integer with a 4 bytes length representation")
        elif isinstance(value, str):
            sign = "{:<4}".format(value[:4])
            value = int.from_bytes(sign.encode(), byteorder="big")
        elif isinstance(value, bytes):
            sign = value[:4]
            for i in range(0, 4 - len(sign)):
                sign += b' '
            value = int.from_bytes(sign, byteorder="big")
        else:
            raise ValueError(f"can't create a Tag from {value}")
        return int.__new__(cls, value)

    def to_bytes(self):
        return super().to_bytes(4, byteorder="big")

    def __repr__(self):
        return f"Tag({self})"

    def __str__(self):
        return hex(self)

    @property
    def signature(self):
        return self.to_bytes().decode()


class TagEnumMeta(EnumMeta):
    def __getitem__(cls, name):
        try:
            ret = super().__getitem__(name)
        except KeyError as ke:
            try:
                ret = cls(Tag(name))
            except ValueError:
                raise (ke)
        return ret


class TagEnum(Tag, Enum, metaclass=TagEnumMeta):
    """Enum where members are also (and must be) gravure.lcms2.tags.Tag object"""
