# Changelog

## [Unreleased]

### Added
- Added new test for the article-screen.

### Changed
- Changed the shape of the article-screen `_BottomSheet` to be completely rectangular.
- The article-screen now uses the `ImagePlaceholder` widget instead of an empty container.
- Implemented the `newsapi_client` package instead of the custom http solution in `NewsApiProvider`.

### Fixed
- Fixed `ArticleList.skeleton()` displaying error.