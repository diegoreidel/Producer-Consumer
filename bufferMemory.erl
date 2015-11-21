-module(bufferMemory).
-export([loop/1]).

loop(Master) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "I have been created!",
	Master ! {Pid, message, Msg}.