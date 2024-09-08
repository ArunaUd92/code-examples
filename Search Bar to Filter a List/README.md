# Searchable Paginated Task List App

This is a SwiftUI-based iOS application that demonstrates how to fetch, display, and paginate a list of tasks from an online API. The app includes a search bar that allows users to filter tasks and supports loading data incrementally with pagination. The tasks are fetched from the DummyJSON API.

## Features

- **Task List**: Displays a list of tasks, each with a description and completion status.
- **Pagination**: Loads tasks in chunks using pagination, fetching more data as the user scrolls to the bottom.
- **Search**: Users can search the list of tasks by their description using a built-in search bar.
- **API Integration**:  Fetches tasks from the DummyJSON API and dynamically updates the task list.

## Features

- **SwiftUI**: For building the user interface.
- **URLSession**: To make HTTP requests to the DummyJSON API.
- **JSONDecoder**: To decode the JSON response from the API into Swift objects.
- **DummyJSON API**: A fake online REST API used for testing and prototyping.

## API

Example API Response:

```
{
  "todos": [
    {
      "id": 1,
      "todo": "Do something nice for someone I care about",
      "completed": true
    },
    {
      "id": 2,
      "todo": "Memorize the fifty states and their capitals",
      "completed": false
    }
  ],
  "total": 150,
  "skip": 0,
  "limit": 30
}

```
## Screenshots


