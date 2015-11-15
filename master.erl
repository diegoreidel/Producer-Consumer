-module(master).
-export([go/1]).

go(Msg) ->
	Pid2 = spawn(producer, loop, []),
	Pid2 ! {self(), Msg}.
