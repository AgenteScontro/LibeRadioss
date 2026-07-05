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
#include <buildmapping.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <radiossblk.h>
#include <dynamain.h>
#include <dyna2rad/dyna2rad.h>
#include <map>
#include <dll_settings.h>
#include <sdiSelectionObserver.h>


#include <typedef.h>
#include <sdiModelView.h>
#include <exception>
using namespace sdi;
using namespace std;

static void ReportModelBuildException(const char* funcname)
{
    try { throw; }
    catch(const char* msg) { fprintf(stderr, "ERROR: %s failed: %s\n", funcname, msg); }
    catch(const std::exception& e) { fprintf(stderr, "ERROR: %s failed: %s\n", funcname, e.what()); }
    catch(...) { fprintf(stderr, "ERROR: %s failed: unknown exception\n", funcname); }
}


static int cfgreader_inc(char *modelfilename, int *nbDynaIncludes,char *globalPath,int *globalPath_len)
{
        // load deck into the reader
    try
    {
        ModelViewEdit *pModelViewSDI = NULL;
        pModelViewSDI = RadiossblkReadModelSDI(modelfilename);
        //RadiossblkApplyOffsets(pModelViewSDI);

        GlobalModelSDISetModel(pModelViewSDI);
        g_pModelViewSDI = pModelViewSDI;

        if(nullptr == pModelViewSDI)
        {
            fprintf(stderr, "ERROR: cfgreader_inc failed: could not build model from %s\n", modelfilename);
            return 0;
        }

        SelectionRead pSelection(pModelViewSDI, "/INCLUDE_LS-DYNA");

        sdiString dynaIncludeFileName;
        std::vector<sdiString> includeFileNameList;
            
        *nbDynaIncludes = pSelection.Count();

        if (pSelection.Count() > 0)
        {
            printf(" .. READING LS-DYNA INPUT FORMAT MODEL\n");
            while(pSelection.Next())
            {
                sdiString includeFileName;
                sdiValue value(includeFileName);
                pSelection->GetValue(sdiIdentifier("FileName"), value);
                value.GetValue(includeFileName);
                includeFileNameList.push_back(sdiString(globalPath)+includeFileName);
            }

            for(sdiString includeFileName : includeFileNameList)
            {
                ModelViewEdit* pDynaIncludeModelViewSDI = DynakeyReadModel(includeFileName.c_str());

                DynakeyMessages& messages = DynakeyGetMessages();
                messages.SetOffset(200000);

                sdiD2R::DynaToRad d2RObj(pDynaIncludeModelViewSDI, pModelViewSDI, includeFileName, &messages);
                d2RObj.CallConvert();

                sdiConvert::LogQueryHandle g_includeconversionLog;
                d2RObj.GetConversionLog(g_includeconversionLog);
                BuildMapping(g_includeconversionLog,pDynaIncludeModelViewSDI);

                if(pDynaIncludeModelViewSDI != NULL) delete pDynaIncludeModelViewSDI;
            }
        }

    } catch(...) { ReportModelBuildException("cfgreader_inc"); }

    return 0;
}

extern "C" 
{


void CDECL cpp_build_model_inc(char *name, int *size, int *res, int *nbDynaIncludes, char *GLOBAL_PATH, int *SGLOBAL_PATH)
{
    char *cname,*globalPath;
    int cname_len,globalPath_len;
    int i;
    int ret_val;

    cname_len = *size + 1;
    cname=(char*) malloc(sizeof(char)*cname_len);
    for(i=0;i<*size;i++)  cname[i] = name[i];
    cname[*size]='\0'; 

    globalPath_len = *SGLOBAL_PATH+ 1;
    globalPath=(char*) malloc(sizeof(char)*globalPath_len);
#ifdef _WIN64
    strncpy_s(globalPath,globalPath_len,GLOBAL_PATH,*SGLOBAL_PATH);
#else
    strncpy(globalPath,GLOBAL_PATH,*SGLOBAL_PATH);
#endif
    globalPath[*SGLOBAL_PATH]='\0'; 

    *res = cfgreader_inc(cname,nbDynaIncludes,globalPath,&globalPath_len);
}


}
