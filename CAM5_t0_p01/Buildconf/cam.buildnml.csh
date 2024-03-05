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
@ maxnpr_z = 30 

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
&aerosol_nl
 dust_emis_fact		= 0.35D0
 soil_erod		= '$DIN_LOC_ROOT/atm/cam/dst/dst_0.9x1.25_c100121.nc'
/
&cam_inparm
 bnd_topo		= '$DIN_LOC_ROOT/atm/cam/topo/USGS-gtopo30_0.9x1.25_remap_c051027.nc'
 cam_branch_file		= ' '
 dtime		= 1800
 fincl1   =  'SST', 'Z700', 'Z500', 'Z200', 'Z300', 'Z100', 'Z050', 'U200', 'U850', 'V200', 'V850', 'T200', 'T500', 'T700', 'T1000', 'OMEGA500', 'OMEGA850', 'ICEFRAC', 'T1000', 'OMEGA500', 'OMEGA850', 'ICEFRAC'

 mfilt     = 12
 nhtfrq    = 0

 ncdata		= '$DIN_LOC_ROOT/atm/cam/inic/fv/cami-mam3_0000-01-01_0.9x1.25_L30_c100618.nc'
 print_energy_errors		= .false.
/
&chem_inparm
 aer_drydep_list		= 'bc_a1', 'dst_a1', 'dst_a3', 'ncl_a1', 'ncl_a2', 'ncl_a3', 'num_a1', 'num_a2', 'num_a3', 'pom_a1', 'so4_a1',
  'so4_a2', 'so4_a3', 'soa_a1', 'soa_a2'
 aer_wetdep_list		= 'bc_a1', 'dst_a1', 'dst_a3', 'ncl_a1', 'ncl_a2', 'ncl_a3', 'num_a1', 'num_a2', 'num_a3', 'pom_a1', 'so4_a1',
  'so4_a2', 'so4_a3', 'soa_a1', 'soa_a2'
 clim_soilw_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/dvel/clim_soilw.nc'
 depvel_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/dvel/depvel_monthly.nc'
 depvel_lnd_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/dvel/regrid_vegetation.nc'
 exo_coldens_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/phot/exo_coldens.nc'
 ext_frc_specifier		= 'SO2         -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so2_elev_2000_c090726.nc',
  'bc_a1       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_bc_elev_2000_c090726.nc',
  'num_a1      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a1_elev_2000_c090726.nc',
  'num_a2      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a2_elev_2000_c090726.nc',
  'pom_a1      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_oc_elev_2000_c090726.nc',
  'so4_a1      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a1_elev_2000_c090726.nc',
  'so4_a2      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a2_elev_2000_c090726.nc'
 ext_frc_type		= 'CYCLICAL'
 fstrat_list		= ' '
 rsf_file		= '$DIN_LOC_ROOT/atm/waccm/phot/RSF_GT200nm_v3.0_c080416.nc'
 season_wes_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/dvel/season_wes.nc'
 srf_emis_specifier		= 'DMS       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/aerocom_mam3_dms_surf_2000_c090129.nc',
  'SO2       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so2_surf_2000_c090726.nc',
  'SOAG      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_soag_1.5_surf_2000_c100217.nc',
  'bc_a1     -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_bc_surf_2000_c090726.nc',
  'num_a1    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a1_surf_2000_c090726.nc',
  'num_a2    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a2_surf_2000_c090726.nc',
  'pom_a1    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_oc_surf_2000_c090726.nc',
  'so4_a1    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a1_surf_2000_c090726.nc',
  'so4_a2    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a2_surf_2000_c090726.nc'
 srf_emis_type		= 'CYCLICAL'
 tracer_cnst_cycle_yr		= 2000
 tracer_cnst_datapath		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/oxid'
 tracer_cnst_file		= 'oxid_1.9x2.5_L26_1850-2005_c091123.nc'
 tracer_cnst_filelist		= 'oxid_1.9x2.5_L26_clim_list.c090805.txt'
 tracer_cnst_specifier		= 'O3','OH','NO3','HO2'
 tracer_cnst_type		= 'CYCLICAL'
 use_cam_sulfchem		= .false.
 xactive_prates		= .false.
 xs_long_file		= '$DIN_LOC_ROOT/atm/waccm/phot/temp_prs_GT200nm_jpl06_c080930.nc'
/
&chem_surfvals_nl
 ch4vmr		= 1760.0e-9
 co2vmr		= 367.0e-6
 f11vmr		= 653.45e-12
 f12vmr		= 535.0e-12
 flbc_list		= ' '
 n2ovmr		= 316.0e-9
/
&cldfrc_nl
 cldfrc_dp1		=  0.10D0 
 cldfrc_dp2		=  500.0D0 
 cldfrc_freeze_dry		= .true.
 cldfrc_ice		= .true.
 cldfrc_premit		=  40000.0D0 
 cldfrc_rhminh		=  0.800D0 
 cldfrc_rhminl		=  0.8975D0 
 cldfrc_sh1		=  0.04D0 
 cldfrc_sh2		=  500.0D0 
