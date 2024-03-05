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
 aerodep_flx_datapath		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/aero'
 aerodep_flx_file		= 'aerosoldep_monthly_1849-2104_1.9x2.5_c140228.nc'
 aerodep_flx_specifier		= 'BCDEPWET', 'BCPHODRY', 'BCPHIDRY', 'OCDEPWET', 'OCPHODRY', 'OCPHIDRY', 'DSTX01DD', 'DSTX02DD',
  'DSTX03DD', 'DSTX04DD', 'DSTX01WD', 'DSTX02WD', 'DSTX03WD', 'DSTX04WD'
 aerodep_flx_type		= 'INTERP_MISSING_MONTHS'
/
&cam_inparm
 absems_data		= '$DIN_LOC_ROOT/atm/cam/rad/abs_ems_factors_fastvx.c030508.nc'
 bnd_topo		= '$DIN_LOC_ROOT/atm/cam/topo/USGS-gtopo30_1.9x2.5_remap_c050602.nc'
 cam_branch_file		= ' '
 dtime		= 1800
 fexcl1		= 'CLDICE', 'CLDLIQ', 'CONCLD', 'CMFDQ', 'CMFDQR', 'ICLDIWP', 'ICLDTWP', 'CMFDT', 'DCQ', 'DTCOND', 'DTV', 'FICE',
  'GCLDLWP', 'QC', 'UU', 'VV', 'VU', 'US', 'VS', 'ICIMR', 'ICWMR', 'VQ', 'OMEGAT', 'QRL', 'QRS', 'RELHUM', 'VT',
  'AEROD_v', 'BC_A', 'BC_AC', 'BC_AI', 'BC_AX', 'BC_N', 'BC_NI', 'CDNCIX', 'CLDLIX', 'CLOUD', 'CMFMC', 'CMFMCDZM',
  'DMS', 'DST_A2', 'DST_A3', 'FREQSH', 'FREQZM', 'H2O2', 'ICLDTWX', 'ICWMRX', 'LANDFRAC', 'LWCF', 'MSAGA',
  'OM_AC', 'OM_AI', 'OM_NI', 'PCONVB', 'PCONVT', 'PHIS', 'PRECC', 'PRECCDZM', 'PRECL', 'PRECSH', 'S2GA', 'S4AQ',
  'S4GA', 'SFCDNCIX', 'SFCLDICE', 'SFCLDLIQ', 'SFCLDLIX', 'SO2', 'SO4_A1', 'SO4_A2', 'SO4_AC', 'SO4_N',
  'SO4_NA', 'SO4_PR', 'SS_A1', 'SS_A2', 'SS_A3', 'TGCLDIWP', 'TGCLDLWP', 'TGCLDLWX', 'VD01', 'AKCXS', 'ATMEINT',
  'CDNCINT', 'CLDFREE', 'C_BC', 'C_DMS', 'C_DUST', 'C_POM', 'C_SO2', 'C_SO4', 'C_SS', 'DAYFOC', 'DRY_BC',
  'DRY_DUST', 'DRY_POM', 'DRY_SO2', 'DRY_SO4', 'DRY_SS', 'EMI_BC', 'EMI_DMS', 'EMI_DUST', 'EMI_POM',
  'EMI_SO2', 'EMI_SO4', 'EMI_SS', 'WET_BC', 'WET_DUST', 'WET_POM', 'WET_SO2', 'WET_SO4', 'WET_SS', 'BAK', 'BC',
  'CDNC', 'CH2O2', 'CLDFOC', 'DMSCO', 'DUST', 'EVAPX', 'FOCHANA', 'FREEZ', 'GAK', 'KHET', 'NRAINX', 'NUCRAT',
  'NUSO4N', 'N_AER', 'N_AERORG', 'POM', 'REFFL', 'REHANA', 'SELFX', 'SO2CO', 'SO4', 'SS', 'SUPERSAT',
  'TOT_ICLD_VISTAU', 'WAK'
 fincl1		= 'SST', 'Z700', 'Z500', 'Z200', 'Z300', 'Z100', 'Z050', 'U200', 'U850', 'V200', 'V850', 'T200', 'T500', 'T700',
  'T1000', 'OMEGA500', 'OMEGA850', 'ICEFRAC'
 fincl2		= 'TREFHT', 'TREFMXAV', 'TREFMNAV', 'U10', 'U10MXAV', 'PRECT', 'PRECTMX', 'PSL', 'FSDS', 'T850', 'Z500', 'SST',
  'ICEFRAC', 'UAS', 'VAS', 'U850', 'V850', 'Q850', 'U250', 'V250', 'OMEGA850', 'OMEGA500', 'TMQ', 'Z250', 'U500',
  'V500', 'LHFLX', 'SHFLX'
 mfilt		= 1,365
 ncdata		= 'N1850AERCNOC_f19_g16_CMIP6forcings_15.cam2.i.0051-01-01-00000.nc'
 nhtfrq		= 0,-24
