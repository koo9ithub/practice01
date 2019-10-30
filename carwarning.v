//gate level
module	carWarning(Alarm, DoorClose, Ignition, SeatBelt);

	//in, out
	output		Alarm		;
	
	input		DoorClose	;
	input		Ignition	;
	input		SeatBelt	;

	wire		DoorOpened	;
	wire		NoSeatBelt	;

	not		NOT_U0(DoorOpened, DoorClose)		;
	not		NOT_U1(NoSeatBelt, SeatBelt)		;

	wire		Node1		;
	wire		Node2		;

	and		AND_U0(Node1, DoorOpened, Ignition)	;
	and		AND_U1(Node2, NoSeatBelt, Ignition)		;

	or		OR_U0(Alarm, Node1, Node2)		;

endmodule


//dataflow level
module	carWarning2(Alarm, DoorClose, Ignition, SeatBelt);

	//in, out
	output		Alarm		;
	
	input		DoorClose	;
	input		Ignition	;
	input		SeatBelt	;

	wire		DoorOpened	;
	wire		NoSeatBelt	;
	
	assign		DoorOpened	= ~DoorClose		;
	assign		NoSeatBelt	= ~SeatBelt		;	//not gate

	wire		Node1		;
	wire		Node2		;

	assign		Node1		= DoorOpened & Ignition	;
	assign		Node2		= NoSeatBelt & Ignition	;	//and gate
	
	assign		Alarm		= Node1 | Node2		;	//or gate

endmodule


//behavioral level
module	carWarning3(Alarm, DoorClose, Ignition, SeatBelt);

	//in, out
	output		Alarm		;
	
	input		DoorClose	;
	input		Ignition	;
	input		SeatBelt	;

	reg		DoorOpened	;

	always @(DoorClose)	begin
		DoorOpened	= ~DoorClose;
	end

	reg		NoSeatBelt	;

	always @(SeatBelt)	begin
		NoSeatBelt	= ~SeatBelt;
	end								//not gate

	reg		Node1	;

	always @(DoorOpened or Ignition)	begin
		Node1		= DoorOpened & Ignition	;
	end

	reg		Node2	;

	always @(DoorOpened or Ignition)	begin
		Node2		= NoSeatBelt & Ignition	;
	end								//and gate

	reg		Alarm	;

	always @(Node1 or Node2)	begin
		Alarm		= Node1 | Node2		;
	end								//or gate

endmodule

