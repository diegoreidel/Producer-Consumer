-module(producer).
-export([init/2]).

init(Master, Table) ->
	Pid = self(),
	Msg = "The sushi-man has been created!",
	Master ! {Pid, message, Msg},

	loop(Master, Table, 1, 1000).

loop(Master, Table, SushiId, Hush) ->
	Self = self(),
	timer:sleep(Hush),
	makeSushi(Table, SushiId),
	receive
		full ->
			Msg = "There's no space on the table, so I am going to take a rest now!",
			Master ! {Self, message, Msg},
			loop(Master, Table, SushiId+1, 10000);
		done ->
			loop(Master, Table, SushiId+1, 1000)
	end.

makeSushi(Table, SushiId) ->
	Self = self(),
	Sushi = spawn(product, init, [Self, SushiId]),
	Table ! {Self, Sushi, sushiReady}.