/
&chem_inparm
 ext_frc_specifier		= 'SO2    -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_SO2_all_vertical_1849-2015_1.9x2.5_version20180512.nc',
  'SO4_PR -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_SO4_PR_all_vertical_1849-2015_1.9x2.5_version20180512.nc',
  'BC_N -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_BC_N_all_vertical_1849-2015_1.9x2.5_version20180512.nc',
  'BC_AX -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_BC_AX_all_vertical_1849-2015_1.9x2.5_version20180512.nc',
  'BC_NI -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_BC_NI_all_vertical_1849-2015_1.9x2.5_version20180512.nc',
  'OM_NI -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_OM_NI_all_vertical_1849-2015_1.9x2.5_version20180512.nc'
 ext_frc_type		= 'SERIAL'
 srf_emis_specifier		= 'SO2    -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_SO2_all_surface_1849-2015_1.9x2.5_version20180512.nc',
  'SO4_PR   -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_SO4_PR_all_surface_1849-2015_1.9x2.5_version20180512.nc',
  'BC_N     -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_BC_N_all_surface_1849-2015_1.9x2.5_version20180512.nc',
  'BC_AX    -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_BC_AX_all_surface_1849-2015_1.9x2.5_version20180512.nc',
  'OM_NI    -> $DIN_LOC_ROOT/atm/cam/chem/emis/cmip6_emissions_version20180520/noresm_c1.2_noUnlimDim/emissions_cmip6_noresm_c1.2_OM_NI_all_surface_1849-2015_1.9x2.5_version20180512.nc'
 srf_emis_type		= 'SERIAL'
/
&chem_surfvals_nl
 bndtvghg		= '$DIN_LOC_ROOT/atm/cam/ggas/ghg_cmip6_hist_1750-2016_annual_version20180406.nc'
 co2vmr		= 379.000e-6
 scenario_ghg		= 'RAMPED'
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
 cldfrc_rhminl		=  0.9008D0 
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
 prescribed_aero_datapath		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/aero'
 prescribed_aero_file		= 'aero_1.9x2.5_L26_1850-2105_c140228.nc'
 prescribed_aero_specifier		= 'sulf:SO4', 'bcar1:CB1', 'bcar2:CB2', 'ocar1:OC1', 'ocar2:OC2', 'sslt1:SSLT01', 'sslt2:SSLT02',
  'sslt3:SSLT03', 'sslt4:SSLT04', 'dust1:DST01', 'dust2:DST02', 'dust3:DST03', 'dust4:DST04'
 prescribed_aero_type		= 'INTERP_MISSING_MONTHS'
/
&prescribed_ozone_nl
 prescribed_ozone_datapath		= '$DIN_LOC_ROOT/atm/cam/ozone'
 prescribed_ozone_file		= 'vmro3_input4MIPs_ozone_CMIP_UReading-CCMI-1-0_gn_184912-201501_CAM4.nc'
 prescribed_ozone_name		= 'O3'
 prescribed_ozone_type		= 'SERIAL'
/
&prescribed_volcaero_nl
 prescribed_volcaero_datapath		= '$DIN_LOC_ROOT/atm/cam/volc'
 prescribed_volcaero_file		= 'CMIP_CAM6_radiation_v3_reformatted_fixedRecordDim.nc'
 prescribed_volcaero_type		= 'INTERP_MISSING_MONTHS'
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
 solar_data_file		= '$DIN_LOC_ROOT/atm/cam/solar/SolarForcingCMIP6_18500101-22991231_c160830.nc'
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