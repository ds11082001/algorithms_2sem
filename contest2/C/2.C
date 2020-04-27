#include <iomanip>
#include <iostream>
#include <queue>
#include <vector>

// Опять Дейкстра и функция ввода и сравнение элементов очереди через структуру ComparePairs.
// Для вывода значений с точностью 6 знаков используем функцию setprcision из библиотеки iomanip.

struct ComparePairs {
    bool operator()(std::pair<int, double> x, std::pair<int, double> y) {
        return x.second > y.second;
    }
};

std::vector<std::vector<std::pair<int, double>>> input(int n, int m) {
    int v, to;
    double cost;
    std::vector<std::vector<std::pair<int, double>>> graph(n);
    for (int i = 0; i < m; ++i){
        std::cin >> v >> to >> cost;
        --v;
        --to;
        cost = (double) (cost / 100);
        graph[v].push_back(std::make_pair(to, cost));
        graph[to].push_back(std::make_pair(v, cost));
    }
    return graph;
}

double dijkstra(int s, int f, std::vector<std::vector<std::pair<int, double>>> &graph) {
    std::vector<double> dist(graph.size(), 2);
    dist[s] = 0;
    std::priority_queue<std::pair<int, double>, std::vector<std::pair<int, double>>, ComparePairs> q;
    q.push(std::make_pair(s, 0));
    while (not q.empty()) {
        long long curVertex = q.top().first;
        double curDist = q.top().second;
        q.pop();
        if (curDist > dist[curVertex]) {
            continue;
        }
        for (int i = 0; i < graph[curVertex].size(); ++i) {
            int to = graph[curVertex][i].first;
            double cost = graph[curVertex][i].second;
            if (1 - (1 - dist[curVertex]) * (1 - cost) < dist[to]) {
                dist[to] = 1 - (1 - dist[curVertex]) * (1 - cost);
                q.push(std::make_pair(to, dist[to]));
            }
        }
    }
    return dist[f];
}

int main() {
    int n, m, s, f;
    std::cin >> n >> m >> s >> f;
    --s;
    --f;
    std::vector<std::vector<std::pair<int, double>>> graph = input(n, m);
    double answer = dijkstra(s, f, graph);
    std::cout << std::setprecision(6) << answer;
    return 0;
}
