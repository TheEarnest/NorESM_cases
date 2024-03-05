#! /bin/csh -f 

set exedir = $RUNDIR; cd $exedir

cat >! ice_in << EOF
&setup_nml
 diagfreq		=  24   
 hist_avg		= .true.  
 histfreq		= 'm','x','x','x','x'
 histfreq_n		= 1,1,1,1,1           
 ice_ic		= 'N1850AERCNOC_f19_g16_CMIP6forcings_15.cice.r.0051-01-01-00000.nc'
 lcdf64		= .true. 
 pointer_file		= 'rpointer.ice'
 xndt_dyn		=  1.0 
/
&grid_nml
 grid_file		= '$DIN_LOC_ROOT/ocn/pop/gx1v6/grid/horiz_grid_20010402.ieeer8'
 grid_format		= 'bin'
 grid_type		= 'displaced_pole'
 kcatbound		=  0 
 kmt_file		= '$DIN_LOC_ROOT/ocn/pop/gx1v6/grid/topography_20090204.ieeei4'
/
&ice_nml
 advection		= 'remap'
 albedo_type		= 'default'
 albicei		= 0.45
 albicev		= 0.75
 albsnowi		= 0.73
 albsnowv		= 0.98
 dt_mlt_in		=  2.00 
 evp_damping		= .false.
 kdyn		=  1 
 kitd		=  1 
 krdg_partic		= 1
 krdg_redist		= 1
 kstrength		=  1 
 ndte		=  120 
 r_snw		= -2.0
 rsnw_melt_in		=  2000. 
 shortwave		= 'dEdd'
 update_ocn_f		= .true.
/
&tracer_nml
 tr_aero		=  .true. 
 tr_fy		=  .true. 
 tr_iage		=  .true. 
 tr_pond		=  .true. 
/
&domain_nml
 distribution_type		= '$CICE_DECOMPTYPE'
 ew_boundary_type		= 'cyclic'
 ns_boundary_type		= 'open'
 processor_shape		= 'square-pop'
/
&ice_prescribed_nml
 prescribed_ice		= .false.
/
&icefields_nml
 f_aero		= 'xxxxx'
 f_aice		= 'mxxxx'
 f_aicen		= 'mxxxx'
 f_aisnap		= 'mxxxx'
 f_albice		= 'mxxxx'
 f_albpnd		= 'xxxxx'
 f_albsno		= 'mxxxx'
 f_alidf		= 'xxxxx'
 f_alidr		= 'xxxxx'
 f_alvdf		= 'xxxxx'
 f_alvdr		= 'xxxxx'
 f_alvl		= 'xxxxx'
 f_anglet		= false
 f_apondn		= 'xxxxx'
 f_ardg		= 'xxxxx'
 f_bounds		= false
 f_congel		= 'mxxxx'
 f_daidtd		= 'mxxxx'
 f_daidtt		= 'mxxxx'
 f_dardg1dt		= 'xxxxx'
 f_dardg2dt		= 'xxxxx'
 f_divu		= 'xxxxx'
 f_dvidtd		= 'mxxxx'
 f_dvidtt		= 'mxxxx'
 f_dvirdgdt		= 'xxxxx'
 f_dxt		= false
 f_dxu		= false
 f_dyt		= false
 f_dyu		= false
 f_evap		= 'xxxxx'
 f_evap_ai		= 'xxxxx'
 f_faero_atm		= 'xxxxx'
 f_faero_ocn		= 'xxxxx'
 f_fcondtop_ai		= 'xxxxx'
 f_fhocn		= 'xxxxx'
 f_fhocn_ai		= 'mxxxx'
 f_flat		= 'xxxxx'
 f_flat_ai		= 'mxxxx'
 f_flwdn		= 'xxxxx'
 f_flwdn_ai		= 'xxxxx'
 f_flwup		= 'xxxxx'
 f_flwup_ai		= 'xxxxx'
 f_frazil		= 'mxxxx'
 f_fresh		= 'xxxxx'
 f_fresh_ai		= 'mxxxx'
 f_frz_onset		= 'xxxxx'
 f_frzmlt		= 'xxxxx'
 f_fsalt		= 'xxxxx'
 f_fsalt_ai		= 'mxxxx'
 f_fsens		= 'xxxxx'
 f_fsens_ai		= 'mxxxx'
 f_fsurf_ai		= 'xxxxx'
 f_fswabs		= 'xxxxx'
 f_fswabs_ai		= 'xxxxx'
 f_fswdn		= 'xxxxx'
 f_fswdn_ai		= 'xxxxx'
 f_fswfac		= 'xxxxx'
 f_fswthru		= 'xxxxx'
 f_fswthru_ai		= 'xxxxx'
 f_fswup		= 'xxxxx'
 f_fswup_ai		= 'xxxxx'
 f_fy		= 'xxxxx'
 f_hisnap		= 'mxxxx'
 f_hte		= false
 f_htn		= false
 f_iage		= 'mxxxx'
 f_icepresent		= 'xxxxx'
 f_meltb		= 'mxxxx'
 f_meltl		= 'mxxxx'
 f_melts		= 'mxxxx'
 f_meltt		= 'mxxxx'
 f_mlt_onset		= 'xxxxx'
 f_opening		= 'mxxxx'
 f_qi		= 'xxxxx'
 f_qref		= 'xxxxx'
 f_qs		= 'xxxxx'
 f_rain		= 'xxxxx'
 f_rain_ai		= 'mxxxx'
 f_shear		= 'xxxxx'
 f_sig1		= 'xxxxx'
 f_sig2		= 'xxxxx'
 f_snoice		= 'mxxxx'
 f_snow		= 'xxxxx'
 f_snow_ai		= 'mxxxx'
 f_sss		= 'xxxxx'
 f_sst		= 'xxxxx'
 f_strairx		= 'xxxxx'
 f_strairy		= 'xxxxx'
 f_strcorx		= 'xxxxx'
 f_strcory		= 'xxxxx'
 f_strength		= 'xxxxx'
 f_strintx		= 'xxxxx'
 f_strinty		= 'xxxxx'
 f_strocnx		= 'xxxxx'
 f_strocny		= 'xxxxx'
 f_strtltx		= 'xxxxx'
 f_strtlty		= 'xxxxx'
 f_tair		= 'xxxxx'
 f_tmask		= false
 f_tref		= 'xxxxx'
 f_trsig		= 'xxxxx'
 f_tsfc		= 'mxxxx'
 f_uarea		= false
 f_uocn		= 'xxxxx'
 f_uvel		= 'mxxxx'
 f_vicen		= 'mxxxx'
 f_vlvl		= 'xxxxx'
 f_vocn		= 'xxxxx'
 f_vrdg		= 'xxxxx'
 f_vvel		= 'mxxxx'
/
EOF
