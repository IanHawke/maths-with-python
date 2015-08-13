# -*- coding: utf-8 -*-
"""
Created on Wed Apr 22 11:12:44 2015

@author: ih3
"""

from math import pi

def degrees_to_radians(theta_d):
    """
    Convert an angle from degrees to radians.
    
    Parameters
    ----------
    
    theta_d : float
        The angle in degrees.
        
    Returns
    -------
    
    theta_r : float
        The angle in radians.
    """
    theta_r = pi / 180.0 * theta_d
    return theta_r
