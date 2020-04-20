#include <iostream>
#include <vector>

// Чтобы найти, какие вершины из каких мы можем посетить, напишем Флойда. Если расстояние
// до вершины < 1е9, то мы дошли до вершины, значит, ее можно посетить. Зашло без битовых
// цепочек, но с ифом вместо минимума (сам удивлен, как так:)).

std::vector<std::vector<int>> input() {
    int n;
    std::cin >> n;
    std::vector<std::vector<int>> v(n, std::vector<int>(n, 0));
    std::string s;
    for (int i = 0; i < n; ++i) {
        std::cin >> s;
        for (int j = 0; j < n; ++j) {
            if (s[j] == '1') {
                v[i][j] = 1;
            }
        }
    }
    return v;
}

std::vector<std::vector<int>> floyd(std::vector<std::vector<int>> &graph) {
    int n = graph.size();
    std::vector<std::vector<int>> dp(n, std::vector<int>(n, 1e9));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (graph[i][j] != 0) {
                dp[i][j] = 1;
            }
        }
    }
    for (int k = 0; k < n; ++k) {
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dp[i][j] > dp[i][k] + dp[k][j]) {
                    dp[i][j] = dp[i][k] + dp[k][j];
                }
            }
        }
    }
    return dp;
}

void answer(const std::vector<std::vector<int>> &v) {
    int n = v.size();
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (v[i][j] < 1e9) {
                std::cout << 1;
            } else {
                std::cout << 0;
            }
        }
        std::cout << std::endl;
    }
}


int main() {
    std::vector<std::vector<int>> graph = input();
    std::vector<std::vector<int>> dist = floyd(graph);
    answer(dist);
    return 0;
}
