-module(segfault).

-export([load/0]).
-export([generate/0]).

-on_load(load/0).

load() ->
    PrivDir = case code:priv_dir(?MODULE) of
                  {error, _} ->
                      EbinDir = filename:dirname(code:which(?MODULE)),
                      AppPath = filename:dirname(EbinDir),
                      filename:join(AppPath, "priv");
                  Path ->
                      Path
              end,
    erlang:load_nif(filename:join(PrivDir, "segfault"), none).

generate() ->
    erlang:nif_error(not_loaded).
