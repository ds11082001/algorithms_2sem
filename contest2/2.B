#include <iostream>
#include <queue>
#include <vector>

// Напишем функцию ввода, Дейкстру и структуру CompareThirds для эффективного 
// сравнения пар в очереди.

struct CompareThirds {
    bool operator()(std::vector<int> x, std::vector<int> y) {
        return x[1] > y[1];
    }
};

std::vector<std::vector<std::pair<int, int>>> input(int n, int m) {
    int v, to, cost;
    std::vector<std::vector<std::pair<int, int>>> graph(n);
    for (int i = 0; i < m; ++i){
        std::cin >> v >> to >> cost;
        --v;
        --to;
        graph[v].push_back(std::make_pair(to, cost));
    }
    return graph;
}

int dijkstra(int s, int f, int k, std::vector<std::vector<std::pair<int, int>>> &graph) {
    std::vector<int> dist(graph.size(), 1e9);
    dist[s] = 0;
    std::priority_queue<std::vector<int>, std::vector<std::vector<int>>, CompareThirds> q;
    q.push(std::vector<int>{s, 0, 0});
    while (not q.empty()) {
        long long curVertex = q.top()[0];
        int curDist = q.top()[1];
        int curLen = q.top()[2];
        q.pop();
        if (curDist > dist[curVertex] || curLen >= k) {
            continue;
        }
        for (int i = 0; i < graph[curVertex].size(); ++i) {
            int to = graph[curVertex][i].first;
            int cost = graph[curVertex][i].second;
            if (dist[curVertex] + cost < dist[to]) {
                dist[to] = dist[curVertex] + cost;
                q.push(std::vector<int>{to, dist[to], curLen + 1});
            }
        }
    }
    return dist[f];
}

int main() {
    int n, m, k, s, f;
    std::cin >> n >> m >> k >> s >> f;
    --s;
    --f;
    std::vector<std::vector<std::pair<int, int>>> graph = input(n, m);
    int answer = dijkstra(s, f, k, graph);
    if (answer == 1e9) {
        answer = -1;
    }
    std::cout << answer;
    return 0;
}
