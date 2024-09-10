# Paginated Task List App

This SwiftUI-based iOS application demonstrates how to load and display a large list of tasks in chunks with pagination. The app loads data incrementally as the user scrolls, showing a progress indicator at the bottom of the list while more tasks are fetched. This approach helps to improve performance and user experience when handling large datasets.

## Features

- **Pagination**: Loads tasks incrementally in pages as the user scrolls, instead of loading all tasks at once.
- **Bottom Loading Indicator**: A `ProgressView` is displayed at the bottom of the list while fetching more tasks, providing clear feedback to the user.
- **Simulated Data Loading**: Tasks are generated and loaded in a simulated API-like environment, with a delay to mimic network calls.
- **Customizable Task Display**: Each task includes a name, category, due date, and size (priority level), and is displayed with a clean, simple UI.

## Screenshots

![](https://github.com/ArunaUd92/code-examples/blob/main/PaginatedListView/Screenshot_01.png)
