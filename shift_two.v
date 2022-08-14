module shift_two

#(
parameter WIDTH =4
)


(

input wire [WIDTH-1:0] IN,
output wire [WIDTH-1:0] OUT

);


assign OUT = IN << 2;

endmodule