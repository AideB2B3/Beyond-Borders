# Beyond Borders

> An iOS party game that turns cultural differences into a conversation starter among friends.

![Swift](https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-0D96F6?logo=swift&logoColor=white)
![Platform](https://img.shields.io/badge/iOS-18.0%2B-000000?logo=apple&logoColor=white)

## Overview

Beyond Borders is a digital "pass-and-play" party game for 2–6 people, played on a single device. An animated globe picks a random country; the group chooses a category and, in turn, each player reacts to a statement about that country ("Do you agree?") and has a limited amount of time to explain their answer.

The goal is to offer a light-hearted way to talk about language, food, culture and stereotypes, bringing together different experiences and perceptions within the group.

## Key Features

- **Random country draw** by tapping an animated globe (Lottie), with sound and flag; the *Re-tap* button draws again. There are 27 countries available.
- **Four game categories**: *Language*, *Food*, *Culture*, *Rumors*. Each category contains 20 statements, customized with the name of the drawn country.
- **Turn management**: 2 to 6 players with custom names, random turn order, and a "Next turn" hand-over screen between players.
- **Answer and timer**: Yes/No answer to the statement, followed by a countdown bar with a turn duration configurable from 30 to 600 seconds (in steps of 30) and the option to skip the turn (*Skip*).
- **Final recap** showing each player's answers, with options to start a new match or return home.
- **Onboarding** shown on first launch (the flag is stored with `@AppStorage`) and a screen with the game rules.
- **Localization**: the String Catalog (`Localizable.xcstrings`) includes Italian, Turkish and Hindi translations, in addition to the source language (English).

## Tech Stack

| Area | Technology |
| --- | --- |
| Language | Swift 5 |
| UI | SwiftUI (`NavigationStack`, `fullScreenCover`, `@State`/`@Binding`/`@EnvironmentObject`) |
| Animations | [Lottie](https://github.com/airbnb/lottie-spm) (globe), [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) (GIF) |
| Audio | AVFoundation / AudioToolbox |
| Localization | String Catalog (`.xcstrings`) |
| Font | Atma (bundled with the project) |
| Dependencies | Swift Package Manager |
| Target | iOS 18.0+, iPhone and iPad |

## Installation and Usage

**Requirements:** macOS with an Xcode version able to build for iOS 18 (Xcode 16 or later) and an Internet connection on first launch to download the Swift packages.

```bash
git clone https://github.com/AideB2B3/Beyond-Borders.git
cd Beyond-Borders
open "Beyond Borders.xcodeproj"
```

1. Wait for Xcode to automatically resolve the Swift Package Manager dependencies (Lottie and SDWebImageSwiftUI).
2. Select the **Beyond Borders** scheme and an iOS 18+ simulator (or a device).
3. Press `Cmd + R` to build and run.

How to play: *Start* → set the number of players, names and turn duration → tap the globe to draw a country → choose a category → pass the device to the player whose turn it is.

> Note: the repository contains no automated tests and no backend; the app runs entirely locally.

## Project Structure

```text
Beyond-Borders/
├── Beyond Borders.xcodeproj
├── Beyond-Borders-Info.plist
├── Localizable.xcstrings          # Translations (it, tr, hi)
└── Beyond Borders/
    ├── StartingView/              # Entry point, home, onboarding, match settings, rules
    ├── Countryview/               # Country draw (model + view + GIF)
    ├── CategoryView/              # Category selection and game views (Language, Food, Culture, Offensive/Rumors)
    ├── EndScreen.swift            # Answer recap and final navigation
    ├── Animation/                 # Lottie files (.json)
    ├── Sound/                     # Sound effects (.mp3)
    ├── Font/                      # Atma font
    └── Assets.xcassets/           # Flags, mascots, colors, onboarding and rules images
```

## Future Improvements

- Add new countries, categories and statements, possibly loading them from an external file instead of the code.
- Let players choose the number of rounds in the settings (currently the default value is 1).
- Introduce a scoring or voting system among players.
- Extend localization to the game statements as well (currently defined in English in the code).
- Add automated tests and refactor the four category views, which share most of their logic.

## Authors

Developed by:

- Irem Arslaner (Team Lead)
- [Davide Bellobuono](https://github.com/AideB2B3) (Developer)
- [Christian Ciriello](https://github.com/ChristianCiriello) (Designer)
- [Michele Mariniello](https://github.com/MicheleMariniello) (Developer)
- Supriya Palle (Designer)
- [Fabrizio Vollaro](https://github.com/fabvollaro) (Developer)

## License

The code is released under the MIT License (see the `LICENSE` file). Fonts, animations, images and sounds included in the project may have their own licenses: check the terms of use of each asset before reusing it.
