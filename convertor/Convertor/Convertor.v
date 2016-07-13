module Convertor #(parameter BUS_WIDTH=8, parameter REGISTER_QUANTITY=4)
(
     Register0, Register1, Register2, Register3,
     ReadNextByte,
     Enable,
     ByteReady, 
     McuBus
);

input [BUS_WIDTH-1:0]Register0, Register1, Register2, Register3;
input ReadNextByte, Enable;
output ByteReady;
output [BUS_WIDTH-1:0]McuBus;

wire [BUS_WIDTH-1:0]Register0, Register1, Register2, Register3;
wire ReadNextByte, Enable;
wire [BUS_WIDTH-1:0]RegistersArray[REGISTER_QUANTITY-1:0];
wire ByteReady;
reg [BUS_WIDTH-1:0]McuBus;

reg unsigned [REGISTER_QUANTITY-1:0] Counter = 0;

assign RegistersArray[0] = Register0;
assign RegistersArray[1] = Register1;
assign RegistersArray[2] = Register2;
assign RegistersArray[3] = Register3;

assign ByteReady = ReadNextByte?1:0 & Enable;

always @(posedge ReadNextByte)
begin
	if(Enable)
	begin
		McuBus = RegistersArray[Counter];
		Counter = Counter + 1;
	end
end

endmodule
