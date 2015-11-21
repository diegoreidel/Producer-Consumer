-module(master).
-export([go/0]).

go() ->
	
	Pid 	= self(),
	Table 	=  createSushiTable(Pid),
	loop(Table).

createSushiTable(Pid) ->
	spawn(bufferMemory, loop, [Pid]).

loop(Table) ->
	
	receive
		{From, message, Msg} ->
			showMessage(From, [Msg]),
			loop(Table);

		stop ->
			true
	end.

showMessage(From, Msg) ->
	io:format("~p says: ~p~n", [From, Msg]).



