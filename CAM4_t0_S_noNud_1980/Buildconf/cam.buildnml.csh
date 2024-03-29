#! /bin/csh -f 

#******************************************************************#
#                  WARNING:                                        #
# - CAM and CLM namelist variable dtime must have same values      #
# - If the user changes any input datasets - be sure to give it a  #
#   unique filename. Do not duplicate any existing input files     #
#******************************************************************#

set exedir = $RUNDIR; cd $exedir

# --- 2d decomp based on at least 3 lons, lat, and levels/pe

@ ntasks   = $NTASKS_ATM
@ nlats    = $ATM_NY
@ maxnpr_z = 26 

set done = 0
@ npr_z = 0
while ($done == "0")
  @ npr_z = $npr_z + 1
  @ npr_y = $ntasks / $npr_z
  @ mydec = $npr_y * $npr_z
  @ nlatppe = $nlats / $npr_y
  if ($mydec == $ntasks && $nlatppe >= 3) set done = 1
  if ($npr_z > $maxnpr_z) set done = 1
end
if ($npr_z > $maxnpr_z) then
  echo "ERROR: number of cam pes/tasks not possible: $ntasks"
  exit 2
endif

cat >! atm_in << EOF
&aerodep_flx_nl
 aerodep_flx_cycle_yr		= 2000
 aerodep_flx_datapath		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/aero'
 aerodep_flx_file		= 'aerosoldep_monthly_1849-2006_1.9x2.5_c090803.nc'
 aerodep_flx_specifier		= 'BCDEPWET', 'BCPHODRY', 'BCPHIDRY', 'OCDEPWET', 'OCPHODRY', 'OCPHIDRY', 'DSTX01DD', 'DSTX02DD',
  'DSTX03DD', 'DSTX04DD', 'DSTX01WD', 'DSTX02WD', 'DSTX03WD', 'DSTX04WD'
 aerodep_flx_type		= 'CYCLICAL'
/
&cam_inparm
 absems_data		= '$DIN_LOC_ROOT/atm/cam/rad/abs_ems_factors_fastvx.c030508.nc'
 bnd_topo		= '$DIN_LOC_ROOT/atm/cam/topo/USGS-gtopo30_1.9x2.5_remap_c050602.nc'
 cam_branch_file		= ' '
 dtime		= 1800
  fexcl1   = 'CLDICE', 'CLDLIQ', 'CONCLD', 'CMFDQ', 'CMFDQR', 'ICLDIWP', 'ICLDTWP', 'CMFDT', 'DCQ', 'DTCOND', 'DTV', 'FICE', 'GCLDLWP', 'QC', 'UU', 'VV', 'VU', 'ICIMR', 'ICWMR', 'VQ', 'OMEGAT', 'QRL', 'QRS', 'RELHUM', 'VT', 'AEROD_v', 'CLOUD', 'CMFMC', 'CMFMCDZM', 'FREQSH', 'FREQZM', 'LANDFRAC', 'LWCF', 'PCONVB', 'PCONVT', 'PRECC', 'PRECCDZM', 'PRECL', 'PRECSC', 'PRECSH', 'PRECSL', 'SFCLDICE', 'SFCLDLIQ', 'SWCF', 'TMQ', 'TREFMNAV', 'TREFMXAV', 'TROP_P', 'TROP_T', 'TROP_Z', 'US', 'VD01', 'VS'
 fincl1   =  'SST', 'Z700', 'Z500', 'Z200', 'Z300', 'Z100', 'Z050', 'U200', 'U850', 'V200', 'V850', 'T200', 'T500', 'T700', 'T1000', 'OMEGA500', 'OMEGA850', 'ICEFRAC', 'U500', 'V500', 'Z500'
 fincl2   = 'U:I', 'V:I', 'T:I', 'Q:I', 'PS:I', 'T500:I', 'U500:I', 'V500:I', 'Z500:I'
 fincl3   = 'U:I', 'V:I', 'T:I', 'Q:I', 'PS:I', 'T500:I', 'U500:I', 'V500:I', 'Z500:I'
 mfilt     = 12,1,1
 nhtfrq    = 0,-6,1
 ncdata		= 'CAM4_t0_S_noNud.cam2.i.1980-01-01-00000.nc'
/
&chem_surfvals_nl
 ch4vmr		= 1760.0e-9
 co2vmr		= 367.0e-6
 f11vmr		= 653.45e-12
 f12vmr		= 535.0e-12
 n2ovmr		= 316.0e-9
/
&circ_diag_nl
 do_circulation_diags		= .false.
/
&cldfrc_nl
 cldfrc_dp1		=  0.10D0 
 cldfrc_dp2		=  500.0D0 
 cldfrc_freeze_dry		= .true.
 cldfrc_ice		= .false.
 cldfrc_premit		=  75000.0D0 
 cldfrc_rhminh		=  0.800D0 
 cldfrc_rhminl		=  0.9005D0 
 cldfrc_sh1		=  0.04D0 
 cldfrc_sh2		=  500.0D0 
