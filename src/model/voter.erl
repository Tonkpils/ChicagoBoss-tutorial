-module(voter, [Id, FirstName, LastName, Address, Notes, WardBossId]).
-compile(export_all).
-belongs_to(ward_boss).

validation_tests() ->
		[{fun() -> length(FirstName) > 0 end,
						"Please enter a first name"},
				{fun() -> length(LastName) > 0 end,
						"Please enter a last name"},
				{fun() -> string:str(Address, "Chicago") > 0 end,
						"Address is not in Chicago!! What good is that??"}].