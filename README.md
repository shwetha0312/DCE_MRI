Matlab scripts for Direct Reconstruction in DCE-MRI for E-Tofts Model
============================================================
Adapted some of the code written by *Yi Guo*, *Sajan Goud Lingala*, *Krishna Nayak*, Jul 2016. [Magnetic Resonance Engineering Laboratory](https://mrel.usc.edu)

Final report contains the details of the entire project.

Code Structure
--------------
### Demo scripts
**Kt_Vp_SEN_AD_3d.m**
Reconstruction script to demonstrate direct reconstruction from under-sampled k-space in retrospective studies.  
Please download data set at https://drive.google.com/file/d/0B4nLrDuviSiWajFDV1Frc3cxR0k/view?usp=sharing for DCE50_0402.mat and
https://drive.google.com/file/d/0B4nLrDuviSiWcGFPOUV1b2VrZUU/view?usp=sharing for T1_0402.mat

### Functions: 
**conc2Ktrans.m**: 
	Convert contrast concentration to TK parameter maps.  
**conc2sig.m**: 
	Convert contrast concentration to signal (images).  
**genRGA.m**: 
	Generate randomized golden-angle radial sampling pattern.  
**Kt_Vp_SEN.m**: 
	Alternatively reconstruct Ktrans and Vp maps using l-bfgs.  
**Ktrans2conc.m**: 
	Convert Ktrans maps to contrast concentration.  
**sig2conc2.m**: 
	Convert signal (images) to contrast concentration.  
**Ktrans2sig_sen_WT.m**: 
	Cost and gradient calculation for the objective function for Ktrans.  
**Vp2sig_SEN_WT.m**: 
	Cost and gradient calculation for the objective funciton for Vp.  
**SAIF_p.m**: 
	Generate population-averaged AIF.  

---------------------------------------------------------------------------------------------------------
I have modified the above code for Estimation of Ktrans, Kep and Vp (Etofts model) from undersampled K-space

**Kt_Vp_SEN_AD_3d.m**:
Main script for defining undersampling rates and other parameters

**Kt_Vp_Kep_SEN**: 
Reconstructs Ktrans, Vp and Kep all together.

**model_extended_tofts_s**:
Concentration found from  Ktrans, Kep and Vp 

**allparams**:
Finds the cost and gradient of objective function which has to be given as input to minFunc

**allparamsmodd**:
Use this script for also employing TV regularization

**Kep2sig_sen_WT**:
Calculates the cost and gradient for the objective function for Kep 

