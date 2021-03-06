# follower

**follower** is a basic MapKit app written in Swift for following a users location and showing some stats

<img src="https://i.imgur.com/lNT9H5j.png" width="200"> <img src="https://imgur.com/JpPKxkz.png" width="200">

## Installation

**follower** uses [xcodegen](https://github.com/yonaskolb/XcodeGen) to generate it's .xcodeproj

After installing xcodegen move to the project directory and run `xcodegen`

```bash
brew install xcodegen
cd follower
xcodegen
```

You should now see the project being generated

```bash
⚙️  Generating plists...
⚙️  Generating project...
⚙️  Writing project...
Created project at /Users/luke/follower/follower.xcodeproj
```

Now you can open the project

```bash
open follower.xcodeproj 
```

## Manual Testing

To manually test **follower**
1. Launch the xcode project
2. Select a test device
3. Hit build and run `cmd + r`
4. When prompted accept location permissions
5. To simulate location using simulator navigate to `Debug > Location > Freeway Drive`
6. Tap 'Start Following' to start the tracking
7. Tapping 'Stop Following' stops tracking and focuses on the route with start and end markers.
8. Tapping on 'View Stats' opens the stats view containing total distance, duration and average speed.
9. Tapping 'Clear Session' removes all stored locations and map overlays
10. When open, the stats view updates every second.

*Note: data does not currently persist across app lifecylces, quitting the app will lose your session data.*

## Automated Testing

**follower** includes some simple automated tests:
- `FStatsHelper` class method unit tests
- UI tests for map and stats views

To run the tests launch the xcode project, select a test device and hit `cmd + u`