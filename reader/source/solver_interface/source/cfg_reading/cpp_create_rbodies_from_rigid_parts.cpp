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
// cpp_create_rbodies_from_rigid_parts
// =============================================================================
// Fortran interface:
//   call cpp_create_rbodies_from_rigid_parts(NEW_RBODY_TO_PART, NEW_RBODY_ID)
// Called from: hm_create_rbodies_from_rigid_parts.F90 -> starter0.F
//
// Parameters:
//   NEW_RBODY_TO_PART [out] : int array, size NB_NEWRBODIES (sum of
//                             NBRBODIES_PER_PART from the evaluate step).
//                             Entry i receives the /PART ID that the
//                             newly-created /RBODY belongs to.
//   NEW_RBODY_ID      [out] : int array, size NB_NEWRBODIES.
//                             Entry i receives the ID of the newly-created
//                             /RBODY entity.
//
// Purpose:
//   For each /PART flagged with Irigid (as previously counted by
//   cpp_evaluate_rbodies_number_from_rigid_parts), creates a corresponding
//   /RBODY entity in the SDI model and records the mapping between part IDs
//   and the new rigid body IDs.
//
// Implementation:
//   - Open a selection on /PART via g_pModelViewSDI
//   - For each part, read Irigid:
//       if Irigid != 0:
//         - Create a new /RBODY entity
//         - Assign its attributes (link to part's nodes/elements, set
//           dependent/independent node IDs, etc.)
//         - Record: NEW_RBODY_TO_PART[i] = part_id
//         - Record: NEW_RBODY_ID[i]      = new_rbody_id
// =============================================================================

CDECL void cpp_create_rbodies_from_rigid_parts_(int *NEW_RBODY_TO_PART, int *NEW_RBODY_ID)
{
    // TODO(open_reader): iterate /PART selection, for each part with Irigid
    // set, create a /RBODY entity via g_pModelViewSDI->CreateEntity.
    // Fill NEW_RBODY_TO_PART and NEW_RBODY_ID arrays accordingly.
    // For now: no-op (arrays left uninitialized; caller only enters this
    // code path when NB_NEWRBODIES > 0, which won't happen since the
    // evaluate step currently returns all zeros).
}

CDECL void CPP_CREATE_RBODIES_FROM_RIGID_PARTS(int *NEW_RBODY_TO_PART, int *NEW_RBODY_ID)
{ cpp_create_rbodies_from_rigid_parts_(NEW_RBODY_TO_PART, NEW_RBODY_ID); }

CDECL void cpp_create_rbodies_from_rigid_parts__(int *NEW_RBODY_TO_PART, int *NEW_RBODY_ID)
{ cpp_create_rbodies_from_rigid_parts_(NEW_RBODY_TO_PART, NEW_RBODY_ID); }

CDECL void cpp_create_rbodies_from_rigid_parts(int *NEW_RBODY_TO_PART, int *NEW_RBODY_ID)
{ cpp_create_rbodies_from_rigid_parts_(NEW_RBODY_TO_PART, NEW_RBODY_ID); }

}
