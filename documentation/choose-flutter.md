# Choose Mobile App Supporting With Back End Service

## Context

- Skill level
  - Limited react knowledge
  - Basic flutter knowledge (one personal project created prior)
  - Good knowledge of C#
- Time constraints
  - To learn react and get a reasonable app created
  - Time availbale after work to work on project

## Decision

Create multiple projects, front end with flutter and back end with C#

### Why

A mobile app allows for easy portability of the tea maker along with the abilty to store the relavent information locally on the device. A supporting back end application allows for a separation of concerns regarding the main logic. In addition further logic can be added without relying on the front end application to do the heavy lifting which could harm performance.

Using flutter enables a front end application to be created without the steep learning curve of learning react from scratch. A foundational knowledge of flutter was enough to provide confidence in producing both a front end application and back end application.

## Consequences

### Positive

- Seperation of concerns with logic being in the back end application allows scalability.
- Flutter is designed to be cross platform. Enabling android, ios and web applications (amongst others) to be created from one codebase

### Negative

- The app will not work offline due to the BE api being required (a basic offline mode could be created usiing [dart:math](https://api.flutter.dev/flutter/dart-math/Random-class.html))
- Potentially more user interactions to consider when developing a mobile app
