#! /bin/csh -f 

set exedir = $RUNDIR; cd $exedir

set mod_dompath = $DIN_LOC_ROOT/atm/cam/ocnfrac
set mod_domfile = domain.camocn.1.9x2.5_gx1v6_090403.nc
set dat_dompath = $DIN_LOC_ROOT/atm/cam/ocnfrac
set dat_domfile = domain.camocn.1.9x2.5_gx1v6_090403.nc
set dat_datpath = /cluster/projects/nn9385k/CMIP6_forcing/AMIP
set dat_datfile = sst_HadOIBl_bc_1.9x2.5_1850_2008_c100127.nc

set DOMAINFILE = ${mod_dompath}/${mod_domfile}
set DATAMODE   = SSTDATA
set year_align = 1850
set year_start = 1850
set year_end   = 2008
set STREAM     = CAMDATA
set STREAM1TXT = docn.stream.txt

#--- create namelist files ---
cat >! docn_in << EOF1
  &docn_nml
     ocn_in = 'docn_ocn_in'
     decomp = '1d'
  /
EOF1

cat >! docn_ocn_in << EOF1
 &shr_strdata_nml
   dataMode       = '$DATAMODE'
   domainFile     = '$DOMAINFILE'
   streams        = '$STREAM1TXT $year_align $year_start $year_end ',
                    'null' ,
                    'null' 
   vectors        = 'null'
  /
EOF1


cat >! $STREAM1TXT << EOF
<streamstemplate>
      <general_comment>
         streams template for docn in CCSM4
      </general_comment>
<stream>
      <comment>
         Stream description file for generic SST/ifrac data on the CAM grid
      </comment>
      <dataSource>
         Generic data source for CAMDATA
      </dataSource>
      <domainInfo>
         <variableNames>
            time time
            xc   lon
            yc   lat
            area area
            mask mask
         </variableNames>
         <filePath>
            $dat_dompath
         </filePath>
         <fileNames>
            $dat_domfile
         </fileNames>
      </domainInfo>
      <fieldInfo>
         <variableNames>
            SST_cpl    t
         </variableNames>
         <filePath>
            $dat_datpath
         </filePath>
         <fileNames>
            $dat_datfile
         </fileNames>
      </fieldInfo>
      <!-- Information on the program that created this file -->
      <build_streams_documentation>
         This CCSM stream text file was created by build_streams using the command line:
               /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/scripts/ccsm_utils/Tools/build_streams -t /cluster/home/earnest/models/NorCPM/cases/CAM4_t1_C4_2_ERAI/Tools/Templates/docn.template.streams.xml -s CAMDATA -dp $dat_dompath -do $dat_domfile -p $dat_datpath -filename $dat_datfile   
         For more information on build_streams:  
             /cluster/home/earnest/models/NorCPM/models/noresm1-me-intel2018a/scripts/ccsm_utils/Tools/build_streams -help          
      </build_streams_documentation>
</stream>
</streamstemplate>

EOF

echo DOMAINFILE = ${DOMAINFILE} >! $CASEBUILD/docn.input_data_list
$UTILROOT/Tools/listfilesin_streams -input_data_list -t $STREAM1TXT >> $CASEBUILD/docn.input_data_list

