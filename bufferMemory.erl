-module(bufferMemory).
-export([init/1]).

init(Master) -> 
	
	timer:sleep(1000),
	Pid = self(),
	Msg = "I have been created!",
	Master ! {Pid, message, Msg},
	Table = [],
	loop(Table, Master).

loop(Table, Master) ->
	Pid = self(),

	receive
		{Sushi, sushiReady} ->
			NewTable = lists:append(Table, Sushi),
			Msg = "A Sushi was added to the table",
			%io:format("Length: ~w, ~w", [length(NewTable), NewTable]),
			Master ! {Pid, message, Msg},

			loop(NewTable, Master);

		stop ->
			true
	end.