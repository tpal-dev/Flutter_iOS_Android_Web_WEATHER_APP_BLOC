# Weather App - BloC Pattern + Unit Tests

A Flutter application created on the iOS, Android, desktop and web.

## Description

Weather app, based on live weather data in the current location of the device as well as the weather for any city. Application use API OpenWeatherMap. <br>

You can find here:

- Bloc Architecture 

![alt text](https://i.ibb.co/jWQ7B3j/bloc-architecture.png)

- How to use a BloC and Cubits to separate presentation from business logic.
- Hydrated Bloc package which automatically persists and restores bloc and cubit states.
- Generated Routing & Access
- Use API to get data from the internet.
- How to network with the Dart http package.
- Parse JSONs are and  them using the Dart convert package.

TODO:
- Geolocator package to get live location data.
- Unit tests

## Flutter packages
- flutter_bloc: ^7.2.0
- equatable: ^2.0.3
- http: ^0.13.3
- hydrated_bloc: ^7.0.1
- path_provider: ^2.0.2

## analysis_options.yaml
```
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    invalid_use_of_protected_member: error
    missing_return: error
    must_be_immutable: error
    must_call_super: error
    parameter_assignments: error
    sort_unnamed_constructors_first: ignore
  #    sort_pub_dependencies: ignore

  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"

linter:
  rules:
    always_put_required_named_parameters_first: false
    always_specify_types: false
    avoid_classes_with_only_static_members: false
    avoid_print: false
    lines_longer_than_80_chars: true
    prefer_single_quotes: true
    prefer_double_quotes: false
    public_member_api_docs: false
    sort_constructors_first: true

```

### Flutter documentation
For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), tutorials,
samples, guidance on mobile development, and a full API reference.
