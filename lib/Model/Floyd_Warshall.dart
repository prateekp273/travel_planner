class Graph {
  final List<List<int>> adjacencyMatrix;

  Graph(this.adjacencyMatrix);
}

class FloydWarshall {
  static List<List<int>> floydWarshall(Graph graph) {
    int vertices = graph.adjacencyMatrix.length;
    List<List<int>> distances = List.generate(vertices, (index) => List<int>.from(graph.adjacencyMatrix[index]));

    for (int k = 0; k < vertices; k++) {
      for (int i = 0; i < vertices; i++) {
        for (int j = 0; j < vertices; j++) {
          if (distances[i][k] != double.infinity.toInt() &&
              distances[k][j] != double.infinity.toInt() &&
              distances[i][k] + distances[k][j] < distances[i][j]) {
            distances[i][j] = distances[i][k] + distances[k][j];
          }
        }
      }
    }

    return distances;
  }
}

void main() {
  // Example usage:
  var adjacencyMatrix = [
    [0, 3, double.infinity.toInt(), 2],
    [4, 0, 6, double.infinity.toInt()],
    [double.infinity.toInt(), double.infinity.toInt(), 0, 7],
    [double.infinity.toInt(), 1, double.infinity.toInt(), 0],
  ];

  var graph = Graph(adjacencyMatrix);

  var result = FloydWarshall.floydWarshall(graph);

  print('Shortest distances between nodes:');
  for (int i = 0; i < result.length; i++) {
    for (int j = 0; j < result[i].length; j++) {
      print('$i to $j: ${result[i][j]}');
    }
  }
}
