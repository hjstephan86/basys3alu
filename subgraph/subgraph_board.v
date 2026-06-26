// ============================================================
// subgraph_board.v  –  Board-Wrapper für Basys 3
//
// Das Basys 3 hat nur 16 Kippschalter. Daher werden A und B
// nacheinander über dieselben Schalter eingegeben:
//
//   1. SW[15:0] auf Matrix A einstellen → BTNL drücken (latch A)
//   2. SW[15:0] auf Matrix B einstellen → BTNR drücken (latch B)
//   3. BTNC drücken → Berechnung starten
//
// Anzeige (LEDs):
//   LED[0]    – Eingabe-Status: 0=warte A, 1=warte B
//   LED[1]    – done (Berechnung abgeschlossen)
//   LED[3:2]  – result[1:0]
//   LED[6:4]  – lcs_out[2:0]
//   LED[8:7]  – best_rot[1:0]
//   LED[9]    – A geladen
//   LED[10]   – B geladen
//
// Reset: BTNU
// ============================================================

module subgraph_board (
    input  wire        clk,
    input  wire        btnU,      // Reset
    input  wire        btnL,      // Latch A
    input  wire        btnR,      // Latch B
    input  wire        btnC,      // Start
    input  wire [15:0] sw,        // Eingabe (A oder B)
    output wire [15:0] led        // Statusanzeige
);

    // ── Entprellung der Buttons (ca. 10 ms bei 100 MHz) ──────
    reg [19:0] db_cntL, db_cntR, db_cntC;
    reg        btnL_r, btnR_r, btnC_r;
    reg        btnL_prev, btnR_prev, btnC_prev;
    wire       btnL_pulse, btnR_pulse, btnC_pulse;

    always @(posedge clk) begin
        // Entpreller L
        if (btnL != btnL_r) begin db_cntL <= 0; btnL_r <= btnL; end
        else if (db_cntL < 20'd1000000) db_cntL <= db_cntL + 1;

        // Entpreller R
        if (btnR != btnR_r) begin db_cntR <= 0; btnR_r <= btnR; end
        else if (db_cntR < 20'd1000000) db_cntR <= db_cntR + 1;

        // Entpreller C
        if (btnC != btnC_r) begin db_cntC <= 0; btnC_r <= btnC; end
        else if (db_cntC < 20'd1000000) db_cntC <= db_cntC + 1;

        btnL_prev <= (db_cntL == 20'd999999) ? btnL_r : btnL_prev;
        btnR_prev <= (db_cntR == 20'd999999) ? btnR_r : btnR_prev;
        btnC_prev <= (db_cntC == 20'd999999) ? btnC_r : btnC_prev;
    end

    // Flankendetektoren (steigende Flanke = Puls)
    reg btnL_d, btnR_d, btnC_d;
    always @(posedge clk) begin
        btnL_d <= btnL_r;
        btnR_d <= btnR_r;
        btnC_d <= btnC_r;
    end
    assign btnL_pulse = (btnL_r & ~btnL_d);
    assign btnR_pulse = (btnR_r & ~btnR_d);
    assign btnC_pulse = (btnC_r & ~btnC_d);

    // ── Matrizenspeicher ──────────────────────────────────────
    reg [15:0] reg_A, reg_B;
    reg        a_loaded, b_loaded;
    reg        input_phase;   // 0 = warte auf A, 1 = warte auf B

    wire rst = btnU;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_A      <= 16'b0;
            reg_B      <= 16'b0;
            a_loaded   <= 1'b0;
            b_loaded   <= 1'b0;
            input_phase <= 1'b0;
        end else begin
            if (btnL_pulse) begin
                reg_A      <= sw;
                a_loaded   <= 1'b1;
                input_phase <= 1'b1;   // nach A → warte auf B
            end
            if (btnR_pulse) begin
                reg_B      <= sw;
                b_loaded   <= 1'b1;
            end
        end
    end

    // ── Start-Signal (nur wenn beide geladen) ─────────────────
    wire start = btnC_pulse & a_loaded & b_loaded;

    // ── Subgraph-Kern ─────────────────────────────────────────
    wire [1:0] result;
    wire       done;
    wire [2:0] lcs_out;
    wire [1:0] best_rot;

    subgraph_top u_core (
        .clk      (clk),
        .rst      (rst),
        .start    (start),
        .A        (reg_A),
        .B        (reg_B),
        .result   (result),
        .done     (done),
        .lcs_out  (lcs_out),
        .best_rot (best_rot)
    );

    // ── LED-Zuordnung ─────────────────────────────────────────
    assign led[0]    = input_phase;    // 0=warte A, 1=warte B
    assign led[1]    = done;
    assign led[3:2]  = result;
    assign led[6:4]  = lcs_out;
    assign led[8:7]  = best_rot;
    assign led[9]    = a_loaded;
    assign led[10]   = b_loaded;
    assign led[15:11] = 5'b0;

endmodule
