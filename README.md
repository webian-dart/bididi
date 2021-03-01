# Bididi

Simple wrapper for Tests in Dart testing so that they are in Behaviour Driven Development Style.
Feature
Scenario
Given When Then

```dart
void main() {
  Feature('Produce an Api Pass', () {
    Scenario("Has valid Api Key", (scenario) {
      MockApi api;
      Service;
      ApiPass pass;
      scenario
         ..given("we have a Api instance with a valid API key", () async {
           api = MockApi.makeMockWithSuccessResponse();
           service = Service(api: api, environment: ENVIRONMENT);
         })
         ..when("we ask it for a pass ", () async {
           pass = await service.makePass();
         })
         ..then("we get a valid Api pass", () async {
           expect(pass, isNot(isA<UnauthorizedPass>()));
           expect(pass.id, equals("id"));
         }); 
    });
  });
}
```
