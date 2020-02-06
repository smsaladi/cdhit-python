"""

Wrapper for cd-hit c++ code

"""

cdef extern from "lib/cdhit-common.h":
    pass

cdef extern from "lib/cd-hit-auxtools/bioSequence.hxx" namespace "Bio":
    pass