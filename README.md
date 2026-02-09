BookletMaker allows to transform PDF books or pechas into booklet-formats suitable for double-sided printing.

![Booklet-Maker UI](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/BookletMaker.jpg?raw=true)

### Resulting PDFs

Print-ready examples:

| 3 pechas per page | A5 booklet | A6 booklet |
| - | - | - |
| ![3 pecha pages](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/pecha_3.jpg?raw=true) | ![booklet a5](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/booklet_a5.jpg?raw=true) | ![booklet a6](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/booklet_a6.jpg?raw=true) |

## Installation and Build

Either clone the source code and use Xcode to build the application, or use the provided ready-to-run application.

### Install release version

The 'Releases' area (on the right) includes the latest pre-compiled version of BookletMaker for macOS versions 10.13 and newer, latest tested version is macOS Tahoe 26.2.

- Download [Booklet-maker.zip](https://github.com/DigitalTibetan/BookletMaker/releases/download/0.4/Booklet-maker-0.4.0.zip). (Currently 0.4, check release section on the right, if newer versions are available)
- Unpack the archive and try to start Booklet-maker.app.
- Since the application is not signed, you will get the options to trash the application, or press 'Done'. Press Done.
- Now to allow the start of the app:
- In macOS "System Settings", go to "Privacy and Security", scroll all the way down, until you see an option to "Start anyway".
- After yet another suggestion to move the application to trash, or start, it should finally work.


| First Warning | System Settings, Security | Second Warning |
| - | - | - |
| ![Warning 1](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/apple_trash_1.jpg?raw=true) | ![settings](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/apple_anyway.jpg?raw=true) | ![Warning 2](https://github.com/DigitalTibetan/BookletMaker/blob/main/Doc/apple_trash_2.jpg?raw=true) |

Remember, the full source code is available in this repository, and you can always build the entire application yourself and provide your own signing keys.

## History

- 2026-02-09: Update 0.4.0 fixes resolution degradation on transforms. (Tx. P.F.)
