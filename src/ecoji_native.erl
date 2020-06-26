-module(ecoji_native).

-export([int_to_utf8/1]).
-export([main/0]).

int_to_utf8(X) ->
  try
    {ok, <<X/utf8>>}
  catch
    _:_ -> {error, nil}
  end.

main() ->
  A = <<240,159,145,149>>,
  Padding = <<226,152,149>>,
  <<A/utf8, Padding/utf8, Padding/utf8, Padding/utf8>>.
