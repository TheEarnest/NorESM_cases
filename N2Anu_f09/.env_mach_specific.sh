# This file is for user convenience only and is not used by the model
# Changes to this file will be ignored and overwritten
# Changes to the environment should be made in env_mach_specific.xml
# Run ./case.setup --reset to regenerate this file
source /cluster/installations/lmod/lmod/init/sh
module --quiet restore system
module load StdEnv intel/2020a netCDF-Fortran/4.5.2-iompi-2020a iompi/2020a CMake/3.12.1
export KMP_STACKSIZE=64M
export MKL_DEBUG_CPU_TYPE=5
export OMPI_MCA_mpi_leave_pinned=1
export OMPI_MCA_btl=self,vader
export OMPI_MCA_rmaps_rank_file_physical=1
export OMPI_MCA_coll_hcoll_enable=1
export OMPI_MCA_coll=^fca
export OMPI_MCA_coll_hcoll_priority=95
export OMPI_MCA_coll_hcoll_np=8
export HCOLL_MAIN_IB=mlx5_0:1
export HCOLL_ENABLE_MCAST_ALL=1