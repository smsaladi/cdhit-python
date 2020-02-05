"""
Wrapper for cdhit c++ code

"""
# distutils: language = c++

cimport cdhitlib

cdef cluster():
    """
    // InitNAA( MAX_UAA )
    // options.NAAN = NAAN_array[options.NAA]
    // seq_db.NAAN = NAAN_array[options.NAA]

    // seq_db.Read( db_in.c_str(), options )
    // seq_db.SortDivide( options )

    // seq_db.DoClustering( options )
    // seq_db.WriteClusters( db_in.c_str(), db_out.c_str(), options )

    // seq_db.WriteExtra1D( options )
    """
    return

cdef cluster_est():
    return
