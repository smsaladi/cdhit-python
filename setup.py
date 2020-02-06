
import os.path
import glob
import shutil

from setuptools import setup
from setuptools.extension import Extension
from Cython.Build import cythonize

import numpy as np

lib_root = "cdhit/cdhitlib/lib/"

# rename .c++ files to .cpp
shutil.copyfile(
    os.path.join(lib_root, "cdhit-common.c++"),
    os.path.join(lib_root, "cdhit-common.cpp"),
)

ext_files = [
    os.path.join(lib_root, "cdhit-common.cpp"),
    os.path.join(lib_root, "cd-hit-auxtools", "bioSequence.cxx"),
]
ext_files.extend(glob.glob(os.path.join(lib_root, "cd-hit-auxtools", "mintlib", "*.cxx")))
ext_files.extend(glob.glob("cdhit/cdhitlib/*.pyx"))

cdhitlib = Extension(
    "cdhit.cdhitlib",
    sources=ext_files,
    include_dirs=[lib_root,
        os.path.join(lib_root, "cd-hit-auxtools"),
        os.path.join(lib_root, "cd-hit-auxtools", "mintlib"),
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
    ext_modules=cythonize([cdhitlib], language_level="3", language="c++")
)
