-module(evening_greeting_controller, [Req]).
-compile(export_all).

index('GET', []) ->
    SavedGreetings = boss_db:find(greeting, []),
    FirstGreeting = hd(SavedGreetings),
    {output, FirstGreeting:greeting_text()}.