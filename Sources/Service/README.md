# Service layer

## HttpClient sublayer

Hosts the web interactor, which serves as the barrier between the app and the internet. Its only responsability is to interact with the outside world via HTTP, and should, therefore, have no knowledge of any internal types, interacting only through `Data`.

This is basically a glorified wrapper around whatever is sending the requests.

## Data Transfer Object (DTO) sublayer

Holds the data as returned from the internet translated as a `Swift` type, with minimal to no treatment. An `internal` Data layer, if you will.

## Application Programming Interface (API) sublayer

Responsible for pointing the `HttpClient` to each relevant endpoint of a particular API, and decode the returned `Data` to its corresponding DTO. 

Each function in an API should correspond to one, and only one, call to an endpoint, receiving all necessary information to do so as arguments, and return the corresponding data decoded in the relevant DTO.

## Service sublayer

Responsible for retrieving the information needed by the app, and transforming it to correspond with the way the app expects the it to be presented (aka, the stuff in the `Data` layer).