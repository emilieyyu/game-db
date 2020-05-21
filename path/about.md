## About
The purpose of this program is to find the shortest path to take between start and goal location. 

Language: Python

## Example 
  ```
  least_cost_path =
    path_find (5, (5, 1), (1, 5), [[4,3,3,2,4], [2,3,4,5,2], [3,4,5,3,2],[2,4,4,2,2], [4,3,3,4,2]])
  Path: [(5, 1), (4, 1), (3, 1), (2, 1), (2, 2), (1, 2), (1, 3), (1, 4), (1, 5)]
  Cost: 30
  ```
## Algorithm
The algorithm used is based on Dijkstra's Algorithm for finding the shortest path between the starting and ending position. Dijkstra is a special case of A* search algorithm, and is more commonly used when calculating cost on weighted graphs. Dijkstra has one cost function, which is the value from the source to each node and finds the shortest path by only considering its real cost. The graph has specific values as the cost of movement.
