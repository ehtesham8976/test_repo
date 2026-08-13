# ============================================================
# Vivado Simulation Script
# ============================================================

puts ""
puts "============================================================"
puts "        VIVADO AUTOMATED SIMULATION"
puts "============================================================"
puts ""

# FPGA part
set PART "xc7a100tcsg324-1"

# Project directory
set PROJECT_DIR "./vivado_project"

# Remove old project
if {[file exists $PROJECT_DIR]} {
    file delete -force $PROJECT_DIR
}

puts "Creating Vivado project..."

create_project counter_sim $PROJECT_DIR -part $PART -force

# ============================================================
# Add DUT
# ============================================================

puts ""
puts "Adding DUT RTL..."

add_files ./rtl/counter.sv

# ============================================================
# Add Testbench
# ============================================================

puts ""
puts "Adding testbench..."

add_files -fileset sim_1 ./tb/tb_counter.sv

# ============================================================
# Set simulation top
# ============================================================

set_property top tb_counter [get_filesets sim_1]

# Update compile order
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts ""
puts "============================================================"
puts "Starting simulation..."
puts "============================================================"
puts ""

# ============================================================
# Launch simulation
# ============================================================

launch_simulation -mode batch

# Run simulation
run 200 ns

puts ""
puts "============================================================"
puts "Simulation finished."
puts "============================================================"
puts ""

# Close simulation
close_sim

# Close project
close_project

puts "Vivado simulation completed."

exit 0
