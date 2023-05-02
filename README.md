# The relaxed power spectral density function
This repository provides a stochastic load representation, the so-called *relaxed power spectral density function*, that takes epistemic uncertainties into account and aims to be universally valid and independent of site-specific parameters. The excitation spectrum is estimated from multiple data sets with same characteristics to obtain a reliable probabilistic representation. The individual discrete frequencies will be treated as probability density functions and thus random variables, resulting in a model controlled by subjective probabilities. For this purpose, meaningful statistical variables of the ensemble are extracted. The main novelty of this load model is the accounting for epistemic uncertainties in data sets to derive a probabilistic description of the input data in the frequency domain. The main difference between the traditional PSD function and the relaxed PSD function is that random variables are used to describe the input PSD function, whereas previously discrete values were utilised. This allows uncertainties in the data to be better captured. 

## References
**Behrendt, M.; Bittner, M.; Comerford, L.; Beer, M.; Chen, J. (2022):** Relaxed power spectrum estimation from multiple data records utilising subjective probabilities, Mechanical Systems and Signal Processing, 165, Article 108346, DOI: [10.1016/j.ymssp.2021.108346](https://doi.org/10.1016/j.ymssp.2021.108346).

## Computation of the relaxed PSD
The relaxed PSD can be computed by running the file `example_relaxed_PSD.m`. Based on an analytical PSD a set of time signals is generated by the spectral representation method. These signals are transformed to the frequency domain to obtain the ensemble of PSD functions. This ensemble is used to generate the relaxed PSD by defining a probability density function for each individual frequency by the function `gen_relaxedPSD.m`. The results are visualised by `plot_relaxedPSD.m`.


