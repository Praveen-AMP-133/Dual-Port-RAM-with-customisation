`timescale 1ns/1ps
module tb_dual_port_ram;

    parameter DEPTH     = 8;
    parameter WIDTH     = 8;
    localparam ADDR_WIDTH = $clog2(DEPTH);

    reg                   clk_a;
    reg                   clk_b;
    reg  [ADDR_WIDTH-1:0] addr_a;
    reg  [ADDR_WIDTH-1:0] addr_b;
    reg                   wr_en_a;
    reg                   rd_en_b;
    reg  [WIDTH-1:0]      din;
    wire [WIDTH-1:0]      dout;

    // Status flags
    wire full;
    wire empty;
    wire almost_full;
    wire almost_empty;

    dual_port_ram #(
        .DEPTH(DEPTH), 
        .WIDTH(WIDTH)
    ) dut (
        .clk_a        (clk_a),
        .addr_a       (addr_a),
        .clk_b        (clk_b),
        .addr_b       (addr_b),
        .wr_en_a      (wr_en_a),
        .rd_en_b      (rd_en_b),
        .din          (din),
        .dout         (dout),
        .full         (full),
        .empty        (empty),
        .almost_full  (almost_full),
        .almost_empty (almost_empty)
    );

    // Clock generation
    always #4 clk_a = ~clk_a;
    always #7 clk_b = ~clk_b;

    // Write side stimulus
    always @(negedge clk_a) begin
        if (wr_en_a && !full) begin
            din    <= din    + 1;
            addr_a <= addr_a + 1;
        end
    end

    // Read side stimulus
    always @(negedge clk_b) begin
        if (rd_en_b && !empty) begin
            addr_b <= addr_b + 1;
        end
    end

    initial begin
        wr_en_a = 0;
        rd_en_b = 0;
        addr_a  = 0;
        addr_b  = 0;
        din     = 8'hA0;
        clk_a   = 0;
        clk_b   = 0;

        // Start writing
        @(negedge clk_a);
        wr_en_a = 1;

        // Delay then start reading
        repeat(3) @(negedge clk_b);
        rd_en_b = 1;

        #300 $finish;
    end

    // Monitor signals (helps debug flags)
    initial begin
        $monitor("T=%0t | WR=%b RD=%b | addr_a=%0d addr_b=%0d | din=%h dout=%h | FULL=%b EMPTY=%b AF=%b AE=%b",
                  $time, wr_en_a, rd_en_b, addr_a, addr_b, din, dout,
                  full, empty, almost_full, almost_empty);
    end

    initial begin
        $dumpfile("dual_port_ram.vcd");
        $dumpvars(0, tb_dual_port_ram);
    end

endmodule
