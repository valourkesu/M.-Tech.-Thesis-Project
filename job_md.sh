#!/bin/bash --login
#PBS -N MoO3_Urea_MD
#PBS -q medium
#PBS -l nodes=1:ppn=32
#PBS -l walltime=24:00:00
#PBS -o job_output.log
#PBS -e job_error.log

cd $PBS_O_WORKDIR

# Load GCC compiler module used during build
module load compilers/gcc/gcc-13.4.0

# Activate your custom GROMACS 2025 installation
source /scratch/home/hpc1165/gromacs-2025/bin/GMXRC

# 1. Generate the .tpr file using GROMACS 2025
#gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_10.tpr
#gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_10.tpr

#To fix this, we need to ensure that the product of MPI ranks and OpenMP threads equals your total available CPU cores (32).
export OMP_NUM_THREADS=4

# 2. Run the production simulation
#mpirun -np 8 gmx_mpi mdrun -deffnm md_0_10
#mpirun -np 8 gmx_mpi mdrun -deffnm md_0_10
#gmx_mpi mdrun -deffnm md -ntmpi 8 -ntomp 4 -cpt 15
# 2. Run the production simulation
mpirun -np 8 gmx_mpi mdrun -deffnm md -ntomp 4 -cpt 15
