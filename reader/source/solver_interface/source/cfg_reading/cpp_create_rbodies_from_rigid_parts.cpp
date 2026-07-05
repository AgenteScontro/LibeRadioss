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

CDECL void cpp_create_rbodies_from_rigid_parts(int *NEW_RBODY_TO_PART, int *NEW_RBODY_ID)
{
    EntityType radPartType      = g_pModelViewSDI->GetEntityType("/PART");
    EntityType radNodeType      = g_pModelViewSDI->GetEntityType("/NODE");
    EntityType radSkewType      = g_pModelViewSDI->GetEntityType("/SKEW");
    EntityType radSensorType    = g_pModelViewSDI->GetEntityType("/SENSOR");
    EntityType radGrnodPartType = g_pModelViewSDI->GetEntityType("/GRNOD/PART");

    // Allocate new ids past the current maxima of the /RBODY and /GRNOD id
    // pools so the auto-generated entities never collide with user ones.
    unsigned int rbodyMaxId = 0;
    SelectionRead rbodies(g_pModelViewSDI, "/RBODY");
    while (rbodies.Next())
        if (rbodies->GetId() > rbodyMaxId) rbodyMaxId = rbodies->GetId();

    unsigned int grnodMaxId = 0;
    SelectionRead grnods(g_pModelViewSDI, "/GRNOD");
    while (grnods.Next())
        if (grnods->GetId() > grnodMaxId) grnodMaxId = grnods->GetId();

    int newRbodyId = (int)rbodyMaxId;
    int newGrnodId = (int)grnodMaxId;
    int k = 0;

    // Iterate /PART in the same order as the evaluate step, so the rigid
    // parts are visited in exactly the sequence the caller sized the arrays.
    SelectionRead parts(g_pModelViewSDI, "/PART");
    while (parts.Next())
    {
        int irigid = 0;
        sdiValue value;
        if (parts->GetValue(sdiIdentifier("IRIGID"), value)) value.GetValue(irigid);
        if (irigid != 1) continue;

        int partId = parts->GetId();

        // Read the rigid attributes carried on the /PART card (see PART/part.cfg).
        int    nodeId = 0, skewId = 0, sensId = 0;
        double mass = 0.0, jxx = 0.0, jyy = 0.0, jzz = 0.0, jxy = 0.0, jyz = 0.0, jxz = 0.0;
        sdiValueEntity entity;

        sdiValue nodeVal(entity);
        if (parts->GetValue(sdiIdentifier("Node_ID"), nodeVal)) { nodeVal.GetValue(entity); nodeId = (int)entity.GetId(); }
        sdiValue skewVal(entity);
        if (parts->GetValue(sdiIdentifier("Skew_ID"), skewVal)) { skewVal.GetValue(entity); skewId = (int)entity.GetId(); }
        sdiValue sensVal(entity);
        if (parts->GetValue(sdiIdentifier("Sens_ID"), sensVal)) { sensVal.GetValue(entity); sensId = (int)entity.GetId(); }

        sdiValue fv;
        if (parts->GetValue(sdiIdentifier("Mass"), fv)) fv.GetValue(mass);
        if (parts->GetValue(sdiIdentifier("JXX"), fv)) fv.GetValue(jxx);
        if (parts->GetValue(sdiIdentifier("JYY"), fv)) fv.GetValue(jyy);
        if (parts->GetValue(sdiIdentifier("JZZ"), fv)) fv.GetValue(jzz);
        if (parts->GetValue(sdiIdentifier("JXY"), fv)) fv.GetValue(jxy);
        if (parts->GetValue(sdiIdentifier("JYZ"), fv)) fv.GetValue(jyz);
        if (parts->GetValue(sdiIdentifier("JXZ"), fv)) fv.GetValue(jxz);

        // Put the generated entities in the same include as the rigid part.
        HandleRead partInclude = parts->GetInclude();
        g_pModelViewSDI->SetCurrentCollector(partInclude);

        // The rigid body's secondary nodes are all nodes of the part. Emit a
        // /GRNOD/PART group; the starter's group reader (lecggroup -> NODGRNR6)
        // expands it to the part's node list, which HM_READ_RBODY then consumes.
        ++newGrnodId;
        HandleEdit grnodHEdit;
        g_pModelViewSDI->CreateEntity(grnodHEdit, "/GRNOD/PART",
            "Automatically generated node group for rigid /PART " + std::to_string(partId),
            newGrnodId);
        EntityEdit grnodEdit(g_pModelViewSDI, grnodHEdit);
        grnodEdit.SetValue(sdiIdentifier("idsmax"), sdiValue(1));
        grnodEdit.SetValue(sdiIdentifier("ids", 0), sdiValue(sdiValueEntity(radPartType, partId)));

        // Create the /RBODY and fill it from the part's rigid attributes.
        ++newRbodyId;
        HandleEdit rbodyHEdit;
        g_pModelViewSDI->CreateEntity(rbodyHEdit, "/RBODY",
            "Automatically generated /RBODY from rigid /PART " + std::to_string(partId),
            newRbodyId);
        EntityEdit rbodyEdit(g_pModelViewSDI, rbodyHEdit);

        if (nodeId != 0) rbodyEdit.SetValue(sdiIdentifier("independentnode"), sdiValue(sdiValueEntity(radNodeType, nodeId)));
        rbodyEdit.SetValue(sdiIdentifier("dependentnodeset"), sdiValue(sdiValueEntity(radGrnodPartType, newGrnodId)));
        rbodyEdit.SetValue(sdiIdentifier("MASS"), sdiValue(mass));
        rbodyEdit.SetValue(sdiIdentifier("JXX"), sdiValue(jxx));
        rbodyEdit.SetValue(sdiIdentifier("JYY"), sdiValue(jyy));
        rbodyEdit.SetValue(sdiIdentifier("JZZ"), sdiValue(jzz));
        rbodyEdit.SetValue(sdiIdentifier("JXY"), sdiValue(jxy));
        rbodyEdit.SetValue(sdiIdentifier("JYZ"), sdiValue(jyz));
        rbodyEdit.SetValue(sdiIdentifier("JXZ"), sdiValue(jxz));
        if (skewId != 0) rbodyEdit.SetValue(sdiIdentifier("SKEW_CSID"), sdiValue(sdiValueEntity(radSkewType, skewId)));
        if (sensId != 0) rbodyEdit.SetValue(sdiIdentifier("ISENSOR"), sdiValue(sdiValueEntity(radSensorType, sensId)));

        NEW_RBODY_TO_PART[k] = partId;
        NEW_RBODY_ID[k]      = newRbodyId;
        ++k;
    }
}


}
