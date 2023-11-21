class Graph {
  final List<Edge> edges;
  final int vertices;

  Graph(this.vertices, this.edges);
}

class Edge {
  final int source, destination, weight;

  Edge(this.source, this.destination, this.weight);
}

class BellmanFord {
  static List<int> bellmanFord(Graph graph, int source) {
    List<int> distances = List.filled(graph.vertices, double.infinity.toInt());
    distances[source] = 0;

    for (int i = 1; i < graph.vertices - 1; ++i) {
      for (var edge in graph.edges) {
        int u = edge.source;
        int v = edge.destination;
        int weight = edge.weight;
        if (distances[u] != double.infinity.toInt() && distances[u] + weight < distances[v]) {
          distances[v] = distances[u] + weight;
        }
      }
    }

    // Check for negative weight cycles
    for (var edge in graph.edges) {
      int u = edge.source;
      int v = edge.destination;
      int weight = edge.weight;
      if (distances[u] != double.infinity.toInt() && distances[u] + weight < distances[v]) {
        throw Exception("Graph contains negative weight cycle");
      }
    }

    return distances;
  }
}

void main() {
  // Example usage:
  var edges = [
    Edge(0, 1, 6),
    Edge(0, 2, 7),
    Edge(1, 3, 5),
    Edge(1, 4, -4),
    Edge(1, 2, 8),
    Edge(2, 4, 9),
    Edge(2, 5, -7),
    Edge(2, 3, -3),
    Edge(3, 4, 7),
    Edge(4, 5, 10),
  ];

  var graph = Graph(6, edges);
  var sourceNode = 0;

  var distances = BellmanFord.bellmanFord(graph, sourceNode);

  print('Shortest distances from node $sourceNode:');
  for (int i = 0; i < distances.length; i++) {
    print('$i: ${distances[i]}');
  }
}
