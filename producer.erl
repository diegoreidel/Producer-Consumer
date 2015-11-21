-module(producer).
-export([init/1]).

init(Table) ->
	

loop() ->
	receive
		{From, Msg} ->
			io:format("~w sent me: ", [From]),
			io:format("~w~n", [Msg])
	end.