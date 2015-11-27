-module(product).
-export([init/2]).

init(Producer, Id) -> loop(Producer, Id).

loop(Producer, Id) ->
	receive
		{From, getID} ->
			From ! {Id, sushi},
			loop(Producer, Id);
		eaten ->
			true
	end.


