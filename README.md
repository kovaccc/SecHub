# sechub
SecureHub is Flutter application whose purpose is to capture the environment and save the video to the server so it can be used in case of security breach.

## About
Flutter project that has it's own communication with backend (https://okp-backend.deepq.io). The API is based on the REST architecture and app is using Retrofit with POST method to send video file request to service. The request is sent as multipart data.

## Features
The flutter app lets you:

- Capture video
- Send video to backend service
- Get error message in case of unsuccessful upload

## Tech-stack
- flutter_bloc and equatable
- retrofit
- injectable, get_it
- camera

## Screenshots
![image](https://user-images.githubusercontent.com/75457058/160291754-387851c8-e4d3-4924-b04b-d45e246e2ee6.png)
![image](https://user-images.githubusercontent.com/75457058/160291760-b90aa4f0-2818-4758-a4b4-9832a50b4620.png)
![image](https://user-images.githubusercontent.com/75457058/160292000-74d8c4a4-7017-41f7-b6d1-01db771a9668.png)

## Permissions
SecureHub requires the following permissions in AndroidManifest.xml:

- Internet permission is used because application code needs Internet access

## Setup
Clone the repository
- https://github.com/kovaccc/SecHub.git

### Android
- Open the project with your IDE/Code Editor
- Run it on simulator or real Android device

### iOS
- Open the project with Xcode
- Run it on real iOS device
- Do not forget to run "pod install" in ios directory to manage library dependencies for your Xcode project before building application on iOS device
