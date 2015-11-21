-module(producer).
-export([init/2]).

init(Master, Table) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "The sushi-man has been created!",
	Master ! {Pid, message, Msg}.

loop() ->
	receive
		{From, Msg} ->
			io:format("~w sent me: ", [From]),
			io:format("~w~n", [Msg])
	end.