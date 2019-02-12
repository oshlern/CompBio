

population = 1000


def linear(n, k):
    return n*k

def exponential(n, k):
    return n**k

def hyperbolic(n, k, asymptote):
    return k*float(n**2)/(n - asymptote)
    