# Relative Depth Estimation from Hyperspectral Data

**Ali Zia, Jun Zhou, Yongsheng Gao**
*International Conference on Digital Image Computing: Techniques and Applications (DICTA), 2015*

[![Paper](https://img.shields.io/badge/Paper-DICTA%202015-blue)](https://research-repository.griffith.edu.au/items/712b9517-7939-5a37-a748-9cb5ed0f4b0e) ![Language](https://img.shields.io/badge/Language-MATLAB-orange) [![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

> **Status.** This is the original research code behind the publication,
> prepared for release. Duplicate, backup and autosave files, data and personal
> file paths were removed and third-party code was separated into
> `third_party/`; the algorithms themselves were not modified. It is research
> code rather than a polished toolbox, and it was developed on Windows MATLAB.

## Overview

A camera lens does not bring all wavelengths into focus at the same distance.
This chromatic aberration means that, in a hyperspectral image, the amount of
defocus blur at an object edge changes from band to band, and how it changes
depends on how far the edge is from the focal plane. The paper shows that this
band-to-band variation can be used to recover relative depth from a single
hyperspectral cube, without stereo, motion or active illumination.

This repository contains the MATLAB implementation. Two complementary sparse
depth cues are computed at edge pixels and fused into a single sparse relative
depth map.

## Method

1. **Pre-processing.** The ENVI cube is dark-frame corrected and normalised
   (`saveCube.m`, `utils/darknormalise.m`), and the usable bands are selected
   (bands 20–53 in the paper). Edges are detected across bands (`getedgecube.m`).
2. **Cue 1: band-wise histogram variance.** For every edge pixel and band, a
   local intensity histogram is built and the variance of its bins measures
   local defocus (`getcubehistogram.m`, `localhistAnalysis.m`). The band-wise
   measures are combined into the first sparse depth map.
3. **Cue 2: spectral differences.** Differences between neighbouring spectral
   vectors around each edge pixel give a second, independent estimate
   (`SumofDifference.m`).
4. **Fusion and refinement.** Both maps are normalised, combined with a weight
   chosen by a small search, and smoothed for consistency along edges
   (`MergeMapsScript.m`, `normaliseandSmoothLDmap.m`).

## Repository structure

```
setup_paths.m             add all code folders to the MATLAB path
run_relative_depth.m      end-to-end driver: both cues and their fusion
src/
  MainScript.m            original experiment script
  MergeMapsScript.m       fusion of the two sparse maps
  getcubehistogram.m      cue 1: local histograms
  localhistAnalysis.m     cue 1: band-wise variance
  SumofDifference.m       cue 2: spectral differences
  showcubedata.m/.fig     GUI to browse the band-wise depth cube
utils/                    ENVI loader (Load_Spec), dark-frame correction, normalisation
data/                     place your data here (not tracked)
```

## Requirements

- MATLAB (developed with R2014–R2015 on Windows; the loaders split paths on `\`)
- Image Processing Toolbox
- Statistics and Machine Learning Toolbox (`knnsearch`)

## Getting started

```matlab
>> cd hsi-relative-depth-estimation
>> setup_paths
>> run_relative_depth
```

Before running, edit `datafolder` and `filename` at the top of
`run_relative_depth.m` to point at an ENVI cube (`.dat` + `.hdr`), and set the
dark reference cube in `utils/darknormalise.m`. The driver shows both sparse
maps, saves them next to the input, and displays the fused result.

## Data

The indoor, rooftop and outdoor scenes used in the paper are not distributed
with this repository. The code expects ENVI cubes together with a dark
reference cube captured with the same camera settings; see `data/README.md`.

## Notes on reproducibility

- `run_relative_depth.m` is a convenience driver added for this release. It
  only chains calls that already existed in `src/MainScript.m` (where cue 1 was
  commented out) and `src/MergeMapsScript.m`.
- `DenseDepthmap1.m`, `RSDE.m` and `focusAnalysis.m` are early experiments and
  are not part of the published pipeline. The dense extension of this work is
  in [`hsi-chromatic-defocus-depth`](https://github.com/alizia369/hsi-chromatic-defocus-depth).

## Citation

If you use this code, please cite:

```bibtex
@inproceedings{zia2015relativedepth,
  title     = {Relative Depth Estimation from Hyperspectral Data},
  author    = {Zia, Ali and Zhou, Jun and Gao, Yongsheng},
  booktitle = {International Conference on Digital Image Computing: Techniques and Applications (DICTA)},
  year      = {2015}
}
```

A `CITATION.cff` file is included, so GitHub's **Cite this repository** button gives the same reference.

## Licence and third-party code

Released under the **MIT licence** (see `LICENSE`). `utils/Load_Spec.m` was
written by Jie Liang and is included with attribution.

## Acknowledgements

The original work was carried out in the School of Information and Communication Technology, Griffith University, Australia. See the paper for full acknowledgements.

## Contact

Questions and bug reports are welcome through [GitHub issues](https://github.com/alizia369/hsi-relative-depth-estimation/issues).
Ali Zia, La Trobe University — [www.ali-zia.me](https://www.ali-zia.me)

## Related repositories

This repository is one of a set released together from the same line of work on hyperspectral computer vision:

- [`hsi-3d-reconstruction`](https://github.com/alizia369/hsi-3d-reconstruction): 3D reconstruction from hyperspectral images (WACV 2015)
- [`hsi-chromatic-defocus-depth`](https://github.com/alizia369/hsi-chromatic-defocus-depth): Chromatic aberration + defocus for relative depth (IEEE TIP 2021)
- [`hsi-occluded-object-detection`](https://github.com/alizia369/hsi-occluded-object-detection): Occluded object detection (PhD thesis, arXiv forthcoming)
- [`hsi-material-boundary-detection`](https://github.com/alizia369/hsi-material-boundary-detection): Material-based boundary detection (DICTA 2017)
- [`sugarcane-smut-hsi`](https://github.com/alizia369/sugarcane-smut-hsi): Early sugarcane smut detection (IVCNZ 2021)
- [`hsi-matlab-utils`](https://github.com/alizia369/hsi-matlab-utils): Shared hyperspectral I/O and normalisation helpers
