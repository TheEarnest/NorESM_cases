#! /bin/csh -f 

#******************************************************************#
#                  WARNING:                                        #
# - If the user changes any input datasets - be sure to give it a  #
#   unique filename. Do not duplicate any existing input files     #
#******************************************************************#

set exedir = $RUNDIR; cd $exedir

cat >! lnd_in << EOF
&clm_inparm
 co2_type		= 'diagnostic'
 create_crop_landunit		= .false.
 dtime		= 1800
 fatmgrid		= '$DIN_LOC_ROOT/lnd/clm2/griddata/griddata_0.9x1.25_070212.nc'
 fatmlndfrc		= '$DIN_LOC_ROOT/lnd/clm2/griddata/fracdata_0.9x1.25_gx1v6_c090317.nc'
 finidat		= '$DIN_LOC_ROOT/ccsm4_init/b40.1850.track1.1deg.006/0863-01-01/b40.1850.track1.1deg.006.clm2.r.0863-01-01-00000.nc'
 fpftcon		= '$DIN_LOC_ROOT/lnd/clm2/pftdata/pft-physiology.c110425.nc'
 frivinp_rtm		= '$DIN_LOC_ROOT/lnd/clm2/rtmdata/rdirc_0.5x0.5_simyr2000_c101124.nc'
 fsnowaging		= '$DIN_LOC_ROOT/lnd/clm2/snicardata/snicar_drdt_bst_fit_60_c070416.nc'
 fsnowoptics		= '$DIN_LOC_ROOT/lnd/clm2/snicardata/snicar_optics_5bnd_c090915.nc'
 fsurdat		= '$DIN_LOC_ROOT/lnd/clm2/surfdata/surfdata_0.9x1.25_simyr1850_c091006.nc'
 ice_runoff		= .true.
 rtm_nsteps		= 6
 urban_hac		= 'ON_WASTEHEAT'
 urban_traffic		= .false.
/
&ndepdyn_nml
/
#!--------------------------------------------------------------------------------------------------------------------------
#! lnd_in:: Comment:
#! This namelist was created using the following command-line:
#!     /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/models/lnd/clm/bld/build-namelist -config /cluster/home/earnest/models/NorCPM/cases/cesm_me_00010101_mem01/Buildconf/clmconf/config_cache.xml -res 0.9x1.25 -mask gx1v6 -ignore_ic_year -use_case 1850_control -infile cesm_namelist -clm_start_type default -rtm_res R05 -rtm_tstep 10800 -co2_ppmv 284.7 -datm_presaero prognostic -namelist &clm_inparm  / -csmdata $DIN_LOC_ROOT -inputdata /cluster/home/earnest/models/NorCPM/cases/cesm_me_00010101_mem01/Buildconf/clm.input_data_list
#! For help on options use: /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/models/lnd/clm/bld/build-namelist -help
#!--------------------------------------------------------------------------------------------------------------------------

EOF
