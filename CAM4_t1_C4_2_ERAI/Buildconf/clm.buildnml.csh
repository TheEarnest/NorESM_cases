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
 fatmgrid		= '$DIN_LOC_ROOT/lnd/clm2/griddata/griddata_1.9x2.5_060404.nc'
 fatmlndfrc		= '$DIN_LOC_ROOT/lnd/clm2/griddata/fracdata_1.9x2.5_gx1v6_c090206.nc'
 finidat		= '$DIN_LOC_ROOT/lnd/clm2/initdata/clmi.BCN.2000-01-01_1.9x2.5_gx1v6_simyr2000_c100309.nc'
 fpftcon		= '$DIN_LOC_ROOT/lnd/clm2/pftdata/pft-physiology.c110425.nc'
 frivinp_rtm		= '$DIN_LOC_ROOT/lnd/clm2/rtmdata/rdirc_0.5x0.5_simyr2000_c101124.nc'
 fsnowaging		= '$DIN_LOC_ROOT/lnd/clm2/snicardata/snicar_drdt_bst_fit_60_c070416.nc'
 fsnowoptics		= '$DIN_LOC_ROOT/lnd/clm2/snicardata/snicar_optics_5bnd_c090915.nc'
 fsurdat		= '$DIN_LOC_ROOT/lnd/clm2/surfdata/surfdata_1.9x2.5_simyr2000_c091005.nc'
 hist_fexcl1		= 'BCDEP', 'BIOGENCO', 'BTRAN', 'BUILDHEAT', 'DSTDEP', 'DSTFLXT', 'EFLX_DYNBAL', 'EFLX_LH_TOT_R', 'EFLX_LH_TOT_U', 'ELAI',
         'ERRH2O', 'ERRSEB', 'ERRSOI', 'ERRSOL', 'ESAI', 'FCEV', 'FCOV', 'FCTR', 'FGEV', 'FGR',
         'FGR12', 'FGR_R', 'FGR_U', 'FIRA', 'FIRA_R', 'FIRA_U', 'FIRE', 'FLDS', 'FLUXFM2A', 'FLUXFMLND',
         'FPSN', 'FSA', 'FSAT', 'FSA_R', 'FSA_U', 'FSDS', 'FSDSND', 'FSDSNDLN', 'FSDSNI', 'FSDSVD',
         'FSDSVDLN', 'FSDSVI', 'FSH', 'FSH_G', 'FSH_NODYNLNDUSE', 'FSH_R', 'FSH_U', 'FSH_V', 'FSM', 'FSM_R',
         'FSM_U', 'FSR', 'FSRND', 'FSRNDLN', 'FSRNI', 'FSRVD', 'FSRVDLN', 'FSRVI', 'GC_HEAT1', 'GC_ICE1',
         'GC_LIQ1', 'H2OCAN', 'H2OSNO', 'H2OSNO_TOP', 'H2OSOI', 'HC', 'HCSOI', 'HEAT_FROM_AC', 'ISOPRENE', 'LAISHA',
         'LAISUN', 'MONOTERP', 'OCDEP', 'ORVOC', 'OVOC', 'PBOT', 'PCO2', 'Q2M', 'QBOT', 'QCHANR',
         'QCHANR_ICE', 'QCHARGE', 'QCHOCNR', 'QCHOCNR_ICE', 'QDRAI', 'QDRIP', 'QFLX_ICE_DYNBAL', 'QFLX_LIQ_DYNBAL', 'QINFL', 'QINTR',
         'QIRRIG', 'QMELT', 'QOVER', 'QRGWL', 'QRUNOFF', 'QRUNOFF_NODYNLNDUSE', 'QRUNOFF_R', 'QRUNOFF_U', 'QSNWCPICE', 'QSNWCPICE_NODYNLNDUSE',
         'QSOIL', 'QVEGE', 'QVEGT', 'RAIN', 'RAINATM', 'RAINFM2A', 'RH2M', 'RH2M_R', 'RH2M_U', 'SABG',
         'SABV', 'SNOBCMCL', 'SNOBCMSL', 'SNODSTMCL', 'SNODSTMSL', 'SNOOCMCL', 'SNOOCMSL', 'SNOW', 'SNOWATM', 'SNOWFM2A',
         'SNOWICE', 'SNOWLIQ', 'SOILICE', 'SOILLIQ', 'SoilAlpha', 'SoilAlpha_U', 'TAUX', 'TAUY', 'TBOT', 'TBUILD',
         'TG', 'TG_R', 'TG_U', 'THBOT', 'TLAI', 'TLAKE', 'TREFMNAV', 'TREFMNAV_R', 'TREFMNAV_U', 'TREFMXAV',
         'TREFMXAV_R', 'TREFMXAV_U', 'TSA', 'TSAI', 'TSA_R', 'TSA_U', 'TSOI', 'TSOI_10CM', 'TV', 'U10',
         'URBAN_AC', 'URBAN_HEAT', 'VOCFLXT', 'VOLR', 'WA', 'WASTEHEAT', 'WIND', 'WT', 'ZBOT', 'ZWT'
 hist_fincl2		= ' '
 hist_mfilt		= 1
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
#!     /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/models/lnd/clm/bld/build-namelist -config /cluster/home/earnest/models/NorCPM/cases/CAM4_t1_C4_2_ERAI/Buildconf/clmconf/config_cache.xml -res 1.9x2.5 -ignore_ic_year -use_case 2000_noresm_control -infile cesm_namelist -clm_start_type default -rtm_res R05 -rtm_tstep 10800 -co2_ppmv 367.0 -datm_presaero prognostic -namelist &clm_inparm  / -csmdata $DIN_LOC_ROOT -inputdata /cluster/home/earnest/models/NorCPM/cases/CAM4_t1_C4_2_ERAI/Buildconf/clm.input_data_list
#! For help on options use: /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/models/lnd/clm/bld/build-namelist -help
#!--------------------------------------------------------------------------------------------------------------------------

EOF
