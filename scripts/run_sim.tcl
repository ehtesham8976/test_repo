puts ""
puts "============================================================"
puts "        VIVADO AUTOMATED SIMULATION"
puts "============================================================"
puts ""

set PART "xc7a100tcsg324-1"
set PROJECT_DIR "./vivado_project"

if {[file exists $PROJECT_DIR]} {
    file delete -force $PROJECT_DIR
}

puts "Creating Vivado project..."

create_project counter_sim $PROJECT_DIR -part $PART -force

puts ""
puts "Adding DUT RTL..."

add_files ./rtl/counter.sv

puts ""
puts "Adding testbench..."

add_files -fileset sim_1 ./tb/tb_counter.sv

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top tb_counter [get_filesets sim_1]

puts ""
puts "============================================================"
puts "Starting simulation..."
puts "============================================================"
puts ""

launch_simulation

run 200 ns

puts ""
puts "============================================================"
puts "Simulation finished."
puts "============================================================"
puts ""

close_sim
close_project

puts "Vivado simulation completed."

exit 0
