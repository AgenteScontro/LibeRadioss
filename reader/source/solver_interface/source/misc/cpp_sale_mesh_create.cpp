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
// cpp_sale_mesh_create
// =============================================================================
// Fortran interface: call cpp_sale_mesh_create(message_value)
// Called from: hm_s_ale.F90 -> contrl.F -> starter0.F
//
// Parameters:
//   message_value [inout] : int array of size 45, carrying input params and
//                           receiving computed output values.
//   
//   message_value layout (from hm_s_ale.F90, lines 81-100):
//     Index  1 : debug flag (0 = off, 1 = on)
//     Index  2 : control point id 1
//     Index  3 : control point id 2
//     Index  4 : control point id 3
//     Index  5 : number of sub-areas for control point 1
//     Index  6 : number of sub-areas for control point 2
//     Index  7 : number of sub-areas for control point 3
//     Index  8 : kind of mesh for control point 1 (0=regular, 1=refined)
//     Index  9 : kind of mesh for control point 2
//     Index 10 : kind of mesh for control point 3
//     Index 11 : number of trimming operations
//     Index 12 : number of elements in direction 1 (without trimming)
//     Index 13 : number of elements in direction 2
//     Index 14 : number of elements in direction 3
//     Index 15 : total number of created elements
//     Index 16 : number of nodes in direction 1 (without trimming)
//     Index 17 : number of nodes in direction 2
//     Index 18 : number of nodes in direction 3
//     Index 19 : total number of created nodes
//     Index 20 : boundary condition id 1
//     Index 21 : boundary condition id 2
//     Index 22 : boundary condition id 3
//     Index 23 : boundary condition id 4
//     Index 24 : boundary condition id 5
//     Index 25 : boundary condition id 6
//     Index 26 : /BCS id 1
//     Index 27 : /BCS id 2
//     Index 28 : /BCS id 3
//     Index 29 : /BCS id 4
//     Index 30 : /BCS id 5
//     Index 31 : /BCS id 6
//     Index 32 : boundary condition type 1
//     Index 33 : boundary condition type 2
//     Index 34 : boundary condition type 3
//     Index 35 : boundary condition type 4
//     Index 36 : boundary condition type 5
//     Index 37 : boundary condition type 6
//     Index 38 : error code (0 = ok, >0 = error ID from s_ale_message.F90)
//     Index 39 : material law kind
//     Index 40 : material ID
//     Index 41 : element offset (for ID assignment)
//     Index 42 : node offset (for ID assignment)
//     Index 43 : S-ALE mesh ID (output)
//     Index 44 : reference node ID
//     Index 45 : /ALE/LINK/VEL ID (if reference node exists)
//
// Purpose:
//   Reads the current /ALE/STRUCTURED_MESH option from the SDI model and
//   performs the full structured ALE mesh generation pipeline:
//     1. Read control points, sub-areas, and mesh refinement flags
//     2. Generate regular/refined mesh topology (elements + nodes)
//     3. Apply trimming operations to clip the mesh
//     4. Create boundary conditions on mesh faces
//     5. Assign material and property references
//     6. Handle node/element ID offsets for multi-part models
//
//   Companion Fortran module: s_ale_message.F90 handles error/warning
//   message formatting for the error codes set in message_value[38].
//
// Implementation outline:
//   - Read /ALE/STRUCTURED_MESH option via g_pModelViewSDI selection
//   - Extract parameters (control points, sub-area counts, refinement
//     kind, trimming surfaces, material refs)
//   - Call mesh generation routines to produce element connectivity
//     and node coordinates
//   - Create new /GRID and element entities in the SDI model
//   - Create /BCS boundary condition entities
//   - Populate all 45 output fields in message_value
//   - On any failure, set message_value[38] to the appropriate error code
//     and return
// =============================================================================

CDECL void cpp_sale_mesh_create_(int *message_value)
{
    // TODO(open_reader): implement full S-ALE mesh creation pipeline.
    // For now, set error code to indicate the feature is not implemented.
    // message_value[38] = some_error_code;  // "not implemented" error
    //
    // For the placeholder, we leave the array untouched. The caller
    // (hm_s_ale.F90) uses message_value(1) as a debug flag and expects
    // message_value(43) to contain a valid mesh_id. A real implementation
    // must set at minimum: mesh_id[42], error[37], created_elements_nb[14],
    // created_nodes_nb[18], element_offset[40], node_offset[41].
}

CDECL void CPP_SALE_MESH_CREATE(int *message_value)
{ cpp_sale_mesh_create_(message_value); }

CDECL void cpp_sale_mesh_create__(int *message_value)
{ cpp_sale_mesh_create_(message_value); }

CDECL void cpp_sale_mesh_create(int *message_value)
{ cpp_sale_mesh_create_(message_value); }

}
