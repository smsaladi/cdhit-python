import glob
import shutil

from setuptools import setup
from setuptools.extension import Extension
from Cython.Build import cythonize

import numpy as np

# rename .c++ files to .cpp
shutil.copyfile(
    "cdhit/lib/cdhit-common.c++",
    "cdhit/lib/cdhit-common.cpp",
)
ext_files = [
    "cdhit/lib/cdhit-common.cpp",
    "cdhit/lib/cd-hit-auxtools/bioSequence.cxx",
]
ext_files.extend(glob.glob("cdhit/lib/cd-hit-auxtools/mintlib/*.cxx"))
ext_files.extend(glob.glob("*.pyx"))

cdhitlib = Extension(
    "cdhitlib.lib",
    ext_files,
    include_dirs=["cdhit/lib",
        "cdhit/lib/cd-hit-auxtools",
        "cdhit/lib/cd-hit-auxtools/mintlib",
        np.get_include()],
    language="c++"
)

setup(
    name='cdhit-python',
    version='1.0',
    author='Shyam Saladi',
    author_email='saladi@caltech.edu',
    url='https://github.com/smsaladi/cdhit-python',
    packages=[
        'cdhit',
    ],
    setup_requires=[
        'cython',
    ],
    install_requires=[
        'numpy',
        'pandas'
    ],
    tests_require = [
        'pytest',
        'biopython',
    ],
    test_suite="pytest",
    ext_modules=cythonize([cdhitlib], language="c++", language_level="3")
)
