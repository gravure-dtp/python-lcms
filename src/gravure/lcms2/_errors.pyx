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
#       Foundation, Inc., 51 Franklin Street, Fifthfor Floor, Boston,
#       MA 02110-1301, USA.
#

class LcmsError(Exception):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class UndefinedError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class FileError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class RangeError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class InternalError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class NullError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class ReadError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class SeekError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class WriteError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class UnknownExtensionError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class ColorSpaceCheckError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class AlreadyDefinedError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class BadSignatureError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class CorruptionDetectedError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


class NotSuitableError(LcmsError):
    """Base Exception for lcms errors.
    """
    def __init__(self, message):
        self.message = message
        super().__init__(message)


__errors_map = {0: UndefinedError,
               1: FileError,
               2: RangeError,
               3: InternalError,
               4: NullError,
               5: ReadError,
               6: SeekError,
               7: WriteError,
               8: UnknownExtensionError,
               9: ColorSpaceCheckError,
               10: AlreadyDefinedError,
               11: BadSignatureError,
               12: CorruptionDetectedError,
               13: NotSuitableError}

__errors_stack = []

# It is important to note a single function call
# may trigger more than a single error logging entry.
cdef void push_error(int err_code, const char *message) with gil:
    error_cls = __errors_map.get(err_code, UndefinedError)
    __errors_stack.append(error_cls(message.decode('ascii')))

# Python-lcms callback function when errors occured
# If the callback may be called from another non-Python thread,
# care must be taken to initialize the GIL first,
# through a call to PyEval_InitThreads().
# Changed in version 3.7: PyEval_InitThreads() function is now
# called by Py_Initialize(), so you don’t have to call it yourself anymore.
cdef void py_errors_logger(cmsContext ContextID, cmsUInt32Number ErrorCode,
                           const char *Text):
    push_error(ErrorCode, Text)

# TODO: multiple errors logging
def raise_error(object default_error):
    if len(__errors_stack) > 0:
        raise(__errors_stack.pop())
    else:
        raise(default_error)

def errors_count():
    return len(__errors_stack)

def clear_errors_stack():
    __errors_stack = []

def _init_logger():
    cmsSetLogErrorHandler(py_errors_logger)


__all__ =  [__errors_map[e].__name__ for e in __errors_map]
