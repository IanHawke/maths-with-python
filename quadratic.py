
from math import sqrt
from numpy.testing import assert_equal, assert_allclose
    
def real_quadratic_roots(a, b, c):
    """
    Find the real roots of the quadratic equation a x^2 + b x + c = 0, if they exist.
    
    Parameters
    ----------
    
    a : float
        Coefficient of x^2
    b : float
        Coefficient of x^1
    c : float
        Coefficient of x^0
        
    Returns
    -------
    
    roots : tuple or float or None
        The root(s) (two if a genuine quadratic, one if linear, None otherwise)
        
    Raises
    ------
    
    NotImplementedError
        If the equation has trivial a and b coefficients, so isn't solvable.
    """
    
    discriminant = b**2 - 4.0*a*c
    if discriminant < 0.0:
        return None
    
    if a == 0:
        if b == 0:
            raise NotImplementedError("Cannot solve quadratic with both a"
                                      " and b coefficients equal to 0.")
        else:
            return -c / b
    
    x_plus = (-b + sqrt(discriminant)) / (2.0*a)
    x_minus = (-b - sqrt(discriminant)) / (2.0*a)
    
    return x_plus, x_minus

def test_no_roots():
    """
    Test that the roots of x^2 + 1 = 0 are not real.
    """
    
    roots = None
    assert_equal(real_quadratic_roots(1, 0, 1), roots,
                 err_msg="Testing x^2+1=0; no real roots.")

def test_zero_roots():
    """
    Test that the roots of x^2 = 0 are both zero.
    """
    
    roots = (0, 0)
    assert_equal(real_quadratic_roots(1, 0, 0), roots,
                 err_msg="Testing x^2=0; should both be zero.")

def test_real_distinct():
    """
    Test that the roots of x^2 - 1 = 0 are \pm 1.
    """
    
    roots = (1.0, -1.0)
    assert_equal(real_quadratic_roots(1, 0, -1), roots,
                 err_msg="Testing x^2-1=0; roots should be 1 and -1.")
    
def test_real_distinct_irrational():
    """
    Test that the roots of x^2 - 2 x + (1 - 10**(-10)) = 0 are 1 \pm 1e-5.
    """
    
    roots = (1 + 1e-5, 1 - 1e-5)
    assert_allclose(real_quadratic_roots(1, -2.0, 1.0 - 1e-10), roots,
                 err_msg="Testing x^2-2x+(1-1e-10)=0; roots should be 1 +- 1e-5.")
    
def test_real_linear_degeneracy():
    """
    Test that the root of x + 1 = 0 is -1.
    """
    
    root = -1.0
    assert_equal(real_quadratic_roots(0, 1, 1), root,
                 err_msg="Testing x+1=0; root should be -1.")
