`timescale 1ns/1ps

module tb_counter;

    localparam WIDTH = 4;

    logic clk;
    logic reset;
    logic enable;
    logic [WIDTH-1:0] count;

    integer errors;

    // DUT
    counter #(
        .WIDTH(WIDTH)
    ) dut (
        .clk    (clk),
        .reset  (reset),
        .enable (enable),
        .count  (count)
    );

    // Clock: 10 ns period
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end

    // Test
    initial begin
        errors = 0;

        $display("");
        $display("========================================");
        $display("       COUNTER SIMULATION START");
        $display("========================================");
        $display("");

        // Initial values
        reset  = 1;
        enable = 0;

        // Hold reset for two clock cycles
        repeat (2) @(posedge clk);

        #1;

        if (count !== 0) begin
            $error("FAIL: Counter should be 0 after reset. Got %0d", count);
            errors++;
        end
        else begin
            $display("PASS: Reset test");
        end

        // Release reset and enable counter
        reset  = 0;
        enable = 1;

        // Check count = 1
        @(posedge clk);
        #1;

        if (count !== 1) begin
            $error("FAIL: Expected 1, got %0d", count);
            errors++;
        end
        else begin
            $display("PASS: Count = 1");
        end

        // Check count = 2
        @(posedge clk);
        #1;

        if (count !== 2) begin
            $error("FAIL: Expected 2, got %0d", count);
            errors++;
        end
        else begin
            $display("PASS: Count = 2");
        end

        // Check count = 3
        @(posedge clk);
        #1;

        if (count !== 3) begin
            $error("FAIL: Expected 3, got %0d", count);
            errors++;
        end
        else begin
            $display("PASS: Count = 3");
        end

        // Disable counter
        enable = 0;

        @(posedge clk);
        #1;

        if (count !== 3) begin
            $error("FAIL: Counter changed while disabled. Got %0d", count);
            errors++;
        end
        else begin
            $display("PASS: Enable disable test");
        end

        $display("");
        $display("========================================");

        if (errors == 0) begin
            $display("          ALL TESTS PASSED");
            $display("========================================");
            $display("");

            $finish;
        end
        else begin
            $display("          TESTS FAILED: %0d", errors);
            $display("========================================");
            $display("");

            $fatal(1);
        end
    end

endmodule
