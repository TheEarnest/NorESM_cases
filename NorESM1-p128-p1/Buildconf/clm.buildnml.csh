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
 finidat		= '$DIN_LOC_ROOT/ccsm4_init/b40.1850.track1.2deg.003/year_401/b40.1850.track1.2deg.003.clm2.r.0401-01-01-00000.nc'
 fpftcon		= '$DIN_LOC_ROOT/lnd/clm2/pftdata/pft-physiology.c110425.nc'
 fpftdyn		= '$DIN_LOC_ROOT/lnd/clm2/surfdata/surfdata.pftdyn_1.9x2.5_rcp8.5_simyr1850-2100_c100322.nc'
 frivinp_rtm		= '$DIN_LOC_ROOT/lnd/clm2/rtmdata/rdirc_0.5x0.5_simyr2000_c101124.nc'
 fsnowaging		= '$DIN_LOC_ROOT/lnd/clm2/snicardata/snicar_drdt_bst_fit_60_c070416.nc'
 fsnowoptics		= '$DIN_LOC_ROOT/lnd/clm2/snicardata/snicar_optics_5bnd_c090915.nc'
 fsurdat		= '$DIN_LOC_ROOT/lnd/clm2/surfdata/surfdata_1.9x2.5_simyr1850_c091108.nc'
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
 model_year_align_ndep		= 1850
 ndepmapalgo		= 'bilinear'
 stream_fldfilename_ndep		= '$DIN_LOC_ROOT/lnd/clm2/ndepdata/fndep_clm_rcp8.5_simyr1849-2106_1.9x2.5_c100428.nc'
 stream_year_first_ndep		= 1850
 stream_year_last_ndep		= 2100
/
#!--------------------------------------------------------------------------------------------------------------------------
#! lnd_in:: Comment:
#! This namelist was created using the following command-line:
#!     /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/models/lnd/clm/bld/build-namelist -config /cluster/home/earnest/models/NorCPM/cases/NorESM1-p128-p1/Buildconf/clmconf/config_cache.xml -res 1.9x2.5 -mask gx1v6 -ignore_ic_year -use_case 1850-2100_rcp8.5_noresm_transient -infile cesm_namelist -clm_start_type default -rtm_res R05 -rtm_tstep 10800 -co2_ppmv 379.000 -datm_presaero prognostic -namelist &clm_inparm  / -csmdata $DIN_LOC_ROOT -inputdata /cluster/home/earnest/models/NorCPM/cases/NorESM1-p128-p1/Buildconf/clm.input_data_list
#! For help on options use: /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/models/lnd/clm/bld/build-namelist -help
#!--------------------------------------------------------------------------------------------------------------------------

EOF