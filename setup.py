from setuptools import setup
from Cython.Build import cythonize

setup(
    name="Firewall Monitor",
    ext_modules=cythonize("firewall_monitor.pyx", compiler_directives={'language_level': "3"}),
    zip_safe=False,
)
