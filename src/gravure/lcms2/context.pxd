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
    # Context handling:
    # Each context holds its owns globals and its own plug-ins.
    # There is a global context with the id = 0 for lecacy compatibility
    # though using the global context is not recommended.
    # Proper context handling makes lcms more thread-safe.
    # typedef struct _cmsContext_struct* cmsContext;
    cdef struct _cmsContext_struct:
        pass
    ctypedef _cmsContext_struct* cmsContext

    # CMSAPI cmsContext       CMSEXPORT cmsCreateContext(void* Plugin, void* UserData);
    # CMSAPI void             CMSEXPORT cmsDeleteContext(cmsContext ContextID);
    # CMSAPI cmsContext       CMSEXPORT cmsDupContext(cmsContext ContextID, void* NewUserData);
    # CMSAPI void*            CMSEXPORT cmsGetContextUserData(cmsContext ContextID);
    #
    # # Plug-In registering  --------------------------------------------------------------------------------------------------
    #
    # CMSAPI cmsBool           CMSEXPORT cmsPlugin(void* Plugin);
    # CMSAPI cmsBool           CMSEXPORT cmsPluginTHR(cmsContext ContextID, void* Plugin);
    # CMSAPI void              CMSEXPORT cmsUnregisterPlugins(void);
    # CMSAPI void              CMSEXPORT cmsUnregisterPluginsTHR(cmsContext ContextID);
