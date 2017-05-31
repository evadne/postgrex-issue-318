# Reduced Reproduction for Postgrex Issue # 318

If `Postgrex.Notifications` is used with invalid Postgres connection details then the type server exits.

    ➜  evadne-postgrex-issue-318 git:(master) iex -S mix
    Erlang/OTP 19 [erts-8.3] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

    Interactive Elixir (1.4.4) - press Ctrl+C to exit (type h() ENTER for help)
    iex(1)> 
    23:56:55.352 [error] GenServer #PID<0.168.0> terminating
    ** (stop) %DBConnection.ConnectionError{message: "tcp connect (localhost:16384): connection refused - :econnrefused"}
    Last message: nil
    State: [types: Postgrex.DefaultTypes, otp_app: :sample, adapter: Ecto.Adapters.Postgres, username: "hello", password: "world", database: "bogus", hostname: "localhost", port: 16384]

    23:56:55.352 [error] GenServer #PID<0.174.0> terminating
    ** (stop) %DBConnection.ConnectionError{message: "tcp connect (localhost:16384): connection refused - :econnrefused"}
    Last message: nil
    State: [types: Postgrex.DefaultTypes, otp_app: :sample, adapter: Ecto.Adapters.Postgres, username: "hello", password: "world", database: "bogus", hostname: "localhost", port: 16384]

    23:56:55.352 [error] GenServer #PID<0.176.0> terminating
    ** (stop) %DBConnection.ConnectionError{message: "tcp connect (localhost:16384): connection refused - :econnrefused"}
    Last message: nil
    State: [types: Postgrex.DefaultTypes, otp_app: :sample, adapter: Ecto.Adapters.Postgres, username: "hello", password: "world", database: "bogus", hostname: "localhost", port: 16384]

    23:56:55.352 [error] GenServer #PID<0.178.0> terminating
    ** (stop) %DBConnection.ConnectionError{message: "tcp connect (localhost:16384): connection refused - :econnrefused"}
    Last message: nil
    State: [types: Postgrex.DefaultTypes, otp_app: :sample, adapter: Ecto.Adapters.Postgres, username: "hello", password: "world", database: "bogus", hostname: "localhost", port: 16384]

    23:56:55.352 [info]  Application sample exited: shutdown

I’d think that ideally it should just error.
