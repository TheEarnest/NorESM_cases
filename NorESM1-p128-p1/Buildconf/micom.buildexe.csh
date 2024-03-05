#! /bin/csh -f 

set exedir = $EXEROOT/run
set objdir = $OBJROOT/ocn/obj; cd $objdir
set dimdir = $objdir/dimensions
set turbclo = (`echo $MICOM_TURBULENT_CLOSURE`)
set tracers = (`echo $MICOM_TRACER_MODULES`)
set co2type = (`echo $MICOM_CO2_TYPE`)
set rivnutr = (`echo $MICOM_RIVER_NUTRIENTS`)

#------------------------------------------------------------------------------
# Make dimensions.F
#------------------------------------------------------------------------------

mkdir -p $dimdir
set kdm = 53
$CASEROOT/Tools/Templates/micom_dimensions -n $NTASKS_OCN -k $kdm -d $CODEROOT/ocn/micom/bld/$OCN_GRID
set recompile = FALSE
cmp -s dimensions.F $dimdir/dimensions.F || set recompile = TRUE
if ($recompile == 'TRUE') then
  mv dimensions.F $dimdir
else
  rm dimensions.F
endif

#------------------------------------------------------------------------------
# Set list of file paths and resolve C preprocessor macros
#------------------------------------------------------------------------------

\cat >! Filepath << EOF1
$dimdir
$CASEROOT/SourceMods/src.micom
$CODEROOT/ocn/micom/drivers/cpl_share
$CODEROOT/ocn/micom/drivers/cpl_mct
$CODEROOT/ocn/micom/phy
EOF1


set cpp_ocn = "-DCCSMCOUPLED -DMPI -DNCEP"
if ($OCN_GRID == tnx2v1 || $OCN_GRID == tnx1v1 || $OCN_GRID == tnx1.5v1 || $OCN_GRID == tnx0.25v1) then
  set cpp_ocn = "$cpp_ocn -DARCTIC"
endif
if ($OCN_GRID == gx1v5 || $OCN_GRID == gx1v6 || $OCN_GRID == tnx1v1 || $OCN_GRID == tnx0.25v1) then
  set cpp_ocn = "$cpp_ocn -DLEVITUS2X"
endif
if ($OCN_GRID == s1v1) then
  set cpp_ocn = "$cpp_ocn -DNUDGE_TS"
endif
if ($#turbclo != 0) then
  set twoeq = FALSE
  set oneeq = FALSE
  foreach option ($turbclo)
    if      ($option == twoeq) then
      set cpp_ocn = "$cpp_ocn -DTKE -DGLS -DTKEDFF"
      set twoeq = TRUE
    else if ($option == oneeq) then
      set cpp_ocn = "$cpp_ocn -DTKE -DTKEDFF"
      set oneeq = TRUE
    else if ($option == advection) then
      set cpp_ocn = "$cpp_ocn -DTKEADV"
    else if ($option == isodif) then
      set cpp_ocn = "$cpp_ocn -DTKEIDF"
    else
      echo $0": Turbulent closure option $option is not recognized!"
      exit -1
    endif
  end
  if ($twoeq == 'FALSE' && $oneeq == 'FALSE') then
    echo $0": For turbulent closure either twoeq or oneeq must be provided as options!"
    exit -1
  endif
  if ($twoeq == 'TRUE' && $oneeq == 'TRUE') then
    echo $0": Do not use both twoeq and oneeq as options for turbulent closure!"
    exit -1
  endif
endif
if ($#tracers != 0) then
  echo $CODEROOT/ocn/micom/trc >> Filepath
  set cpp_ocn = "$cpp_ocn -DTRC"
  foreach module ($tracers)
    if      ($module == iage) then
      echo $CODEROOT/ocn/micom/idlage >> Filepath
      set cpp_ocn = "$cpp_ocn -DIDLAGE"
    else if ($module == ecosys) then
      echo $CODEROOT/ocn/micom/hamocc >> Filepath
      set cpp_ocn = "$cpp_ocn -DHAMOCC -DRESTART_BGC"
      if ($co2type == prognostic) then
        set cpp_ocn = "$cpp_ocn -DPROGCO2"
      else if ($co2type == diagnostic) then
        set cpp_ocn = "$cpp_ocn -DDIAGCO2"
      else if ($co2type != constant) then
        echo $0": CO2 type $co2type is not recognized!"
        exit -1
      endif
      if ($rivnutr == TRUE) then 
        set cpp_ocn = "$cpp_ocn -DRIV_GNEWS"
      endif 
    else
      echo $0": tracer module $module is not recognized!"
      exit -1
    endif
  end
endif

#------------------------------------------------------------------------------
# Build the library
#------------------------------------------------------------------------------

gmake complib -j $GMAKE_J MODEL=micom COMPLIB=$LIBROOT/libocn.a MACFILE=$CASEROOT/Macros.$MACH USER_CPPDEFS="$cpp_ocn" -f $BLDROOT/Makefile || exit 2

if !(-f $LIBROOT/libocn.a) then
  echo "ERROR: micom library not available"
  exit -1
endif

