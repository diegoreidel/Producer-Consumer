-module(consumer).
-export([loop/0]).

loop() ->
	receive
		{From, Msg} ->
			io:format("~w sent me: ", [From]),
			io:format("~w~n", [Msg])
	end.