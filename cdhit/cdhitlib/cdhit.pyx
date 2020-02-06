"""
Wrapper for cdhit c++ code

"""
# distutils: language = c++

STUFF = "Hi"

from . cimport cdhitlib as lib

cdef lib.Options options = lib.options
lib.InitNAA(lib.MAX_UAA)

def cluster():
    options = new lib.Options()
    seq_db = new lib.SequenceDB()

    # int ret = options.SetOptions( argc, argv ) #  (if returns zero then issue)
    # if ret == 0:
    #     raise ValueError print_usage(argv[0])
    
    options.Validate()

    lib.InitNAA(lib.MAX_UAA)
    options.NAAN = lib.NAAN_array[options.NAA]
    seq_db.NAAN = lib.NAAN_array[options.NAA]

    seq_db.Read(options.input.c_str(), options[0])
    
    seq_db.SortDivide(options[0])
    seq_db.DoClustering(options[0])

    seq_db.WriteClusters(options.input.c_str(), options.output.c_str(), options[0])

    seq_db.WriteExtra1D(options[0])

    return

cdef cluster_est():
    return
