# Xapo Test app
## Techical features
- App is written in Swift UI supporting all devices with iOS 13 and up
- Architecture is MVVM with UseCases and Services (it is combo Viber and MVVM, but it does not have Cordinators, because unfortunatlly swiftUI does not really work well with them)
- All not view functionality has unit test
- I used the same test file structure like Facebook recomends for react, so the test files are next to the implentation files (in the same folder, but in a diffrent project target), for me it makes a huge diffrence, they are always there, so i use them more
## UI features
- Custom transition
- iPad and iPhone UI (same UI Composed in 2 diffrent ways)
