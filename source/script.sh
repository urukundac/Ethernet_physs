/p/cth/bin/cth_psetup -proj dmrd -cfg MKIFE -read_only
setenv DVB_ROOT /p/cth/cad/dvb/2024.06.fe.DVB.1.0/dvb
setenv RED_OS3FP_HOME /nfs/site/disks/zsc14.xne_mki.fpga.001/pdewanga/simenes_fixes/OS3_FP.23.0.2-18/distribution
setenv PATH $RED_OS3FP_HOME/bin:$PATH
setenv WORKAREA <PATH>
cd gen_filelist
make gen
cd ../verif/fpga
make cleanall all BUILD_DIRNAME=vps_dvb MODEL=MKI_SOC WORKDIR=>BUILD_DIR_NAME> &
