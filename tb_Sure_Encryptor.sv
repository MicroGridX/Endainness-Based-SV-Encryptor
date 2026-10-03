module tb_Sure_Encryptor;

    logic        clk;
    logic        rst;
    logic        start;
    logic [1:0]  mode;
    logic [63:0] din;

    logic        serial_out;
    logic        busy;

    Sure_Encryptor dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .mode(mode),
        .din(din),
        .serial_out(serial_out),
        .busy(busy)
    );

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        rst   = 1;
        start = 0;
        mode  = 2'b00;
        din   = 64'h0123456789ABCDEF;

        #10;
        rst = 0;

        for (int m = 0; m < 4; m++) begin

            mode = m[1:0];

            #10;
            start = 1;

            @(posedge clk);
            #1;
            start = 0;

            case (mode)
                2'b00: $display("\nMODE 00 : BYTE BIG-ENDIAN + BIT BIG-ENDIAN");
                2'b01: $display("\nMODE 01 : BYTE BIG-ENDIAN + BIT LITTLE-ENDIAN");
                2'b10: $display("\nMODE 10 : BYTE LITTLE-ENDIAN + BIT BIG-ENDIAN");
                2'b11: $display("\nMODE 11 : BYTE LITTLE-ENDIAN + BIT LITTLE-ENDIAN");
            endcase

            $display("Input  = %h", din);
            $write("Output = ");

            for (int i = 0; i < 64; i++) begin
                @(posedge clk);
                #1;
                $write("%b", serial_out);
            end

            $display("\n-----------------------------------------------");
            #10;
        end

        $finish;
    end

endmodule
