# 数据结构与算法

## 图

### 表示方法

#### 邻接矩阵

将点标记为0,1,2,3...n作为下标，使用数组g存储边权信息，从点a到点b的权值为v，记为`g[a][b] = v`，如果是无向图，则`g[b][a]`也等于v

```cpp

const int N = 1004;
int g[N][N];
bool vis[N];
int n, m;

void dfs(int u)
{
    vis[u] = true
    for (int i = 1; i <= n; ++i) {
        if (g[u][i]) {
            std::println("g[{}][{}] = {}", u, i, g[u][i]);
            if (!vis[i]) dfs(i);
        }
    }
}

void input()
{
    std::cin >> n >> m;
    for (int i = 1; i <= m; ++i) {
        int a, b, c;
        std::cin >> a >> b >> c;
        g[a][b] = c;
        // g[b][a] = c; // 无向图
    }
}

使用场景：使用不多的稠密图中,($n = 10^3$ 或者 $m = 10^6S$)

```

#### 边集数组

使用`e[i]`存储第i条边的信息：{u, v, w}

```cpp
struct edge {
    int u, v, w;
}e[M];
bool vis[N];
int n, m;

void dfs(int u) {
    vis[u] = true;
    for (int i = 1; i <= m; ++i) {
        if (e[i].u == u) {
            int v = e[i].v, w = e[i].w;
            std::cout << "xxx" << std::endl;
            if (!vis[v]) dfs(v);
        }
    }
}

void input()
{
    std::cin >> n >> m;
    for (int i = 1; i <= m; ++i) {
        std::cin >> e[i].u >> e[i].v >> e[i].w;
    }
    dfs(1);
}
```

使用场景：kruskal算法

#### 邻接表

`e[u]`中存储u的所有出边

```cpp
struct edge{ int v, w; };
vector<edge> e[N];
int n, m;

void dfs() {} // 如果是树形结构，可以使用父节点判重

void input()
{
    cin >> n >> m;
    for (int i = 1; i <= m; ++i) {
        int a, b, c;
        cin >> a >> b >> c;
        e[a].push_back({b, c});
        // e[b].push_back({a, c});
    }
}
```

