# create_and_run_vitis_hls_project.tcl

# Set project name, top function, and directories
set project_name "fir_basic_project"
set top_function "fir"
#set source_directory "src"
#set testbench_directory "tb"
set solution_name "solution1"

# Create a new project
open_project $project_name

# Add source files and testbench files
#add_files -cflags "-std=c++0x" $source_directory/*.cpp
add_files -cflags "-std=c++0x" fir_basic.cpp
add_files -cflags "-std=c++0x" fir.h
add_files -cflags "-std=c++0x" -tb fir_top.cpp

# Set the top-level function
set_top $top_function

# Create and open a solution
open_solution $solution_name

# Set HLS solution properties
set_part "xc7z020clg484-1"
create_clock -period 10

# Run C simulation
csim_design

# Run synthesis and export RTL
csynth_design
#export_design

# Run C/RTL co-simulation
cosim_design

# Generate HLS reports
#report_top

# Close project
close_project
