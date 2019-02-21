# Changelog

## [Unreleased]

### Added
- Added authentication screen where you have to provide you [newsapi.org](https://newsapi.org) API key.
- Added stock settings screen where you can choose what symbols to follow.
- Added `width` and `height` properties to `ImagePlaceholder`.

### Changed
- Changed symbol volume chart to show data from more days instead of just showing the values from the current day.

### Fixed
- Fixed standard iOS and android icon.
- Fixed adaptive icon being slightly blurry.
- Auth screen now always validates the stored API key, in case it has been disabled.

## 1.0.3 - 2019-02-12

### Added
- Added screenshots to README.md.
- Added stock data on the front-page screen provided by [iextrading.com](https://iextrading.com/developer).
- Added launcher icons.

## 1.0.2 - 2019-02-08

### Added
- Added new test for the article-screen.
- Added a 'Read More' button for category screens that increase the number of articles displayed on the screen.

### Changed
- Changed the shape of the article-screen `_BottomSheet` to be completely rectangular.
- The article-screen now uses the `ImagePlaceholder` widget instead of an empty container.
- Implemented the `newsapi_client` package instead of the custom http solution in `NewsApiProvider`.
- Changed the way requests are made to `NewsApiProvider` to make it more flexible to use from the front-end.

### Fixed
- Fixed `ArticleList.skeleton()` displaying error.
