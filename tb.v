module	tb	;
	
	reg		DoorClose	;
	reg		Ignition	;
	reg		SeatBelt	;
	
	wire		Alarm		;
	
	carWarning3	DUT2(	.Alarm		( Alarm		), 
				.DoorClose	( DoorClose	), 
				.Ignition	( Ignition	), 
				.SeatBelt	( SeatBelt	));

	initial begin
		DoorClose	= 1'b1	;	//door closed
		Ignition	= 1'b0	;	//igniton off
		SeatBelt	= 1'b0	;	//no seatbelt
	end

	always begin
	#(100)
		DoorClose	= 1'b0	;	//door opened
		Ignition	= 1'b0	;
		SeatBelt	= 1'b0	;

	#(100)
		DoorClose	= 1'b0	;	
		Ignition	= 1'b1	;	//ignition on(gate open)
		SeatBelt	= 1'b0	;

	#(100)
		DoorClose	= 1'b1	;	//door closed
		Ignition	= 1'b1	;	
		SeatBelt	= 1'b0	;	//no seabelt, alarm on

	#(100)
		DoorClose	= 1'b1	;	
		Ignition	= 1'b1	;
		SeatBelt	= 1'b1	;	//seatbelt, alarm off

	#(100)
		$finish		;
	end

endmodule
