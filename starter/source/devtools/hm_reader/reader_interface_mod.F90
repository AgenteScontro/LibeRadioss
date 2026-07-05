!Copyright>        OpenRadioss
!Copyright>        Copyright (C) 1986-2026 Altair Engineering Inc.
!Copyright>
!Copyright>        This program is free software: you can redistribute it and/or modify
!Copyright>        it under the terms of the GNU Affero General Public License as published by
!Copyright>        the Free Software Foundation, either version 3 of the License, or
!Copyright>        (at your option) any later version.
!Copyright>
!Copyright>        This program is distributed in the hope that it will be useful,
!Copyright>        but WITHOUT ANY WARRANTY; without even the implied warranty of
!Copyright>        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!Copyright>        GNU Affero General Public License for more details.
!Copyright>
!Copyright>        You should have received a copy of the GNU Affero General Public License
!Copyright>        along with this program.  If not, see <https://www.gnu.org/licenses/>.
!Copyright>
!Copyright>
!Copyright>        Commercial Alternative: Altair Radioss Software
!Copyright>
!Copyright>        As an alternative to this open-source version, Altair also offers Altair Radioss
!Copyright>        software under a commercial license.  Contact Altair to discuss further if the
!Copyright>        commercial version may interest you: https://www.altair.com/radioss/.
!=======================================================================
! READER_INTERFACE_MOD: explicit ISO_C_BINDING interfaces to the reader
! (libopen_reader) C++ entry points in reader/source/solver_interface.
! One bind(C) interface per entry point; the C++ side defines each symbol
! exactly once, without per-compiler name-mangling variants.
!=======================================================================
      MODULE READER_INTERFACE_MOD
        USE, INTRINSIC :: ISO_C_BINDING, ONLY : C_INT, C_DOUBLE, C_BOOL, C_CHAR
        IMPLICIT NONE

        INTERFACE

          SUBROUTINE CPP_BEAM_READ(IXP, NIXP, IPARTP, SUBID_BEAM, VX, VY, VZ) &
     &      BIND(C, NAME="cpp_beam_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXP
            INTEGER(C_INT) :: NIXP
            INTEGER(C_INT), DIMENSION(*) :: IPARTP
            INTEGER(C_INT), DIMENSION(*) :: SUBID_BEAM
            REAL(C_DOUBLE), DIMENSION(*) :: VX
            REAL(C_DOUBLE), DIMENSION(*) :: VY
            REAL(C_DOUBLE), DIMENSION(*) :: VZ
          END SUBROUTINE CPP_BEAM_READ

          SUBROUTINE CPP_BRICK20_READ(IXS, NIXS, IXS20, NIXS20, NUMBRICK, IPARTS, SUBID_SOL) &
     &      BIND(C, NAME="cpp_brick20_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXS
            INTEGER(C_INT) :: NIXS
            INTEGER(C_INT), DIMENSION(*) :: IXS20
            INTEGER(C_INT) :: NIXS20
            INTEGER(C_INT) :: NUMBRICK
            INTEGER(C_INT), DIMENSION(*) :: IPARTS
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SOL
          END SUBROUTINE CPP_BRICK20_READ

          SUBROUTINE CPP_BRICK_READ(IXS, NIXS, IPARTS, SUBID_SOL) BIND(C, NAME="cpp_brick_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXS
            INTEGER(C_INT) :: NIXS
            INTEGER(C_INT), DIMENSION(*) :: IPARTS
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SOL
          END SUBROUTINE CPP_BRICK_READ

          SUBROUTINE CPP_BUILD_MODEL_INC(name, size, res, nbDynaIncludes, GLOBAL_PATH, &
     &      SGLOBAL_PATH) BIND(C, NAME="cpp_build_model_inc")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: name
            INTEGER(C_INT) :: size
            INTEGER(C_INT) :: res
            INTEGER(C_INT) :: nbDynaIncludes
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: GLOBAL_PATH
            INTEGER(C_INT) :: SGLOBAL_PATH
          END SUBROUTINE CPP_BUILD_MODEL_INC

          SUBROUTINE CPP_CNODE_READ(ITAB, X, CMERGE, SUBID_NOD, UID_NOD) &
     &      BIND(C, NAME="cpp_cnode_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: ITAB
            REAL(C_DOUBLE), DIMENSION(*) :: X
            REAL(C_DOUBLE), DIMENSION(*) :: CMERGE
            INTEGER(C_INT), DIMENSION(*) :: SUBID_NOD
            INTEGER(C_INT), DIMENSION(*) :: UID_NOD
          END SUBROUTINE CPP_CNODE_READ

          SUBROUTINE CPP_CONVERT_2D_ELEMENTS_SEATBELT(PART_MAT119, PART_MAXID, PROP_MAXID, &
     &      MAT_MAXID, ELEM_MAXID, OFFSET, SEATBELT_CONVERTED_ELEMENTS, ELEM_INDEX) &
     &      BIND(C, NAME="cpp_convert_2d_elements_seatbelt")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: PART_MAT119
            INTEGER(C_INT) :: PART_MAXID
            INTEGER(C_INT) :: PROP_MAXID
            INTEGER(C_INT) :: MAT_MAXID
            INTEGER(C_INT) :: ELEM_MAXID
            INTEGER(C_INT) :: OFFSET
            INTEGER(C_INT), DIMENSION(*) :: SEATBELT_CONVERTED_ELEMENTS
            INTEGER(C_INT) :: ELEM_INDEX
          END SUBROUTINE CPP_CONVERT_2D_ELEMENTS_SEATBELT

          SUBROUTINE CPP_CONVERT_FAIL_TAB(TABLE_MAXID, FAIL_MAXID, OFFSET) &
     &      BIND(C, NAME="cpp_convert_fail_tab")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: TABLE_MAXID
            INTEGER(C_INT) :: FAIL_MAXID
            INTEGER(C_INT) :: OFFSET
          END SUBROUTINE CPP_CONVERT_FAIL_TAB

          SUBROUTINE CPP_CONVERT_INTER_TYPE19(INTER_MAXID, GRNOD_MAXID, LINE_MAXID, OFFSET, &
     &      isFirst) BIND(C, NAME="cpp_convert_inter_type19")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: INTER_MAXID
            INTEGER(C_INT) :: GRNOD_MAXID
            INTEGER(C_INT) :: LINE_MAXID
            INTEGER(C_INT) :: OFFSET
            INTEGER(C_INT) :: isFirst
          END SUBROUTINE CPP_CONVERT_INTER_TYPE19

          SUBROUTINE CPP_CONVERT_TETRA4_TO_TETRA10(Itetra4ToConsider) &
     &      BIND(C, NAME="cpp_convert_tetra4_to_tetra10")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: Itetra4ToConsider
          END SUBROUTINE CPP_CONVERT_TETRA4_TO_TETRA10

          SUBROUTINE CPP_CONVERT_TH_2D_ELEMENT_SEATBELT(TH_MAXID, OFFSET, &
     &      SEATBELT_CONVERTED_ELEMENTS, NB_SEATBELT_SHELLS) &
     &      BIND(C, NAME="cpp_convert_th_2d_element_seatbelt")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: TH_MAXID
            INTEGER(C_INT) :: OFFSET
            INTEGER(C_INT), DIMENSION(*) :: SEATBELT_CONVERTED_ELEMENTS
            INTEGER(C_INT) :: NB_SEATBELT_SHELLS
          END SUBROUTINE CPP_CONVERT_TH_2D_ELEMENT_SEATBELT

          SUBROUTINE CPP_COUNT_ELEMENTS_IN_PART(NB_ELEMS) BIND(C, NAME="cpp_count_elements_in_part")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: NB_ELEMS
          END SUBROUTINE CPP_COUNT_ELEMENTS_IN_PART

          SUBROUTINE CPP_CREATE_RBODIES_FROM_RIGID_PARTS(NEW_RBODY_TO_PART, NEW_RBODY_ID) &
     &      BIND(C, NAME="cpp_create_rbodies_from_rigid_parts")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: NEW_RBODY_TO_PART
            INTEGER(C_INT), DIMENSION(*) :: NEW_RBODY_ID
          END SUBROUTINE CPP_CREATE_RBODIES_FROM_RIGID_PARTS

          SUBROUTINE CPP_CURRENT_OPTION(ID, UID, includeId, KEY, SKEY, TITR, STITR) &
     &      BIND(C, NAME="cpp_current_option")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: ID
            INTEGER(C_INT) :: UID
            INTEGER(C_INT) :: includeId
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: KEY
            INTEGER(C_INT) :: SKEY
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: TITR
            INTEGER(C_INT) :: STITR
          END SUBROUTINE CPP_CURRENT_OPTION

          SUBROUTINE CPP_DEBUG_GLOBAL_ENTITY_SDI_WRITE() &
     &      BIND(C, NAME="cpp_debug_global_entity_sdi_write")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
          END SUBROUTINE CPP_DEBUG_GLOBAL_ENTITY_SDI_WRITE

          SUBROUTINE CPP_DEBUG_MODEL_CLOSE_FILE() BIND(C, NAME="cpp_debug_model_close_file")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
          END SUBROUTINE CPP_DEBUG_MODEL_CLOSE_FILE

          SUBROUTINE CPP_DEBUG_MODEL_OPEN_FILE(fileName, s_fileName) &
     &      BIND(C, NAME="cpp_debug_model_open_file")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: fileName
            INTEGER(C_INT) :: s_fileName
          END SUBROUTINE CPP_DEBUG_MODEL_OPEN_FILE

          SUBROUTINE CPP_DELETE_ENTITY() BIND(C, NAME="cpp_delete_entity")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
          END SUBROUTINE CPP_DELETE_ENTITY

          SUBROUTINE CPP_DELETE_MODEL() BIND(C, NAME="cpp_delete_model")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
          END SUBROUTINE CPP_DELETE_MODEL

          SUBROUTINE CPP_ELEM_COUNT(elemType, s_elemType, nbElems, isDyna) &
     &      BIND(C, NAME="cpp_elem_count")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: elemType
            INTEGER(C_INT) :: s_elemType
            INTEGER(C_INT) :: nbElems
            INTEGER(C_INT) :: isDyna
          END SUBROUTINE CPP_ELEM_COUNT

          SUBROUTINE CPP_ELEM_SUB_TAG(elemType, TAGELEMSUB) BIND(C, NAME="cpp_elem_sub_tag")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: elemType
            INTEGER(C_INT), DIMENSION(*) :: TAGELEMSUB
          END SUBROUTINE CPP_ELEM_SUB_TAG

          SUBROUTINE CPP_ENTITY_REFERENCE_NUMBER(attrib_key, s_attrib_key, id, refNumber) &
     &      BIND(C, NAME="cpp_entity_reference_number")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: id
            INTEGER(C_INT) :: refNumber
          END SUBROUTINE CPP_ENTITY_REFERENCE_NUMBER

          SUBROUTINE CPP_EVALUATE_RBODIES_NUMBER_FROM_RIGID_PARTS(NBRBODIES_PER_PART) &
     &      BIND(C, NAME="cpp_evaluate_rbodies_number_from_rigid_parts")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: NBRBODIES_PER_PART
          END SUBROUTINE CPP_EVALUATE_RBODIES_NUMBER_FROM_RIGID_PARTS

          SUBROUTINE CPP_FIND_DYNA_MESS(name, size, id, Option, SOption, ncount, Title, STitle) &
     &      BIND(C, NAME="cpp_find_dyna_mess")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: name
            INTEGER(C_INT) :: size
            INTEGER(C_INT) :: id
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: Option
            INTEGER(C_INT) :: SOption
            INTEGER(C_INT) :: ncount
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: Title
            INTEGER(C_INT) :: STitle
          END SUBROUTINE CPP_FIND_DYNA_MESS

          SUBROUTINE CPP_GET_BOOLV(attrib_key, s_attrib_key, value_bool, AVAILABLE) &
     &      BIND(C, NAME="cpp_get_boolv")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            LOGICAL(C_BOOL) :: value_bool
            LOGICAL(C_BOOL) :: AVAILABLE
          END SUBROUTINE CPP_GET_BOOLV

          SUBROUTINE CPP_GET_FLOAT_ARRAY(attrib_key, s_attrib_key, array_double, AVAILABLE, &
     &      lengthDim, massDim, timeDim, uid, sub_id, index) BIND(C, NAME="cpp_get_float_array")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            REAL(C_DOUBLE), DIMENSION(*) :: array_double
            LOGICAL(C_BOOL) :: AVAILABLE
            REAL(C_DOUBLE) :: lengthDim
            REAL(C_DOUBLE) :: massDim
            REAL(C_DOUBLE) :: timeDim
            INTEGER(C_INT) :: uid
            INTEGER(C_INT) :: sub_id
            INTEGER(C_INT) :: index
          END SUBROUTINE CPP_GET_FLOAT_ARRAY

          SUBROUTINE CPP_GET_FLOATV_2INDEX(attrib_key, s_attrib_key, value_float, index1, &
     &      AVAILABLE, lengthDim, massDim, timeDim, uid, sub_id, index2) &
     &      BIND(C, NAME="cpp_get_floatv_2index")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            REAL(C_DOUBLE) :: value_float
            INTEGER(C_INT) :: index1
            LOGICAL(C_BOOL) :: AVAILABLE
            REAL(C_DOUBLE) :: lengthDim
            REAL(C_DOUBLE) :: massDim
            REAL(C_DOUBLE) :: timeDim
            INTEGER(C_INT) :: uid
            INTEGER(C_INT) :: sub_id
            INTEGER(C_INT) :: index2
          END SUBROUTINE CPP_GET_FLOATV_2INDEX

          SUBROUTINE CPP_GET_FLOATV_FLOATD(attrib_key, s_attrib_key, value_float, AVAILABLE, &
     &      lengthDim, massDim, timeDim, uid, sub_id) BIND(C, NAME="cpp_get_floatv_floatd")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            REAL(C_DOUBLE) :: value_float
            LOGICAL(C_BOOL) :: AVAILABLE
            REAL(C_DOUBLE) :: lengthDim
            REAL(C_DOUBLE) :: massDim
            REAL(C_DOUBLE) :: timeDim
            INTEGER(C_INT) :: uid
            INTEGER(C_INT) :: sub_id
          END SUBROUTINE CPP_GET_FLOATV_FLOATD

          SUBROUTINE CPP_GET_FLOATV_FLOATD_INDEX(attrib_key, s_attrib_key, value_float, &
     &      index, AVAILABLE, lengthDim, massDim, timeDim, uid, sub_id) &
     &      BIND(C, NAME="cpp_get_floatv_floatd_index")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            REAL(C_DOUBLE) :: value_float
            INTEGER(C_INT) :: index
            LOGICAL(C_BOOL) :: AVAILABLE
            REAL(C_DOUBLE) :: lengthDim
            REAL(C_DOUBLE) :: massDim
            REAL(C_DOUBLE) :: timeDim
            INTEGER(C_INT) :: uid
            INTEGER(C_INT) :: sub_id
          END SUBROUTINE CPP_GET_FLOATV_FLOATD_INDEX

          SUBROUTINE CPP_GET_FLOATV_ONLY(attrib_key, s_attrib_key, value_float, AVAILABLE, &
     &      lengthDim, massDim, timeDim) BIND(C, NAME="cpp_get_floatv_only")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            REAL(C_DOUBLE) :: value_float
            LOGICAL(C_BOOL) :: AVAILABLE
            REAL(C_DOUBLE) :: lengthDim
            REAL(C_DOUBLE) :: massDim
            REAL(C_DOUBLE) :: timeDim
          END SUBROUTINE CPP_GET_FLOATV_ONLY

          SUBROUTINE CPP_GET_INTV(attrib_key, s_attrib_key, value_int, sub_id, AVAILABLE, &
     &      valueType) BIND(C, NAME="cpp_get_intv")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: value_int
            INTEGER(C_INT) :: sub_id
            LOGICAL(C_BOOL) :: AVAILABLE
            INTEGER(C_INT) :: valueType
          END SUBROUTINE CPP_GET_INTV

          SUBROUTINE CPP_GET_INTV_2INDEX(attrib_key, s_attrib_key, value_int, index1, sub_id, &
     &      AVAILABLE, valueType, index2) BIND(C, NAME="cpp_get_intv_2index")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: value_int
            INTEGER(C_INT) :: index1
            INTEGER(C_INT) :: sub_id
            LOGICAL(C_BOOL) :: AVAILABLE
            INTEGER(C_INT) :: valueType
            INTEGER(C_INT) :: index2
          END SUBROUTINE CPP_GET_INTV_2INDEX

          SUBROUTINE CPP_GET_INTV_INDEX(attrib_key, s_attrib_key, value_int, index1, sub_id, &
     &      AVAILABLE, valueType) BIND(C, NAME="cpp_get_intv_index")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: value_int
            INTEGER(C_INT) :: index1
            INTEGER(C_INT) :: sub_id
            LOGICAL(C_BOOL) :: AVAILABLE
            INTEGER(C_INT) :: valueType
          END SUBROUTINE CPP_GET_INTV_INDEX

          SUBROUTINE CPP_GET_MESSAGE_DYNA(I, MSG_ID, MSG_TYPE, MSG_DESCR, FILE_NAME, LINE_NB, &
     &      MSG_BLOCK, MSG_LINE) BIND(C, NAME="cpp_get_message_dyna")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: I
            INTEGER(C_INT) :: MSG_ID
            INTEGER(C_INT) :: MSG_TYPE
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: MSG_DESCR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: FILE_NAME
            INTEGER(C_INT) :: LINE_NB
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: MSG_BLOCK
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: MSG_LINE
          END SUBROUTINE CPP_GET_MESSAGE_DYNA

          SUBROUTINE CPP_GET_MESSAGE_NUMBER_DYNA(NBMESSAGES) &
     &      BIND(C, NAME="cpp_get_message_number_dyna")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: NBMESSAGES
          END SUBROUTINE CPP_GET_MESSAGE_NUMBER_DYNA

          SUBROUTINE CPP_GET_MESSAGE_NUMBER_RADIOSS(NBMESSAGES) &
     &      BIND(C, NAME="cpp_get_message_number_radioss")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: NBMESSAGES
          END SUBROUTINE CPP_GET_MESSAGE_NUMBER_RADIOSS

          SUBROUTINE CPP_GET_MESSAGE_RADIOSS(I, MSG_ID, MSG_TYPE, MSG_DESCR, FILE_NAME, &
     &      LINE_NB, MSG_BLOCK, MSG_LINE) BIND(C, NAME="cpp_get_message_radioss")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: I
            INTEGER(C_INT) :: MSG_ID
            INTEGER(C_INT) :: MSG_TYPE
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: MSG_DESCR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: FILE_NAME
            INTEGER(C_INT) :: LINE_NB
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: MSG_BLOCK
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: MSG_LINE
          END SUBROUTINE CPP_GET_MESSAGE_RADIOSS

          SUBROUTINE CPP_GET_STRING(attrib_key, s_attrib_key, value_string, size, AVAILABLE) &
     &      BIND(C, NAME="cpp_get_string")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: value_string
            INTEGER(C_INT) :: size
            LOGICAL(C_BOOL) :: AVAILABLE
          END SUBROUTINE CPP_GET_STRING

          SUBROUTINE CPP_GET_STRING_INDEX(attrib_key, s_attrib_key, value_string, index, &
     &      size, AVAILABLE) BIND(C, NAME="cpp_get_string_index")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: value_string
            INTEGER(C_INT) :: index
            INTEGER(C_INT) :: size
            LOGICAL(C_BOOL) :: AVAILABLE
          END SUBROUTINE CPP_GET_STRING_INDEX

          SUBROUTINE CPP_GET_SUBMODEL_INDEX(includeId) BIND(C, NAME="cpp_get_submodel_index")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: includeId
          END SUBROUTINE CPP_GET_SUBMODEL_INDEX

          SUBROUTINE CPP_GLOBAL_ENTITY_SDI_WRITE(is_dyna) &
     &      BIND(C, NAME="cpp_global_entity_sdi_write")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: is_dyna
          END SUBROUTINE CPP_GLOBAL_ENTITY_SDI_WRITE

          SUBROUTINE CPP_GROUP_IS_USED(attrib_key, s_attrib_key, id, isUsed) &
     &      BIND(C, NAME="cpp_group_is_used")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: id
            LOGICAL(C_BOOL) :: isUsed
          END SUBROUTINE CPP_GROUP_IS_USED

          SUBROUTINE CPP_IS_PART_WITH_ELEMENTS(part_id, is_part_with_elements) &
     &      BIND(C, NAME="cpp_is_part_with_elements")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: part_id
            LOGICAL(C_BOOL) :: is_part_with_elements
          END SUBROUTINE CPP_IS_PART_WITH_ELEMENTS

          SUBROUTINE CPP_MODEL_CLOSE_FILE() BIND(C, NAME="cpp_model_close_file")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
          END SUBROUTINE CPP_MODEL_CLOSE_FILE

          SUBROUTINE CPP_MODEL_OPEN_FILE(fileName, s_fileName) BIND(C, NAME="cpp_model_open_file")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: fileName
            INTEGER(C_INT) :: s_fileName
          END SUBROUTINE CPP_MODEL_OPEN_FILE

          SUBROUTINE CPP_NODE_COUNT(nbNodes) BIND(C, NAME="cpp_node_count")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: nbNodes
          END SUBROUTINE CPP_NODE_COUNT

          SUBROUTINE CPP_NODE_ID_READ(ITAB, SUBID_NOD) BIND(C, NAME="cpp_node_id_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: ITAB
            INTEGER(C_INT), DIMENSION(*) :: SUBID_NOD
          END SUBROUTINE CPP_NODE_ID_READ

          SUBROUTINE CPP_NODE_READ(ITAB, X, W, SUBID_NOD, UID_NOD) BIND(C, NAME="cpp_node_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: ITAB
            REAL(C_DOUBLE), DIMENSION(*) :: X
            REAL(C_DOUBLE) :: W
            INTEGER(C_INT), DIMENSION(*) :: SUBID_NOD
            INTEGER(C_INT), DIMENSION(*) :: UID_NOD
          END SUBROUTINE CPP_NODE_READ

          SUBROUTINE CPP_NODE_SUB_TAG(TAGNODSUB) BIND(C, NAME="cpp_node_sub_tag")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: TAGNODSUB
          END SUBROUTINE CPP_NODE_SUB_TAG

          SUBROUTINE CPP_NODE_SUB_TAG_DYNA(TAGNODSUB, IDNOD) BIND(C, NAME="cpp_node_sub_tag_dyna")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: TAGNODSUB
            INTEGER(C_INT), DIMENSION(*) :: IDNOD
          END SUBROUTINE CPP_NODE_SUB_TAG_DYNA

          SUBROUTINE CPP_NODES_COUNT(nbNodes, nbCnodes) BIND(C, NAME="cpp_nodes_count")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: nbNodes
            INTEGER(C_INT) :: nbCnodes
          END SUBROUTINE CPP_NODES_COUNT

          SUBROUTINE CPP_NODES_READ(ITAB, X, CMERGE, SUBID_NOD, UID_NOD) &
     &      BIND(C, NAME="cpp_nodes_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: ITAB
            REAL(C_DOUBLE), DIMENSION(*) :: X
            REAL(C_DOUBLE), DIMENSION(*) :: CMERGE
            INTEGER(C_INT), DIMENSION(*) :: SUBID_NOD
            INTEGER(C_INT), DIMENSION(*) :: UID_NOD
          END SUBROUTINE CPP_NODES_READ

          SUBROUTINE CPP_OPTION_COUNT(ENTITY_TYPE, S_ENTITY_TYPE, HM_OPTION_NUMBER) &
     &      BIND(C, NAME="cpp_option_count")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: ENTITY_TYPE
            INTEGER(C_INT) :: S_ENTITY_TYPE
            INTEGER(C_INT) :: HM_OPTION_NUMBER
          END SUBROUTINE CPP_OPTION_COUNT

          SUBROUTINE CPP_OPTION_IS_CRYPTED(IS_CRYPTED) BIND(C, NAME="cpp_option_is_crypted")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            LOGICAL(C_BOOL) :: IS_CRYPTED
          END SUBROUTINE CPP_OPTION_IS_CRYPTED

          SUBROUTINE CPP_OPTION_NEXT() BIND(C, NAME="cpp_option_next")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
          END SUBROUTINE CPP_OPTION_NEXT

          SUBROUTINE CPP_OPTION_READ(ID, UID, includeId, KEY, SKEY, TITR, STITR, valueType, &
     &      pos) BIND(C, NAME="cpp_option_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: ID
            INTEGER(C_INT) :: UID
            INTEGER(C_INT) :: includeId
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: KEY
            INTEGER(C_INT) :: SKEY
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: TITR
            INTEGER(C_INT) :: STITR
            INTEGER(C_INT) :: valueType
            INTEGER(C_INT) :: pos
          END SUBROUTINE CPP_OPTION_READ

          SUBROUTINE CPP_OPTION_START(ENTITY_TYPE, S_ENTITY_TYPE) BIND(C, NAME="cpp_option_start")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: ENTITY_TYPE
            INTEGER(C_INT) :: S_ENTITY_TYPE
          END SUBROUTINE CPP_OPTION_START

          SUBROUTINE CPP_OPTION_START_LIST(ENTITY_TYPE, S_ENTITY_TYPE) &
     &      BIND(C, NAME="cpp_option_start_list")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: ENTITY_TYPE
            INTEGER(C_INT) :: S_ENTITY_TYPE
          END SUBROUTINE CPP_OPTION_START_LIST

          SUBROUTINE CPP_PENTA6_READ(IXS, NIXS, NUMBRICK, IPARTS, SUBID_SOL) &
     &      BIND(C, NAME="cpp_penta6_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXS
            INTEGER(C_INT) :: NIXS
            INTEGER(C_INT) :: NUMBRICK
            INTEGER(C_INT), DIMENSION(*) :: IPARTS
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SOL
          END SUBROUTINE CPP_PENTA6_READ

          SUBROUTINE CPP_PRINT_DYNA(name, size) BIND(C, NAME="cpp_print_dyna")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: name
            INTEGER(C_INT) :: size
          END SUBROUTINE CPP_PRINT_DYNA

          SUBROUTINE CPP_PRINT_PARAMETERS(name, size) BIND(C, NAME="cpp_print_parameters")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: name
            INTEGER(C_INT) :: size
          END SUBROUTINE CPP_PRINT_PARAMETERS

          SUBROUTINE CPP_QUAD_READ(IXQ, NIXQ, IPARTC, SUBID_SHELL, UID_SHELL) &
     &      BIND(C, NAME="cpp_quad_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXQ
            INTEGER(C_INT) :: NIXQ
            INTEGER(C_INT), DIMENSION(*) :: IPARTC
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SHELL
            INTEGER(C_INT), DIMENSION(*) :: UID_SHELL
          END SUBROUTINE CPP_QUAD_READ

          SUBROUTINE CPP_READ_DYNA_AND_CONVERT(name, size, res, name1, size1) &
     &      BIND(C, NAME="cpp_read_dyna_and_convert")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: name
            INTEGER(C_INT) :: size
            INTEGER(C_INT) :: res
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: name1
            INTEGER(C_INT) :: size1
          END SUBROUTINE CPP_READ_DYNA_AND_CONVERT

          SUBROUTINE CPP_RIVET_READ(IXRI, NIXRI, IPARTRI, SUBID_RIVET) &
     &      BIND(C, NAME="cpp_rivet_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXRI
            INTEGER(C_INT) :: NIXRI
            INTEGER(C_INT), DIMENSION(*) :: IPARTRI
            INTEGER(C_INT), DIMENSION(*) :: SUBID_RIVET
          END SUBROUTINE CPP_RIVET_READ

          SUBROUTINE CPP_SALE_MESH_CREATE(message_value) BIND(C, NAME="cpp_sale_mesh_create")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: message_value
          END SUBROUTINE CPP_SALE_MESH_CREATE

          SUBROUTINE CPP_SELECT_OPTION_BY_NAME(ENTITY_TYPE, S_ENTITY_TYPE, attrib_key, &
     &      s_attrib_key, subIndex) BIND(C, NAME="cpp_select_option_by_name")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: ENTITY_TYPE
            INTEGER(C_INT) :: S_ENTITY_TYPE
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: subIndex
          END SUBROUTINE CPP_SELECT_OPTION_BY_NAME

          SUBROUTINE CPP_SET_FLOATV(attrib_key, s_attrib_key, value_float, AVAILABLE) &
     &      BIND(C, NAME="cpp_set_floatv")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            REAL(C_DOUBLE) :: value_float
            LOGICAL(C_BOOL) :: AVAILABLE
          END SUBROUTINE CPP_SET_FLOATV

          SUBROUTINE CPP_SET_INTV(attrib_key, s_attrib_key, value_int, AVAILABLE) &
     &      BIND(C, NAME="cpp_set_intv")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: attrib_key
            INTEGER(C_INT) :: s_attrib_key
            INTEGER(C_INT) :: value_int
            LOGICAL(C_BOOL) :: AVAILABLE
          END SUBROUTINE CPP_SET_INTV

          SUBROUTINE CPP_SH3N_READ(IXTG, NIXTG, IPARTTG, ANGLE, THK, SUBID_SH3N, UID_SH3N) &
     &      BIND(C, NAME="cpp_sh3n_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXTG
            INTEGER(C_INT) :: NIXTG
            INTEGER(C_INT), DIMENSION(*) :: IPARTTG
            REAL(C_DOUBLE), DIMENSION(*) :: ANGLE
            REAL(C_DOUBLE), DIMENSION(*) :: THK
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SH3N
            INTEGER(C_INT), DIMENSION(*) :: UID_SH3N
          END SUBROUTINE CPP_SH3N_READ

          SUBROUTINE CPP_SHEL16_READ(IXS, NIXS, IXS16, NIXS16, NUMBRICK, IPARTS, SUBID_SOL) &
     &      BIND(C, NAME="cpp_shel16_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXS
            INTEGER(C_INT) :: NIXS
            INTEGER(C_INT), DIMENSION(*) :: IXS16
            INTEGER(C_INT) :: NIXS16
            INTEGER(C_INT) :: NUMBRICK
            INTEGER(C_INT), DIMENSION(*) :: IPARTS
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SOL
          END SUBROUTINE CPP_SHEL16_READ

          SUBROUTINE CPP_SHELL_READ(IXC, NIXC, IPARTC, ANGLE, THK, SUBID_SHELL, UID_SHELL) &
     &      BIND(C, NAME="cpp_shell_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXC
            INTEGER(C_INT) :: NIXC
            INTEGER(C_INT), DIMENSION(*) :: IPARTC
            REAL(C_DOUBLE), DIMENSION(*) :: ANGLE
            REAL(C_DOUBLE), DIMENSION(*) :: THK
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SHELL
            INTEGER(C_INT), DIMENSION(*) :: UID_SHELL
          END SUBROUTINE CPP_SHELL_READ

          SUBROUTINE CPP_SPHCEL_READ(KXSP, NISP, IPARTSP, SUBID_SPH, TYPE, MASS, UID_SPHCEL) &
     &      BIND(C, NAME="cpp_sphcel_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: KXSP
            INTEGER(C_INT) :: NISP
            INTEGER(C_INT), DIMENSION(*) :: IPARTSP
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SPH
            INTEGER(C_INT), DIMENSION(*) :: TYPE
            REAL(C_DOUBLE), DIMENSION(*) :: MASS
            INTEGER(C_INT), DIMENSION(*) :: UID_SPHCEL
          END SUBROUTINE CPP_SPHCEL_READ

          SUBROUTINE CPP_SPRING_READ(IXR, NIXR, IXR_KJ, NIXR_KJ, IPARTR, SUBID_SPRING, SKEWID) &
     &      BIND(C, NAME="cpp_spring_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXR
            INTEGER(C_INT) :: NIXR
            INTEGER(C_INT), DIMENSION(*) :: IXR_KJ
            INTEGER(C_INT) :: NIXR_KJ
            INTEGER(C_INT), DIMENSION(*) :: IPARTR
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SPRING
            INTEGER(C_INT), DIMENSION(*) :: SKEWID
          END SUBROUTINE CPP_SPRING_READ

          SUBROUTINE CPP_SUBMODEL_BUILD(IFATHER, NOSUBMOD, LEVEL, OFFSETS, UID_SUB) &
     &      BIND(C, NAME="cpp_submodel_build")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IFATHER
            INTEGER(C_INT), DIMENSION(*) :: NOSUBMOD
            INTEGER(C_INT), DIMENSION(*) :: LEVEL
            INTEGER(C_INT), DIMENSION(*) :: OFFSETS
            INTEGER(C_INT), DIMENSION(*) :: UID_SUB
          END SUBROUTINE CPP_SUBMODEL_BUILD

          SUBROUTINE CPP_SUBMODEL_COUNT(HM_SUBMODEL_NUMBER, MAXSUBMOD) &
     &      BIND(C, NAME="cpp_submodel_count")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: HM_SUBMODEL_NUMBER
            INTEGER(C_INT) :: MAXSUBMOD
          END SUBROUTINE CPP_SUBMODEL_COUNT

          SUBROUTINE CPP_TETRA10_READ(IXS, NIXS, IXS10, NIXS10, NUMBRICK, IPARTS, SUBID_SOL) &
     &      BIND(C, NAME="cpp_tetra10_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXS
            INTEGER(C_INT) :: NIXS
            INTEGER(C_INT), DIMENSION(*) :: IXS10
            INTEGER(C_INT) :: NIXS10
            INTEGER(C_INT) :: NUMBRICK
            INTEGER(C_INT), DIMENSION(*) :: IPARTS
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SOL
          END SUBROUTINE CPP_TETRA10_READ

          SUBROUTINE CPP_TETRA4_READ(IXS, NIXS, NUMBRICK, IPARTS, SUBID_SOL) &
     &      BIND(C, NAME="cpp_tetra4_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXS
            INTEGER(C_INT) :: NIXS
            INTEGER(C_INT) :: NUMBRICK
            INTEGER(C_INT), DIMENSION(*) :: IPARTS
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SOL
          END SUBROUTINE CPP_TETRA4_READ

          SUBROUTINE CPP_TRIA_READ(IXTG, NIXTG, IPARTTG, SUBID_SH3N, UID_SH3N) &
     &      BIND(C, NAME="cpp_tria_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXTG
            INTEGER(C_INT) :: NIXTG
            INTEGER(C_INT), DIMENSION(*) :: IPARTTG
            INTEGER(C_INT), DIMENSION(*) :: SUBID_SH3N
            INTEGER(C_INT), DIMENSION(*) :: UID_SH3N
          END SUBROUTINE CPP_TRIA_READ

          SUBROUTINE CPP_TRUSS_READ(IXT, NIXT, IPARTR, SUBID_TRUSS) BIND(C, NAME="cpp_truss_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IXT
            INTEGER(C_INT) :: NIXT
            INTEGER(C_INT), DIMENSION(*) :: IPARTR
            INTEGER(C_INT), DIMENSION(*) :: SUBID_TRUSS
          END SUBROUTINE CPP_TRUSS_READ

          SUBROUTINE CPP_XELEM_PREREAD(IDGU, SUBID_XELEM) BIND(C, NAME="cpp_xelem_preread")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IDGU
            INTEGER(C_INT), DIMENSION(*) :: SUBID_XELEM
          END SUBROUTINE CPP_XELEM_PREREAD

          SUBROUTINE CPP_XELEM_READ(IDEX, IDGU, IPARTX, SUB_XELEM) BIND(C, NAME="cpp_xelem_read")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT), DIMENSION(*) :: IDEX
            INTEGER(C_INT), DIMENSION(*) :: IDGU
            INTEGER(C_INT), DIMENSION(*) :: IPARTX
            INTEGER(C_INT), DIMENSION(*) :: SUB_XELEM
          END SUBROUTINE CPP_XELEM_READ

          SUBROUTINE HM_BUILD_ID(build_id, build_id_size, size) BIND(C, NAME="hm_build_id")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            CHARACTER(KIND=C_CHAR), DIMENSION(*) :: build_id
            INTEGER(C_INT) :: build_id_size
            INTEGER(C_INT) :: size
          END SUBROUTINE HM_BUILD_ID

          SUBROUTINE HM_READER_VARIABLES(result, codvers) BIND(C, NAME="hm_reader_variables")
            IMPORT :: C_INT, C_DOUBLE, C_BOOL, C_CHAR
            INTEGER(C_INT) :: result
            INTEGER(C_INT) :: codvers
          END SUBROUTINE HM_READER_VARIABLES

        END INTERFACE
      END MODULE READER_INTERFACE_MOD
