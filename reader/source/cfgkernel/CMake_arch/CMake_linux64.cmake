# CPP Compiler Flags
# ------------------
set (PRECOM_DEFINITION "-DNDEBUG -DOS_UNIX -DLINUX -DLINUX_PLATFORM -DNO_GZ_LIB -DTXT_MSG -DUNV -DHC_DATA_DLL_EXPORTS -D_64BITS -DUSE_NAMESPACE" )
set (CXX_FLAGS "-Wno-deprecated -fpermissive -DGCC4 -DGCC32 -c -O2 -g -Wall -Wextra -fPIC -Wno-write-strings -frtti -std=c++17 -Wno-format-security -Wno-switch-enum -Wno-deprecated -Wno-enum-compare -m64 -fno-strict-aliasing -traditional-cpp" )

# C Compiler Flags
# --------------
set (C_PRECOM_DEFINITION "-DNO_GZ_LIB -DTXT_MSG -DUNV -DHC_DATA_DLL_EXPORTS -D_64BITS -DLINUX -DOS_UNIX -DUSE_NAMESPACE -DFORTRAN_CALL_C_ -DNDEBUG -DLINUX_PLATFORM" )
set (C_FLAGS "-std=c11 -w -c -O2 -g -Wall -Wextra -fPIC -Wno-write-strings -m64 " )
