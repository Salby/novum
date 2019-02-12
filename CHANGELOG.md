# Changelog

## [Unreleased]

### Fixed
- Fixed standard iOS and android icon.
- Fixed adaptive icon being slightly blurry.

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