/
&cldsed_nl
 cldsed_ice_stokes_fac		=  0.5D0 
/
&cldwat_nl
 cldwat_conke		=   5.0e-6  
 cldwat_icritc		=   9.5e-6  
 cldwat_icritw		=   2.0e-4  
 cldwat_r3lcrit		=   10.0e-6  
/
&dyn_fv_inparm
 del2coef		= 3.e+5
 div24del2flag		=  2
 fft_flt		= 1
 filtcw		= 0
 nspltrac		= 0
 nspltvrm		= 1
/
&gw_drag_nl
 fcrit2		= 1.0
/
&hkconv_nl
 hkconv_c0		=   1.0e-4 
 hkconv_cmftau		=  1800.0D0 
/
&phys_ctl_nl
 cam_chempkg		= 'none'
 cam_physpkg		= 'cam4'
 conv_water_in_rad		=  0 
 deep_scheme		= 'ZM'
 do_iss		=  .false. 
 do_tms		=  .false. 
 eddy_scheme		= 'HB'
 history_microphysics		=  .false. 
 microp_scheme		= 'RK'
 radiation_scheme		= 'camrt'
 shallow_scheme		= 'Hack'
 srf_flux_avg		= 0
 waccmx_opt		= 'off'
/
&prescribed_aero_nl
 prescribed_aero_cycle_yr		= 2000
 prescribed_aero_datapath		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/aero'
 prescribed_aero_file		= 'aero_1.9x2.5_L26_2000clim_c091112.nc'
 prescribed_aero_specifier		= 'sulf:SO4', 'bcar1:CB1', 'bcar2:CB2', 'ocar1:OC1', 'ocar2:OC2', 'sslt1:SSLT01', 'sslt2:SSLT02',
  'sslt3:SSLT03', 'sslt4:SSLT04', 'dust1:DST01', 'dust2:DST02', 'dust3:DST03', 'dust4:DST04'
 prescribed_aero_type		= 'CYCLICAL'
/
&prescribed_ozone_nl
 prescribed_ozone_cycle_yr		= 2000
 prescribed_ozone_datapath		= '$DIN_LOC_ROOT/atm/cam/ozone'
 prescribed_ozone_file		= 'ozone_1.9x2.5_L26_2000clim_c091112.nc'
 prescribed_ozone_name		= 'O3'
 prescribed_ozone_type		= 'CYCLICAL'
/
&rad_cnst_nl
 rad_climate		= 'P_Q:H2O', 'D_O2:O2', 'D_CO2:CO2', 'D_ozone:O3', 'D_N2O:N2O', 'D_CH4:CH4', 'D_CFC11:CFC11',
  'D_CFC12:CFC12', 'D_sulf:$DIN_LOC_ROOT/atm/cam/physprops/sulfate_camrt_c080918.nc',
  'D_dust1:$DIN_LOC_ROOT/atm/cam/physprops/dust1_camrt_c080918.nc',
  'D_dust2:$DIN_LOC_ROOT/atm/cam/physprops/dust2_camrt_c080918.nc',
  'D_dust3:$DIN_LOC_ROOT/atm/cam/physprops/dust3_camrt_c080918.nc',
  'D_dust4:$DIN_LOC_ROOT/atm/cam/physprops/dust4_camrt_c080918.nc',
  'D_bcar1:$DIN_LOC_ROOT/atm/cam/physprops/bcpho_camrt_c080918.nc',
  'D_bcar2:$DIN_LOC_ROOT/atm/cam/physprops/bcphi_camrt_c080918.nc',
  'D_ocar1:$DIN_LOC_ROOT/atm/cam/physprops/ocpho_camrt_c080918.nc',
  'D_ocar2:$DIN_LOC_ROOT/atm/cam/physprops/ocphi_camrt_c080918.nc',
  'D_SSLTA:$DIN_LOC_ROOT/atm/cam/physprops/ssam_camrt_c080918.nc',
  'D_SSLTC:$DIN_LOC_ROOT/atm/cam/physprops/sscm_camrt_c080918.nc'
/
&solar_inparm
 solar_const		= 1361.27
 solar_htng_spctrl_scl		= .false.
/
&spmd_fv_inparm
 npr_yz		= $npr_y,$npr_z,$npr_z,$npr_y
/
&tropopause_nl
 tropopause_climo_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/ub/clim_p_trop.nc'
/
&zmconv_nl
 zmconv_c0_lnd		=  0.0035D0 
 zmconv_c0_ocn		=  0.0035D0 
 zmconv_ke		=  1.0E-6 
/

EOF
