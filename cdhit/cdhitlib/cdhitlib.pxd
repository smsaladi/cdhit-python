"""

Wrapper for cd-hit c++ code

"""
# distutils: language = c++

from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from libcpp cimport bool
from libcpp.string cimport string

# cdef extern from "lib/cdhit-common.cpp":
#    cdef Options options

cdef extern from "lib/cdhit-common.h":
    cdef int MAX_UAA

    cdef int NAAN_array[13]
    void InitNAA(int max)

    cdef Options options

    cdef cppclass Options:
        int     NAA
        int     NAAN
        int     NAA_top_limit

        size_t  max_memory # -M: 400,000,000 in bytes
        int     min_length # -l: 10 bases
        bool    cluster_best  # -g: 0, the first 1, the best
        bool    global_identity # -G:
        bool    store_disk # -B:
        int     band_width # -b: 20
        double  cluster_thd # -c
        double  distance_thd # -D
        double  diff_cutoff # -s: 0.0
        double  diff_cutoff2 # -s2: 1.0
        int     diff_cutoff_aa # -S: 999999
        int     diff_cutoff_aa2 # -S2: 0
        int     tolerance # -t: 2
        double  long_coverage # -aL:
        int     long_control # -AL:
        double  short_coverage # -aS:
        int     short_control # -AS:
        int     min_control # -A:
        double  long_unmatch_per # -uL
        double  short_unmatch_per # -uS
        int     unmatch_len # -U
        int     max_indel # -D
        int     print
        int     des_len
        int     frag_size
        int     option_r
        int     threads
        int     PE_mode     # -P
        int     trim_len    # -cx
        int     trim_len_R2 # -cy
        int     align_pos   # -ap for alignment position

        size_t  max_entries
        size_t  max_sequences
        size_t  mem_limit

        bool    has2D
        bool    isEST
        bool    is454
        bool    useIdentity
        bool    useDistance
        bool    backupFile

        string  input
        string  input_pe
        string  input2
        string  input2_pe
        string  output
        string  output_pe
            
        int     sort_output  # -sc
        int     sort_outputf # -sf

        Options() except +
        bool SetOptionCommon( const char *flag, const char *value )
        bool SetOption( const char *flag, const char *value )
        bool SetOption2D( const char *flag, const char *value )
        bool SetOptionEST( const char *flag, const char *value )
        bool SetOptions( int argc, char *argv[], bool twodata=false, bool est=false )

        void Validate()
        void ComputeTableLimits( int min_len, int max_len, int typical_len, size_t mem_need )

        void Print()

    cdef cppclass Vector[T]:
        pass

    cdef cppclass SequenceDB:
        int NAAN
        Vector[Sequence*]  sequences
        Vector[int]        rep_seqs

        long long total_letter
        long long total_desc
        size_t max_len
        size_t min_len
        size_t len_n50

        void Clear()
        SequenceDB() except +

        void Read( const char *file, const Options & options )
        void Readgz( const char *file, const Options & options )

        void Read( const char *file, const char *file2, const Options & options )
        void Readgz( const char *file, const char *file2, const Options & options )

        void WriteClusters( const char *db, const char *newdb, const Options & options )
        void WriteClustersgz( const char *db, const char *newdb, const Options & options )

        void WriteClusters( const char *db, const char *db_pe, const char *newdb, const char *newdb_pe, const Options & options )
        void WriteClustersgz( const char *db, const char *db_pe, const char *newdb, const char *newdb_pe, const Options & options )

        void WriteExtra1D( const Options & options )
        void WriteExtra2D( SequenceDB & other, const Options & options )
        void DivideSave( const char *db, const char *newdb, int n, const Options & options )

        void SwapIn( int seg, bool reponly=false )
        void SwapOut( int seg )

        void SortDivide( Options & options, bool sort=true )
        void MakeWordTable( const Options & optioins )

        size_t MinimalMemory( int frag_no, int bsize, int T, const Options & options, size_t extra=0 )

        void ClusterOne( Sequence *seq, int id, WordTable & table,
                WorkingParam & param, WorkingBuffer & buf, const Options & options )

        void ComputeDistance( const Options & options )
        void DoClustering( const Options & options )
        void DoClustering( int T, const Options & options )
        void ClusterTo( SequenceDB & other, const Options & optioins )
        int  CheckOne( Sequence *seq, WordTable & tab, WorkingParam & par, WorkingBuffer & buf, const Options & opt )
        int  CheckOneEST( Sequence *seq, WordTable & tab, WorkingParam & par, WorkingBuffer & buf, const Options & opt )
        int  CheckOneAA( Sequence *seq, WordTable & tab, WorkingParam & par, WorkingBuffer & buf, const Options & opt )

    cdef cppclass WordTable:
        pass
    cdef cppclass WorkingParam:
        pass
    cdef cppclass WorkingBuffer:
        pass

cdef extern from "lib/cd-hit-auxtools/bioSequence.hxx" namespace "Bio":
    cdef cppclass Sequence:
        uint32_t     id
        Min_String  des
        Min_String  seq
        Min_String  qs

        Sequence() except +

        void Copy( const Sequence & other )

        int Length()

        Min_String& Description()
        Min_String& SequenceData()
        Min_String& QualityScore()
        Min_String GetDescription( int deslen = 0 )

        void Reset()
        void ToReverseComplimentary()

        void Print( FILE *fout = stdout, int width = 0 )

cdef cppclass Min_String "Min::String"

