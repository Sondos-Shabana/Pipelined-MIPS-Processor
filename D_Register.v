module D_Register ( 
    //DR at the end of the i/p & o/p ports names referred to Decode Register
    //(meaning Register between Decode & Excute Stage)        **//RegD register bits table**
    input              CLK_DReg,CLR_DReg,RST_DReg,             //RegWriteDR     -->   [102]
    input              RegWriteDR,RegDstDR,                    //MemtoRegDR     -->   [101]
    input              MemtoRegDR,MemWriteDR,                  //MemWriteDR     -->   [100]
    input              ALUSrcDR,                               //ALUControlDR   -->   [99:97]
    input      [  2:0] ALUControlDR,                           //ALUSrcDR       -->   [96]
    input      [  4:0] RsDR,RtDR,RdDR,                         //RegDstDR       -->   [95]
    input      [ 31:0] Op1DR,Op2DR,                            //Op1DR          -->   [94:63]
    input      [ 15:0] SignImmDR,                              //Op2DR          -->   [62:31]
    output reg [102:0] RegD                                    //RsDR           -->   [30:26]
);                                                             //RtDR           -->   [25:21]
                                                               //RdDR           -->   [20:16]
reg [102:0] signal_RegD;                                       //SignImmDR      -->   [15:0]

always@ (*)
begin
    if((!RST_DReg) | CLR_DReg)
    begin
        signal_RegD = 103'b0;
    end
    else
    begin
        //                [102]      [101]     [100]      [99:97]      [96]     [95]    [94:63][62:31][30:26][25:21][20:16]  [15:0]
        signal_RegD = {RegWriteDR,MemtoRegDR,MemWriteDR,ALUControlDR,ALUSrcDR,RegDstDR,  Op1DR,  Op2DR,  RsDR,  RtDR,  RdDR,SignImmDR};
    end
end

always@ (posedge CLK_DReg)
begin
    RegD <= signal_RegD;
end

endmodule