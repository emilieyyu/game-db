#find shortest path from starting location to goal, returning path taken and cost

from Queue import PriorityQueue

#for finding path from start location to destination
#parameters: size of n for graph, start, goal, values of graph
def path_find(n, start_loc, goal_loc, values):
    frontier = PriorityQueue()
    frontier.put((0, [start_loc]))
    least_cost_path = 0
    visited = []
    current_list = [(start_loc)]
    
    #while not empty
    while not frontier.empty(): 
        cost, current_list = frontier.get()
        current = current_list[-1]
    #not visited
        if current not in visited:
            visited.append(current)
            #when current location = goal
            if current == goal_loc: 
                return cost, current_list
            next = neighbours(n, current)

            for neighbour in next:
                if neighbour not in visited:
                    row = neighbour[0]
                    col = neighbour[1]
                    #calculating cost
                    least_cost_path = cost + values[row - 1][col - 1] + 1  
                    previous = list(current_list)
                    previous.append((row,col))
                    frontier.put((least_cost_path, previous))
    return least_cost_path, current_list

#function for checking grid located in four directions (up down left right) of current location
#parameters: size of n for graph, current location
def neighbours(n, current):
    row = current[0]
    column = current[1]
    next = []
    # checking movement options
    if row != 1:
        next.append((row-1, column))
    if row != n:
        next.append((row+1, column))
    if column != 1:
        next.append((row, column-1))
    if column != n:
        next.append((row, column+1))
    return next

# test cases
#1. List is empty
#cost,least_cost_path = path_find (0, (0, 0), (0, 0), [])
#Outputs: [(0, 0)]
#0
# 2. Only one value in list
#cost,least_cost_path = path_find (1, (1, 1), (1, 1), [5])
#Outputs: [(1, 1)]
#0
#3. When start = destination
#cost,least_cost_path = path_find (5, (3, 3), (3, 5), [[4,3,3,2,4],[2,3,4,5,2],[3,4,5,3,2],[2,4,4,2,2],[4,3,3,4,2]])
#Outputs: [(3, 3)]
#0
#4. Corner Case1: Top left to bottom right
#cost,least_cost_path = path_find (5, (5, 1), (1, 5), [[4,3,3,2,4], [2,3,4,5,2], [3,4,5,3,2], [2,4,4,2,2], [4,3,3,4,2]])
#Outputs: [(5, 1), (4, 1), (3, 1), (2, 1), (2, 2), (1, 2), (1, 3), (1, 4), (1, 5)]
#30
#5. Corner Case2: Top right to bottom left
#cost,least_cost_path = path_find (5, (5, 5), (1, 1), [[4,3,3,2,4], [2,3,4,5,2], [3,4,5,3,2], [2,4,4,2,2], [4,3,3,4,2]])
#Outputs: [(5, 5), (4, 5), (3, 5), (2, 5), (1, 5), (1, 4), (1, 3), (1, 2), (1, 1)]
#30
#6. When input out of bounds
#cost,least_cost_path = path_find (5, (6, 6), (1, 1), [[4,3,3,2,4], [2,3,4,5,2], [3,4,5,3,2], [2,4,4,2,2], [4,3,3,4,2]])
#Outputs: IndexError: list index out of range
#7. Test Case given
#cost,least_cost_path = path_find(5, (1, 2), (5, 4), [[4,3,3,2,4], [2,3,4,5,2], [3,4,5,3,2], [2,4,4,2,2], [4,3,3,4,2]])
#Outputs: [(1, 1), (2, 1), (3, 1), (4, 1), (4, 2), (4, 3), (4, 4), (5, 4)]
#25

#main
cost,least_cost_path = path_find(5, (1, 2), (5, 4), [[4,3,3,2,4], [2,3,4,5,2], [3,4,5,3,2], [2,4,4,2,2], [4,3,3,4,2]])
print (least_cost_path)
print (cost)
