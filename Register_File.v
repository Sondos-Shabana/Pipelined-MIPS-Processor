module Register_File (
    input      [ 4:0] A1,A2,A3,
    input      [31:0] WD3,
    input             RST_RegFile,CLK_RegFile,WE3,
    output reg [31:0] RD1,RD2
);

reg [31:0] RegFile [31:0];
reg [31:0] signal_RD1;
reg [31:0] signal_RD2;
integer i;

//combinational cloud block
always@ (*)
begin
    if(!RST_RegFile)
    begin
        signal_RD1 = 32'b0; RD1 = 32'b0;
        signal_RD2 = 32'b0; RD2 = 32'b0;
        for (i=0; i<32; i=i+1)
        begin
            RegFile[i] = 32'b0;
        end
    end
    else
    begin
        signal_RD1 = RegFile[A1];
        signal_RD2 = RegFile[A2];
    end
end

//writing stage (writing happen at first half cycle meaning at rising edge)
always@ (posedge CLK_RegFile)
begin
    if(WE3 && RST_RegFile)
    begin
        RegFile[A3] <= WD3;
    end
end

//reading stage (reading happen at second half cycle meaning at falling edge)
always@ (negedge CLK_RegFile)
begin
    if(RST_RegFile)
    begin
        RD1 <= signal_RD1;
        RD2 <= signal_RD2;
    end
end

endmodule