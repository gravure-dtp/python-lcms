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
from types cimport *
from context cimport cmsContext

cdef extern from "lcms2.h":
    # There is no error handling at all. When a function fails,
    # it returns proper value. For example, all create functions
    # does return NULL on failure. Other may return FALSE.
    # It may be interesting, for the developer, to know why
    # the function is failing.for that reason, lcms2 does
    # offer a logging function. This function will get
    # an ENGLISH string with some clues on what is going wrong.
    # You can show this info to the end user if you wish,
    # or just create some sort of log on disk.
    # The logging function should NOT terminate the program,
    # as this obviously can leave unfreed resources.
    # It is the programmer's responsibility to check each function
    # return code to make sure it didn't fail.
    enum:
        cmsERROR_UNDEFINED
        cmsERROR_FILE
        cmsERROR_RANGE
        cmsERROR_INTERNAL
        cmsERROR_NULL
        cmsERROR_READ
        cmsERROR_SEEK
        cmsERROR_WRITE
        cmsERROR_UNKNOWN_EXTENSION
        cmsERROR_COLORSPACE_CHECK
        cmsERROR_ALREADY_DEFINED
        cmsERROR_BAD_SIGNATURE
        cmsERROR_CORRUPTION_DETECTED
        cmsERROR_NOT_SUITABLE

    # Error logger is called with the ContextID when a message is raised.
    # This gives the chance to know which thread is responsible of the
    # warning and any environment associated with it.
    # Non-multithreading applications may safely ignore this parameter.
    # Note that under certain special circumstances, ContextID may be NULL.
    ctypedef void  (* cmsLogErrorHandlerFunction)(cmsContext ContextID, cmsUInt32Number ErrorCode, const char *Text)

    # Allows user to set any specific logger
    void cmsSetLogErrorHandler(cmsLogErrorHandlerFunction Fn)
    void cmsSetLogErrorHandlerTHR(cmsContext        ContextID,cmsLogErrorHandlerFunction Fn)
