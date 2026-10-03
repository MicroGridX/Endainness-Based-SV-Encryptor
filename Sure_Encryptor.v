module Sure_Encryptor (
    input  logic        clk,
    input  logic        rst,
    input  logic        start,
    input  logic [1:0]  mode,
    input  logic [63:0] din,
    output logic        serial_out,
    output logic        busy
);

    logic [63:0] ordered_data;
    logic [63:0] shift_reg;
    logic [5:0]  count;

    always_comb begin
        for (int b = 0; b < 8; b++) begin
            for (int k = 0; k < 8; k++) begin

                int byte_sel;
                int bit_sel;

                byte_sel = mode[1] ? (7 - b) : b;
                bit_sel  = mode[0] ? (7 - k) : k;

                ordered_data[63-(b*8+k)] =
                    din[63-(byte_sel*8+bit_sel)];
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg  <= 64'b0;
            serial_out <= 1'b0;
            count      <= 6'd0;
            busy       <= 1'b0;
        end
        else if (start && !busy) begin
            shift_reg  <= ordered_data;
            count      <= 6'd0;
            busy       <= 1'b1;
        end
        else if (busy) begin
            serial_out <= shift_reg[63];

            if (count == 6'd63) begin
                busy <= 1'b0;
            end
            else begin
                shift_reg <= {shift_reg[62:0], 1'b0};
                count <= count + 1'b1;
            end
        end
    end

endmodule
