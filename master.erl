-module(master).
-export([init/0]).

init() ->
	
	Pid 	= self(),
	Table 	=  createSushiTable(Pid),
	loop(Table).

createSushiTable(Pid) ->
	spawn(bufferMemory, init, [Pid]).

loop(Table) ->
	
	receive
		{From, message, Msg} ->
			showMessage(From, [Msg]),
			List = [1],
			ListB = [2],
			Table ! {List, sushiReady},
			Table ! {ListB, sushiReady},
			loop(Table);

		stop ->
			true
	end.

showMessage(From, Msg) ->
	io:format("~p says: ~p~n", [From, Msg]).



