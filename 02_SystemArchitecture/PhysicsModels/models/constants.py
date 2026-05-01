import numpy as np
"""
Gaussian FWHM to sigma conversion constant

For a Gaussian distribution:
    f(x) = exp( -x^2 / (2 * sigma^2) )

The Full Width at Half Maximum (FWHM) is defined as the width of the
distribution at half of its maximum value.

Solve for x:

    exp( -x^2 / (2 * sigma^2) ) = 1/2

    -x^2 / (2 * sigma^2) = ln(1/2)

Since ln(1/2) = -ln(2):

    x^2 = 2 * sigma^2 * ln(2)

    x = sigma * sqrt(2 * ln(2))

This x is the half-width at half-maximum.

Therefore the full width is:

    FWHM = 2 * sigma * sqrt(2 * ln(2))

Rearranging gives:

    FWHM = sigma * (2 * sqrt(2 * ln(2)))

    FWHM_TO_SIGMA = (2 * sqrt(2 * ln(2)))
"""
FWHM_TO_SIGMA = 2.0 * np.sqrt(2.0 * np.log(2.0))