# 数据结构与算法

## 图

### 表示方法

#### 邻接矩阵

将点标记为0,1,2,3...n作为下标，使用数组g存储边权信息，从点a到点b的权值为v，记为`g[a][b] = v`，如果是无向图，则`g[b][a]`也等于v

适用数据范围，点数 $10^3$，边数 $10^6$，点数不多的稠密图

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

void dfs(int u, int fa)
{
    for (auto ed : e[u]) {
        int v = ed.v, w = ed.w;
        if (v == fa) continue;
        // xxx
        dfs(v, u);
    }
} // 如果是树形结构，可以使用父节点判重，有环不能使用这种方式

void input()
{
    cin >> n >> m;
    for (int i = 1; i <= m; ++i) {
        int a, b, c;
        cin >> a >> b >> c;
        e[a].push_back({b, c});
        // e[b].push_back({a, c});
    }
    dfs(1, 0);
}
```

#### 链式邻接表

边集数组`e[j]`存储第`j`条边的`{u,v,w}`
表头数组存储`h[u][j]`存储u点的所有出边的编号(起点为`u`的点的集合)

```c++
struct edge {int u, v, w; };
vector<edge> e;    // 边集
vector<int> h[N];  // h[u] -> 起点为`u`的点的集合h[u][0]->h[u][n - 1]

void add(int u, int v, int w)
{
    e.push_back({u, v, w});
    h[a].push_back(e.size() - 1);   // 在e中的下标
}

void dfs(int u, int fa)
{
}

void input()
{
    cin >> m;
    for (int i = 1; i <= m; ++i) {
        int u, v, w;
        cin >> u >> v >> w;
        add(u, v, w);
        add(v, u, w);
    }
}
```

#### 链式前向星

边集数组`e[j]`存储`{v, w, ne}`(终点，权值，下一条边的索引)

表头数组`h[u]`存储`u`点的第一条出表的编号

```c++
struct edge {int v, w, ne; };

edge e[M];
int h[N], idx;

void add(int a, int b, int c)
{
    e[idx] = {b, c, h[a]};
    h[a] = idx++;
}
```


