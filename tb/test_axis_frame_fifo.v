/*

Copyright (c) 2014 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1 ns / 1 ps

module test_axis_frame_fifo;

// Inputs
reg clk = 0;
reg rst = 0;
reg [7:0] current_test = 0;

reg [7:0] input_axis_tdata = 0;
reg input_axis_tvalid = 0;
reg input_axis_tlast = 0;
reg input_axis_tuser = 0;
reg output_axis_tready = 0;

// Outputs
wire input_axis_tready;
wire [7:0] output_axis_tdata;
wire output_axis_tvalid;
wire output_axis_tlast;

initial begin
    // myhdl integration
    $from_myhdl(clk,
                rst,
                current_test,
                input_axis_tdata,
                input_axis_tvalid,
                input_axis_tlast,
                input_axis_tuser,
                output_axis_tready);
    $to_myhdl(input_axis_tready,
              output_axis_tdata,
              output_axis_tvalid,
              output_axis_tlast);

    // dump file
    $dumpfile("test_axis_frame_fifo.lxt");
    $dumpvars(0, test_axis_frame_fifo);
end

axis_frame_fifo #(
    .ADDR_WIDTH(9),
    .DATA_WIDTH(8),
    .DROP_WHEN_FULL(0)
)
UUT (
    .clk(clk),
    .rst(rst),
    // AXI input
    .input_axis_tdata(input_axis_tdata),
    .input_axis_tvalid(input_axis_tvalid),
    .input_axis_tready(input_axis_tready),
    .input_axis_tlast(input_axis_tlast),
    .input_axis_tuser(input_axis_tuser),
    // AXI output
    .output_axis_tdata(output_axis_tdata),
    .output_axis_tvalid(output_axis_tvalid),
    .output_axis_tready(output_axis_tready),
    .output_axis_tlast(output_axis_tlast)
);

endmodule
