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
#include <typedef.h>
#include <sdiModelView.h>

using namespace sdi;
using namespace std;

extern "C" 
{

// =============================================================================
// cpp_evaluate_rbodies_number_from_rigid_parts
// =============================================================================
// Fortran interface: call cpp_evaluate_rbodies_number_from_rigid_parts(NBRBODIES_PER_PART)
// Called from: hm_evaluate_rbodies_from_rigid_parts.F90 -> starter0.F
//
// Parameters:
//   NBRBODIES_PER_PART [out] : int array, size NPART (determined by caller via
//                              hm_option_count('/PART')). Index position i
//                              corresponds to the i-th /PART in selection order.
//                              Each entry set to the number of /RBODY entities
//                              that must be created for that part (0 or 1).
//
// Purpose:
//   Scans all /PART entities for those with the Irigid flag set, and records
//   how many rigid bodies each such part requires. The caller sums these to
//   allocate arrays for the subsequent cpp_create_rbodies_from_rigid_parts call.
//
// Implementation:
//   - Open a selection on /PART via g_pModelViewSDI
//   - For each part, read the "Irigid" attribute
//   - If Irigid != 0, set NBRBODIES_PER_PART[pos] = 1
//   - Otherwise set NBRBODIES_PER_PART[pos] = 0
// =============================================================================

CDECL void cpp_evaluate_rbodies_number_from_rigid_parts(int *NBRBODIES_PER_PART)
{
    // Walk the /PART selection in the same order HM_OPTION_COUNT('/PART') uses
    // on the caller side (starter0.F), so index i here matches part i there.
    // A part flagged IRIGID==1 needs exactly one auto-generated /RBODY.
    SelectionRead parts(g_pModelViewSDI, "/PART");
    int i = 0;
    while (parts.Next())
    {
        int irigid = 0;
        sdiValue value;
        if (parts->GetValue(sdiIdentifier("IRIGID"), value)) value.GetValue(irigid);
        NBRBODIES_PER_PART[i] = (irigid == 1) ? 1 : 0;
        ++i;
    }
}


}
