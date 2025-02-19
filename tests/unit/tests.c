/*****************************************************************************
 *
 *  tests.c
 *
 *  This runs the tests.
 *
 *  Edinburgh Soft Matter and Statistical Physics Group and
 *  Edinburgh Parallel Computing Centre
 *
 *  Kevin Stratford (kevin@epcc.ed.ac.uk)
 *  (c) 2010-2022 The University of Edinburgh
 *
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#include "tests.h"

__host__ int tests_create(void);

/*****************************************************************************
 *
 *  main
 *
 *****************************************************************************/

__host__ int main(int argc, char ** argv) {

  MPI_Init(&argc, &argv);

  tests_create();

  MPI_Finalize();

  return 0;
}

/*****************************************************************************
 *
 *  tests_create
 *
 *****************************************************************************/

__host__ int tests_create() {

  test_pe_suite();
  test_coords_suite();

  test_kernel_suite();
  test_gradient_d3q27_suite();
  test_angle_cosine_suite();
  test_assumptions_suite();
  test_be_suite();
  test_bond_fene_suite();
  test_bonds_suite();
  test_bp_suite();
  test_build_suite();
  test_ch_suite();
  test_colloid_suite();
  test_colloid_sums_suite();
  test_colloids_info_suite();
  test_colloids_halo_suite();
  test_ewald_suite();
  test_fe_electro_suite();
  test_fe_electro_symm_suite();
  test_fe_lc_droplet_suite();
  test_field_suite();
  test_field_grad_suite();
  test_halo_suite();
  test_hydro_suite();
  test_io_suite();
  test_io_options_suite();
  test_io_options_rt_suite();
  test_lb_d2q9_suite();
  test_lb_d3q15_suite();
  test_lb_d3q19_suite();
  test_lb_d3q27_suite();
  test_lb_model_suite();
  test_lb_bc_inflow_opts_suite();
  test_lb_bc_inflow_rhou_suite();
  test_lb_bc_outflow_opts_suite();
  test_lb_bc_outflow_rhou_suite();
  test_lc_anchoring_suite();
  test_le_suite();
  test_lubrication_suite();
  test_map_suite();
  test_map_init_suite();
  test_model_suite();
  test_noise_suite();
  test_pair_lj_cut_suite();
  test_pair_ss_cut_suite();
  test_pair_ss_cut_ij_suite();
  test_pair_yukawa_suite();
  test_phi_bc_inflow_opts_suite();
  test_phi_bc_inflow_fixed_suite();
  test_phi_bc_outflow_opts_suite();
  test_phi_bc_outflow_free_suite();
  test_polar_active_suite();
  test_psi_suite();
  test_lb_prop_suite();
  test_random_suite();
  test_rt_suite();
  test_timer_suite();
  test_util_suite();
  test_util_sum_suite();
  test_visc_arrhenius_suite();
  test_wall_suite();
  test_wall_ss_cut_suite();

  test_fe_surfactant1_suite();
  test_fe_symmetric_suite();
  test_fe_ternary_suite();

  return 0;
}

/*****************************************************************************
 *
 *  test_assert
 *
 *  Asimple assertion to control what happens in parallel.
 *
 *****************************************************************************/

__host__ __device__ void test_assert_info(const int lvalue, int line,
					  const char * file) {

  if (lvalue) {
    /* ok */
  }
  else {
#if defined( __CUDA_ARCH__ ) || defined( __HIP_DEVICE_COMPILE__ )
    /* No rank available */
    printf("Line %d file %s Failed test assertion\n", line, file);
    assert(0);
#else
    int rank;

    /* Who has failed? */
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    printf("[%d] Line %d file %s Failed test assertion\n", rank, line, file);
    MPI_Abort(MPI_COMM_WORLD, 0);
#endif
  }

  return;
}
