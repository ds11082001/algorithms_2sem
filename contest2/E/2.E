#include <iostream>
#include <vector>

// Для поиска количества валюты, которую может получить Рик, воспользовавшись обменником,
// напишем алгоритм Форда-Беллмана, где будем обновлять значение, когда Рик может получить
// больше валюты, чем было. В нашем случае Рик сможет победить систему, если алгоритм найдет
// "отрицательный цикл", т. е. если на последней итерации произошло обновление массива dp.

void input(int m, std::vector<std::pair<int, int>> &graph,
           std::vector<std::pair<double, double>> &conditions,
           std::vector<std::pair<double, double>> &conditionsReverse) {
    int a, b;
    double rab, cab, rba, cba;
    for (int i = 0; i < m; ++i) {
        std::cin >> a >> b >> rab >> cab >> rba >> cba;
        --a;
        --b;
        graph.emplace_back(a, b);
        conditions.emplace_back(rab, cab);
        conditionsReverse.emplace_back(rba, cba);
    }
}

void fordBellman(int n, int s, double value, std::vector<std::pair<int, int>> &graph,
                 std::vector<std::pair<double, double>> &conditions,std::vector<std::pair<double, double>> &conditionsReverse) {
    int m = graph.size();
    std::vector<double> dp(n, 0);
    dp[s] = value;
    bool x = false;
    for (int i = 0; i < n; ++i) {
        x = false;
        for (int j = 0; j < m; ++j) {
            int u = graph[j].first;
            int v = graph[j].second;
            if (dp[v] < (dp[u] - conditions[j].second) * conditions[j].first) {
                x = true;
                dp[v] = (dp[u] - conditions[j].second) * conditions[j].first;
            }
            if (dp[u] < (dp[v] - conditionsReverse[j].second) * conditionsReverse[j].first) {
                x = true;
                dp[u] = (dp[v] - conditionsReverse[j].second) * conditionsReverse[j].first;
            }
        }
    }
    if (x) {
        std::cout << "YES";
    } else {
        std::cout << "NO";
    }
}

int main() {
    int n, m, s;
    double v;
    std::cin >> n >> m >> s >> v;
    --s;
    std::vector<std::pair<int, int>> graph;
    std::vector<std::pair<double, double>> conditions;
    std::vector<std::pair<double, double>> conditionsReverse;
    input(m, graph, conditions, conditionsReverse);
    fordBellman(n, s, v, graph, conditions, conditionsReverse);
    return 0;
}
