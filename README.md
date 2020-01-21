# SpNMF
# Language: R
# Input: TXT (parameters)
# Output: CSV (predictions)
# Tested with: PluMA 1.0, R 3.2.5

PluMA plugin that takes a training and test set,
and attempts to classify the four samples in the test set
using Supervised Non-Negative Matrix Factorization (Cai et al, 2017)

The input TXT file contains three tab-separated keyword-value pairs,
training (maps to the training data), traininggroups (the group for each
sample in the training data), and testing (maps to the test data).
All of these are assumed to be in CSV format.

The output CSV file will map each sample to its corresponding category.
In this particular case the mapping is binary (0 or 1), though
could be extended potentially for more groupings.

Input data files were produced from the spdata set,
available once the SpNMF library is loaded at the top of the script.
These were setup using the statements under the CRAN documentation for SpNMF, available here:
https://cran.r-project.org/web/packages/SpNMF/SpNMF.pdf
