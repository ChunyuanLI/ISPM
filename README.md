## Intrinsic Spatial Pyramid Matching

This is the package to demonstrate ISPM. It can 

   1. Visualize the functions and partitions on 3D meshed surfaces;
   2. Perform the Intrinsic Spatial Pyramid Matching of shapes.

## Citation
If you use this code for your research, please cite our paper: [Intrinsic Spatial Pyramid Matching](https://link.springer.com/article/10.1007/s13735-013-0041-9):

@article{li2013intrinsic,
  title={Intrinsic spatial pyramid matching for deformable 3d shape retrieval},
  author={Li, Chunyuan and Hamza, A Ben},
  journal={International Journal of Multimedia Information Retrieval},
  volume={2},
  number={4},
  pages={261--271},
  year={2013},
  publisher={Springer}
}

# Instructions:

Data: The first 4 shapes in shrec2011 nonrigid dataset [9] are used in this package.

	1. Visualize the partition of 2nd eigenfunction 

Step 1. Please open 'demo_visualize_isocontours.m';
Step 2. To set the number of isocontours, change 'Nlines'';
Step 3. Run the demo, it will visualize both the values and isocontours of 2nd eigenfunction.

	2. Intrinsic Spatial Pyramid Matching (ISPM)

Step 1. Please open 'demo_ISPM.m';
Step 2. Set the parameters of in 'setting_up.m', including the pyramid paritions 'pyramid'.
Step 3. Run 'demo_ISPM.m', it will perform ISPM and display the distances with different combinations.

Note that any of the following local descriptors can be incorporated as the input of ISPM, we use SGWS [7] in this demo. We surveyed the performance of these descriptors in [8], and found GPS [1] is not compatible with ISPM due to its sgin flip.

	Global Point Signature (GPS) [1], 
	Heat Kernel Signature (HKS) [2] [3], 
	Wave Kernel Signature (WKS) [4], 
	Scale Invariant Heat Kernel Signature (SIHKS) [5], 
	Heat mean signature (HMS) [6], 
	Spectral Graph Wavelet Signature (SGWS) [7].

If you use the package, please cite the paper [*]. Thanks.

# References
	[1] Rustamov, R.M.: Laplace-Beltrami eigenfunctions for deformation invariant shape representation. In: Proceedings of symposium on geometry processing, pp. 225–233 (2007)
	[2] Sun, J., Ovsjanikov, M., Guibas, L.J.: A concise and provably informative multi-scale signature based on heat diffusion. Comput. Graph. Forum 28(5), 1383–1392 (2009)
	[3] K. Gebal, J. A. Bærentzen, H. Aanæs, and R. Larsen. Shape analysis using the auto diffusion function. In Computer Graphics Forum, volume 28, pp 1405–1413 (2009).
	[4] Aubry, M., Schlickewei, U., Cremers, D.: The wave kernel signature: a quantum mechanical approach to shape analysis. In: Proceedings of computational methods for the innovative design of electrical devices, pp. 1626–1633 (2011)
	[5] Kokkinos, I., Bronstein, M.M., Yuille, A.: Dense scale-invariant descriptors for images and surfaces. Research Report, INRIA RR-7914 (2012)
	[6] Fang, Y., Sun, M., Kim, M., Ramani, K.: Heat-mapping: a robust approach toward perceptually consistent mesh segmentation. In: Proc. CVPR, pp. 2145–2152 (2011)
	[7] Li, Chunyuan, and A. Ben Hamza. "A multiresolution descriptor for deformable 3D shape retrieval." The Visual Computer 29.6-8 (2013): 513-524.
	[8] Li, Chunyuan, and A. Ben Hamza. "Spatially aggregating spectral descriptors for nonrigid 3D shape retrieval: a comparative survey." Multimedia Systems: 1-29.
	[9] Lian, Z., Godil, A., et al.: SHREC'11 track: Shape retrieval on non-rigid 3D watertight meshes. In Proc. of Eurographics on 3DOR, 2011.
