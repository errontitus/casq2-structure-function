X-ray crystallographic studies of the cardiac calsequestrin protein and its role in familial arrhythmia.

See https://www.biorxiv.org/content/10.1101/672303v2.

Notes:

- Use ./results/run_all.zsh to generate the results used in the paper. This is a master script that invokes a variety of other scripts, most of which run PyMOL to generate graphics used in the manuscript. Other software packages are required (zsh, clustalo, python, a variety of python packages for biology, and several software packages used in structural biology (Phenix, ccp4, APBS)). Although certain scripts will fail without these packages installed, the logic in most cases should be fairly easy to follow for anyone familiar with PyMOL and python.

- Use ./doc/make_manuscript.zsh to generate the paper and figures in LaTeX. This requires a number of LaTeX packages to be installed.
