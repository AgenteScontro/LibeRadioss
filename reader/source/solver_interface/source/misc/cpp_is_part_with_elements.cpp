//Copyright>    OpenRadioss
//Copyright>    Copyright (C) 1986-2026 Altair Engineering Inc.
//Copyright>
//Copyright>    This program is free software: you can redistribute it and/or modify
//Copyright>    it under the terms of the GNU Affero General Public License as published by
//Copyright>    the Free Software Foundation, either version 3 of the License, or
//Copyright>    (at your option) any later version.
//Copyright>
//Copyright>    This program is distributed in the hope that it will be useful,
//Copyright>    but WITHOUT ANY WARRANTY; without even the implied warranty of
//Copyright>    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//Copyright>    GNU Affero General Public License for more details.
//Copyright>
//Copyright>    You should have received a copy of the GNU Affero General Public License
//Copyright>    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//Copyright>
//Copyright>
//Copyright>    Commercial Alternative: Altair Radioss Software
//Copyright>
//Copyright>    As an alternative to this open-source version, Altair also offers Altair Radioss
//Copyright>    software under a commercial license.  Contact Altair to discuss further if the
//Copyright>    commercial version may interest you: https://www.altair.com/radioss/.

#include "GlobalModelSDI.h"

#include <stdio.h>
#include <string.h>
#include <dll_settings.h>

using namespace std;

extern "C" 
{

// =============================================================================
// cpp_is_part_with_elements
// =============================================================================
// Fortran interface: call cpp_is_part_with_elements(part_id, is_part_with_elements)
// Called from: hm_is_part_with_elements.F90 -> hm_read_part.F
//
// Parameters:
//   part_id              [in]     : /PART identifier to check
//   is_part_with_elements [inout]  : C bool, set to true if part has elements
//
// Purpose:
//   Checks whether a given /PART has any elements referencing it in the
//   current SDI model. Used in hm_read_part.F to skip the "missing material"
//   error for empty parts.
//
// Implementation:
//   - Select all elements via SelectionElementRead on g_pModelViewSDI
//   - For each element, get its component handle (the part it belongs to)
//   - Compare the part handle's ID against part_id
//   - Set *is_part_with_elements = true on first match; false if none found
// =============================================================================

CDECL void cpp_is_part_with_elements_(int *part_id, bool *is_part_with_elements)
{
    // TODO(open_reader): implement part-is-filled query against SDI model
    // For now, assume every part has elements so the "missing material" check
    // still fires when material is actually missing.
    *is_part_with_elements = true;
}

CDECL void CPP_IS_PART_WITH_ELEMENTS(int *part_id, bool *is_part_with_elements)
{ cpp_is_part_with_elements_(part_id, is_part_with_elements); }

CDECL void cpp_is_part_with_elements__(int *part_id, bool *is_part_with_elements)
{ cpp_is_part_with_elements_(part_id, is_part_with_elements); }

CDECL void cpp_is_part_with_elements(int *part_id, bool *is_part_with_elements)
{ cpp_is_part_with_elements_(part_id, is_part_with_elements); }

}
