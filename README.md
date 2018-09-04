# Movies

## Notes

* The app is modelled on the VIP architecture.
* I have tried to keep the project very simple, relying on no external frameworks. In reality, I would most likely use a 3rd party networking, or image fetching library.
* I have ignored the id field in the data returned from the API endpoint. It is currently not required but also there is a type mismatch in the data returned. In some cases it is a number and others a string.
* There were no requirements to sort the movies so I have left as returned from the API. If this requirement existed, I would usually treat this as a request parameter, similar to how filter is done in MovieList.FetchMovies.Request.
* I have intentionally left placeholders for routing to movie details in the MatchListRouter.
* The UI tests work but are fragile as they depend on the results returned by the API. i.e. if the results change then the tests break. The best solution to this would be to inject a different MovieSource for integration tests but I couldn't figure out a nice way to do this without relying on getting ProcessInfo which then leaks test data into production code.
* You'll need to select a development team to run on device.