/
&cldsed_nl
 cldsed_ice_stokes_fac		=  1.0D0 
/
&cldwat_nl
 cldwat_conke		=   5.0e-6  
 cldwat_icritc		=  18.0e-6  
 cldwat_icritw		=   2.0e-4  
 cldwat_r3lcrit		=   10.0e-6  
/
&dyn_fv_inparm
 del2coef		= 3.e+5
 div24del2flag		=  4
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
&modal_aer_opt_nl
 modal_optics_file		= '$DIN_LOC_ROOT/atm/cam/physprops/modal_optics_3mode_c100507.nc'
 water_refindex_file		= '$DIN_LOC_ROOT/atm/cam/physprops/water_refindex_rrtmg_c080910.nc'
/
&phys_ctl_nl
 cam_chempkg		= 'trop_mam3'
 cam_physpkg		= 'cam5'
 conv_water_in_rad		=  1 
 deep_scheme		= 'ZM'
 do_iss		=  .true.  
 do_tms		=  .true.  
 eddy_scheme		= 'diag_TKE'
 history_microphysics		=   .true.  
 microp_scheme		= 'MG'
 radiation_scheme		= 'rrtmg'
 shallow_scheme		= 'UW'
 srf_flux_avg		= 0
 tms_orocnst		=  1.0D0   
 tms_z0fac		=  0.075D0 
 waccmx_opt		= 'off'
/
&prescribed_ozone_nl
 prescribed_ozone_cycle_yr		= 2000
 prescribed_ozone_datapath		= '$DIN_LOC_ROOT/atm/cam/ozone'
 prescribed_ozone_file		= 'ozone_1.9x2.5_L26_2000clim_c091112.nc'
 prescribed_ozone_name		= 'O3'
 prescribed_ozone_type		= 'CYCLICAL'
/
&rad_cnst_nl
 icecldoptics		= 'mitchell'
 iceopticsfile		= '$DIN_LOC_ROOT/atm/cam/physprops/iceoptics_c080917.nc'
 liqcldoptics		= 'gammadist'
 liqopticsfile		= '$DIN_LOC_ROOT/atm/cam/physprops/F_nwvl200_mu20_lam50_res64_t298_c080428.nc'
 rad_climate		= 'P_Q:H2O', 'D_O2:O2', 'D_CO2:CO2', 'D_ozone:O3', 'D_N2O:N2O', 'D_CH4:CH4', 'D_CFC11:CFC11',
  'D_CFC12:CFC12', 'P_so4_a1:$DIN_LOC_ROOT/atm/cam/physprops/sulfate_rrtmg_c080918.nc',
  'P_pom_a1:$DIN_LOC_ROOT/atm/cam/physprops/ocpho_rrtmg_c101112.nc',
  'P_soa_a1:$DIN_LOC_ROOT/atm/cam/physprops/ocphi_rrtmg_c100508.nc',
  'P_bc_a1:$DIN_LOC_ROOT/atm/cam/physprops/bcpho_rrtmg_c100508.nc',
  'P_dst_a1:$DIN_LOC_ROOT/atm/cam/physprops/dust4_rrtmg_c090521.nc',
  'P_ncl_a1:$DIN_LOC_ROOT/atm/cam/physprops/ssam_rrtmg_c100508.nc',
  'P_so4_a2:$DIN_LOC_ROOT/atm/cam/physprops/sulfate_rrtmg_c080918.nc',
  'P_soa_a2:$DIN_LOC_ROOT/atm/cam/physprops/ocphi_rrtmg_c100508.nc',
  'P_ncl_a2:$DIN_LOC_ROOT/atm/cam/physprops/ssam_rrtmg_c100508.nc',
  'P_dst_a3:$DIN_LOC_ROOT/atm/cam/physprops/dust4_rrtmg_c090521.nc',
  'P_ncl_a3:$DIN_LOC_ROOT/atm/cam/physprops/ssam_rrtmg_c100508.nc',
  'P_so4_a3:$DIN_LOC_ROOT/atm/cam/physprops/sulfate_rrtmg_c080918.nc'
/
&solar_inparm
 solar_const		= -9999.
 solar_data_file		= '$DIN_LOC_ROOT/atm/cam/solar/solar_ave_sc19-sc23.c090810.nc'
 solar_htng_spctrl_scl		= .true.
/
&spmd_fv_inparm
 npr_yz		= $npr_y,$npr_z,$npr_z,$npr_y
/
&tropopause_nl
 tropopause_climo_file		= '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart/ub/clim_p_trop.nc'
/
&uwshcu_nl
 uwshcu_rpen		=   10.0 
/
&wetdep_inparm
 gas_wetdep_list		= 'H2O2','SO2'
/
&zmconv_nl
 zmconv_c0_lnd		=  0.0059D0 
 zmconv_c0_ocn		=  0.0450D0 
 zmconv_ke		=  1.0E-6 
/

EOF
