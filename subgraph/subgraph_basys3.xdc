# ============================================================
# subgraph_basys3.xdc  –  Vollständige Constraints für Basys 3
# Top-Level: subgraph_board
#
# Bedienung:
#   SW[15:0] → Matrix A einstellen → BTNL drücken (LED[9] leuchtet)
#   SW[15:0] → Matrix B einstellen → BTNR drücken (LED[10] leuchtet)
#   BTNC drücken → Berechnung (LED[1] leuchtet wenn fertig)
#
# LED-Anzeige:
#   LED[0]   = Eingabephase (0=warte A, 1=warte B)
#   LED[1]   = done
#   LED[3:2] = result (00/01/10/11)
#   LED[6:4] = lcs_out (0..4)
#   LED[8:7] = best_rot (0..3)
#   LED[9]   = A geladen
#   LED[10]  = B geladen
# ============================================================

# --- Systemtakt 100 MHz ---
set_property PACKAGE_PIN W5   [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 [get_ports clk]

# --- Buttons ---
set_property PACKAGE_PIN T18  [get_ports btnU]
set_property PACKAGE_PIN W19  [get_ports btnL]
set_property PACKAGE_PIN T17  [get_ports btnR]
set_property PACKAGE_PIN U18  [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnU]
set_property IOSTANDARD LVCMOS33 [get_ports btnL]
set_property IOSTANDARD LVCMOS33 [get_ports btnR]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]

# --- Kippschalter SW[15:0] ---
set_property PACKAGE_PIN V17  [get_ports {sw[0]}]
set_property PACKAGE_PIN V16  [get_ports {sw[1]}]
set_property PACKAGE_PIN W16  [get_ports {sw[2]}]
set_property PACKAGE_PIN W17  [get_ports {sw[3]}]
set_property PACKAGE_PIN W15  [get_ports {sw[4]}]
set_property PACKAGE_PIN V15  [get_ports {sw[5]}]
set_property PACKAGE_PIN W14  [get_ports {sw[6]}]
set_property PACKAGE_PIN W13  [get_ports {sw[7]}]
set_property PACKAGE_PIN V2   [get_ports {sw[8]}]
set_property PACKAGE_PIN T3   [get_ports {sw[9]}]
set_property PACKAGE_PIN T2   [get_ports {sw[10]}]
set_property PACKAGE_PIN R3   [get_ports {sw[11]}]
set_property PACKAGE_PIN W2   [get_ports {sw[12]}]
set_property PACKAGE_PIN U1   [get_ports {sw[13]}]
set_property PACKAGE_PIN T1   [get_ports {sw[14]}]
set_property PACKAGE_PIN R2   [get_ports {sw[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]

# --- LEDs LED[15:0] ---
set_property PACKAGE_PIN U16  [get_ports {led[0]}]
set_property PACKAGE_PIN E19  [get_ports {led[1]}]
set_property PACKAGE_PIN U19  [get_ports {led[2]}]
set_property PACKAGE_PIN V19  [get_ports {led[3]}]
set_property PACKAGE_PIN W18  [get_ports {led[4]}]
set_property PACKAGE_PIN U15  [get_ports {led[5]}]
set_property PACKAGE_PIN U14  [get_ports {led[6]}]
set_property PACKAGE_PIN V14  [get_ports {led[7]}]
set_property PACKAGE_PIN V13  [get_ports {led[8]}]
set_property PACKAGE_PIN V3   [get_ports {led[9]}]
set_property PACKAGE_PIN W3   [get_ports {led[10]}]
set_property PACKAGE_PIN U3   [get_ports {led[11]}]
set_property PACKAGE_PIN P3   [get_ports {led[12]}]
set_property PACKAGE_PIN N3   [get_ports {led[13]}]
set_property PACKAGE_PIN P1   [get_ports {led[14]}]
set_property PACKAGE_PIN L1   [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]
