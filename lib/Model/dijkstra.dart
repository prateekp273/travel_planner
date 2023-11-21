class Graph {
  final Map<String, Map<String, int>> _adjacencyList;

  Graph(this._adjacencyList);

  Map<String, int> dijkstra(String startNode) {
    Map<String, int> distances = {};
    Set<String> visitedNodes = Set<String>();

    // Initialize distances with infinity and start node with 0
    _adjacencyList.keys.forEach((node) {
      distances[node] = double.infinity.toInt();
    });
    distances[startNode] = 0;

    while (visitedNodes.length < _adjacencyList.length) {
      String currentNode = _getClosestNode(distances, visitedNodes);
      visitedNodes.add(currentNode);

      if (_adjacencyList.containsKey(currentNode)) {
        for (var neighbor in _adjacencyList[currentNode]!.keys) {
          int distance = distances[currentNode]! + _adjacencyList[currentNode]![neighbor]!;
          if (distance < distances[neighbor]!) {
            distances[neighbor] = distance;
          }
        }
      }
    }

    return distances;
  }

  String _getClosestNode(Map<String, int> distances, Set<String> visitedNodes) {
    String closestNode = '';
    int closestDistance = double.infinity.toInt();

    distances.forEach((node, distance) {
      if (distance < closestDistance && !visitedNodes.contains(node)) {
        closestNode = node;
        closestDistance = distance;
      }
    });

    return closestNode;
  }
}

void main() {
  // Example usage:
  var adjacencyList = {
    'A': {'B': 1, 'C': 4},
    'B': {'A': 1, 'C': 2, 'D': 5},
    'C': {'A': 4, 'B': 2, 'D': 1},
    'D': {'B': 5, 'C': 1},
  };

  var graph = Graph(adjacencyList);
  var startNode = 'A';

  var distances = graph.dijkstra(startNode);

  print('Shortest distances from $startNode:');
  distances.forEach((node, distance) {
    print('$node: $distance');
  });
}
