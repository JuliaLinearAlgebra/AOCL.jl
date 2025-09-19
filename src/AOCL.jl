# Copyright (c) Advanced Micro Devices, Inc., or its affiliates.
# SPDX-License-Identifier: MIT

module AOCL

using AOCL_jll
using LinearAlgebra

function __init__()
    lbt_forward_to_aocl()
end

function lbt_forward_to_aocl()
    if !AOCL_jll.is_available()
        isinteractive() && @warn "AOCL is not available/installed."
        return
    end

    if Base.USE_BLAS64
        # Load ILP64 forwards
        BLAS.lbt_forward(aocl_blas_ilp64; clear=true)
        BLAS.lbt_forward(aocl_lapack_ilp64)

        # Load LP64 forwards
        BLAS.lbt_forward(aocl_blas_lp64)
        BLAS.lbt_forward(aocl_lapack_lp64)
    else
        BLAS.lbt_forward(aocl_blas_lp64; clear = true)
        BLAS.lbt_forward(aocl_lapack_lp64)
    end
end

end # module
