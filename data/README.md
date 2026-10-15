# data/

Nothing in this folder is tracked by git (see `.gitignore`).

Expected input: a hyperspectral cube in ENVI format (`<name>.dat` with its
`<name>.hdr`). The paper used indoor and rooftop scenes captured with a
hyperspectral camera; bands 20–53 were used.

You also need a **dark reference cube** (lens cap on, same camera settings).
`utils/darknormalise.m` loads it from
`.\data\Depth Estimation\outdoor\normalisedata\dark1.dat`; change `dpath`
there if yours lives elsewhere. `saveCube.m` writes a `.mat` copy of the
normalised cube, and optionally one PNG per band, next to the input.

The original scripts had absolute paths to the author's machines. These were
replaced with relative placeholders that start with `.\data\...`, so the
simplest set-up is to copy (or symlink) your data here, keeping the same
sub-folder names, and run scripts from the repository root. You can also just
edit the path variables at the top of each script.
