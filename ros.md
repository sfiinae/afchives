# ros

[ROS Tutorials](https://wiki.ros.org/cn/ROS/Tutorials)

文档是为了避免网页加载卡顿

## 文件系统导览

1. `rospack find [package_name]` 获取软件包相关的信息，例`rospack find roscpp`输出`roscpp`的路径`/opt/ros/noetic/share/roscpp`
2. `roscd [locationname[/subdir]]`直接切换目录到某个软件包或者软件包集当中，例`roscd roscpp && pwd`会显示`/opt/ros/noetic/share/roscpp`；`roscd roscpp/cmake && pwd`会显示`/opt/ros/noetic/share/roscpp/cmake`。`roscd log`将带您进入存储ROS日志文件的目录
3. `rosls [locationname[/subdir]]`按软件包的名称执行 ls 命令（而不必输入绝对路径）。

## 创建ros软件包

### 创建工作空间

```bash
$ mkdir -p catkin_ws/src
$ cd catkin_ws
$ catkin_make
```

### 软件包的组成
- 一个符合规范的package.xml文件，提供有关该软件的元信息
- 一个catkin版本的CMakeLists.txt文件
- 每个包自身的目录


```bash
workspace_folder/        -- WORKSPACE
  src/                   -- SOURCE SPACE
    CMakeLists.txt       -- 'Toplevel' CMake file, provided by catkin
    package_1/
      CMakeLists.txt     -- CMakeLists.txt file for package_1
      package.xml        -- Package manifest for package_1
    ...
    package_n/
      CMakeLists.txt     -- CMakeLists.txt file for package_n
      package.xml        -- Package manifest for package_n
```

### 创建软件包

在[工作空间](#创建工作空间)的`src`下通过`catkin_create_pkg`创建，例：`catkin_create_pkg beginner_tutorials std_msgs rospy roscpp`，其中`beginner_tutorials`是包名，后面的是软件包的依赖项

### 构建一个catkin工作区

```bash
$ cd catkin_ws
$ catkin_make
# 将这个工作空间添加到ROS环境中
$ . ~/catkin_ws/devel/setup.bash
```

- `rospack depends1 beginner_tutorials`：查看包的一级依赖
- `rospack depends beginner_tutorials`：查看依赖，包括嵌套的，如`beginner_tutorials`依赖`rospy`，该命令会将`rospy`的依赖也打印出来

### 自定义软件包


```xml
<?xml version="1.0"?>
<package format="2">
  <name>beginner_tutorials</name>
  <version>0.0.0</version>
  <!-- 描述标签，尽量简短 -->
  <description>The beginner_tutorials package</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag -->
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <!--
  维护者标签：<maintainer email="af@todo.todo">username</maintainer>
   -->
  <maintainer email="af@todo.todo">af</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but multiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://wiki.ros.org/beginner_tutorials</url> -->


  <!-- Author tags are optional, multiple are allowed, one per tag -->
  <!-- Authors do not have to be maintainers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->


  <!-- The *depend tags are used to specify dependencies -->
  <!-- Dependencies can be catkin packages or system dependencies -->
  <!-- Examples: -->
  <!-- Use depend as a shortcut for packages that are both build and exec dependencies -->
  <!--   <depend>roscpp</depend> -->
  <!--   Note that this is equivalent to the following: -->
  <!--   <build_depend>roscpp</build_depend> -->
  <!--   <exec_depend>roscpp</exec_depend> -->
  <!-- Use build_depend for packages you need at compile time: -->
  <!--   <build_depend>message_generation</build_depend> -->
  <!-- Use build_export_depend for packages you need in order to build against this package: -->
  <!--   <build_export_depend>message_generation</build_export_depend> -->
  <!-- Use buildtool_depend for build tool packages: -->
  <!--   <buildtool_depend>catkin</buildtool_depend> -->
  <!-- Use exec_depend for packages you need at runtime: -->
  <!--   <exec_depend>message_runtime</exec_depend> -->
  <!-- Use test_depend for packages you need only for testing: -->
  <!--   <test_depend>gtest</test_depend> -->
  <!-- Use doc_depend for packages you need only for building documentation: -->
  <!--   <doc_depend>doxygen</doc_depend> -->

  <!-- 依赖项标签 -->
  <buildtool_depend>catkin</buildtool_depend>
  <build_depend>roscpp</build_depend>
  <build_depend>rospy</build_depend>
  <build_depend>std_msgs</build_depend>
  <build_export_depend>roscpp</build_export_depend>
  <build_export_depend>rospy</build_export_depend>
  <build_export_depend>std_msgs</build_export_depend>
  <exec_depend>roscpp</exec_depend>
  <exec_depend>rospy</exec_depend>
  <exec_depend>std_msgs</exec_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- Other tools can request additional information be placed here -->

  </export>
</package>

```

## 构建ros软件包

```bash
# 默认位置为src/，可以通过 --source指定代码位置，install同样需要指定
$ catkin_make
$ catkin_make install
```

## ros节点

### 图概念速览
计算图（Computation Graph）是一个由ROS进程组成的点对点网络，它们能够共同处理数据。ROS的基本计算图概念有节点（Nodes）、主节点（Master）、参数服务器（Parameter Server）、消息（Messages）、服务（Services）、话题（Topics）和袋（Bags），它们都以不同的方式向图（Graph）提供数据。

- 节点（Nodes）：节点是一个可执行文件，它可以通过ROS来与其他节点进行通信。
- 消息（Messages）：订阅或发布话题时所使用的ROS数据类型。
- 话题（Topics）：节点可以将消息发布到话题，或通过订阅话题来接收消息。
- 主节点（Master）：ROS的命名服务，例如帮助节点发现彼此。
rosout：在ROS中相当于stdout/stderr（标准输出/标准错误）。
roscore：主节点 + rosout + 参数服务器（会在以后介绍）。

### 节点

节点实际上只不过是ROS软件包中的一个可执行文件。ROS节点使用ROS客户端库与其他节点通信。节点可以发布或订阅话题，也可以提供或使用服务。

- `rosnode list`: 查看当前活动的节点
- `rosnode info node_name`:查看节点发布订阅以及提供的服务
- `rosrun [package_name] [node_name]`: 运行软件包内的节点（而不需要知道包的路径）。

## ros 话题

通过发布/订阅可以让不同的node之间进行通信

`rosrun rqt_graph rqt_graph` rqt_graph用动态的图显示了系统中正在发生的事情。rqt_graph是rqt程序包中的一部分

### rostopic

获取ROS话题的信息

`-h`参数查看可用的子命令


- **`rostopic echo topic_name`可以显示在某个话题上发布的数据，每当topic_name发布时，它会将数据打印下来，`-b`参数可以查看bag包的topic信息**
- `rostopic list`能够列出当前已被订阅和发布的所有话题，`-v`参数会列出所有发布和订阅的主题及其类型的详细信息

<!-- ************************************** -->
### ros 消息

话题的通信是通过节点间发送ROS消息实现的。为了使发布者（turtle_teleop_key）和订阅者（turtulesim_node）进行通信，发布者和订阅者必须发送和接收相同类型的消息。这意味着话题的类型是由发布在它上面消息的类型决定的。
- **`rostopic type topic_name`命令可以查看发布在话题上的消息的类型。**
- **`rosmsg`查看消息的详细信息，`rosmsg show msg_name`**
- **`rostopic pub /topic type [args...]`可以直接发布消息**，
    - 例：`rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, 1.8]'`，`-1`表示发布一条消息然后退出;**`--`表示告诉选项解析器，表明之后的参数都不是选项。如果参数前有破折号（-）比如负数，那么这是必需的。**，`-r`指定频率(hz)，美秒发送多少次
- `rostopic hz topic_name`报告数据发布的速率。
- rqt_plot命令可以在滚动时间图上显示发布到某个话题上的数据。这里我们将使用rqt_plot命令来绘制正被发布到/turtle1/pose话题上的数据。`rosrun rqt_plot rqt_plot`

## 服务和参数

服务（Services）是节点之间通讯的另一种方式。服务允许节点发送一个请求（request）并获得一个响应（response）`topic`是单向的，`service`是双向的

rosservice可以很容易地通过服务附加到ROS客户端/服务器框架上。rosservice有许多可用于服务的命令
- `rosservice list`: 输出活跃服务的信息
- `rosservice call [service] [args]`: 用给定的参数调用服务
- `rosservice type`: 输出服务的类型
- `rosservice find`: 按服务的类型查找服务
- `rosservice uri`: 输出服务的ROSRPC uri

类似的`rosservice type service_name`查看服务类型，`rossrv show srv_type`查看`srv_type`的结构


### rosparam

rosparam能让我们在ROS参数服务器（Parameter Server）上存储和操作数据。参数服务器能够存储整型（integer）、浮点（float）、布尔（boolean）、字典（dictionaries）和列表（list）等数据类型。rosparam使用YAML标记语言的语法。一般而言，YAML的表述很自然：1是整型，1.0是浮点型，one是字符串，true是布尔型，[1, 2, 3]是整型组成的列表，{a: b, c: d}是字典。rosparam有很多命令可以用来操作参数，如下所示：

```bash
rosparam set            # 设置参数
rosparam get            # 获取参数
rosparam load           # 从文件中加载参数
rosparam dump           # 向文件中转储参数
rosparam delete         # 删除参数
rosparam list           # 列出参数名

rosparam dump [file_name] [namespace]
rosparam load [file_name] [namespace]
```

## `rqt_console`和`rqt_launch`

`rqt_console`连接到了ROS的日志框架，以显示节点的输出信息。`rqt_logger_level`允许我们在节点运行时改变输出信息的详细级别，包括Debug、Info、Warn和Error`

### roslaunch

`roslaunch [package] [filename.launch]`

## rosed

rosed是rosbash套件的一部分。利用它可以直接通过软件包名编辑包中的文件，而无需键入完整路径。
`rosed [package_name] [filename]`

## 创建消息和服务

- msg（消息）：msg文件就是文本文件，用于描述ROS消息的字段。它们用于为不同编程语言编写的消息生成源代码。
- srv（服务）：一个srv文件描述一个服务。它由两部分组成：请求（request）和响应（response）。

**msg文件存放在软件包的msg目录下，srv文件则存放在srv目录下。**

msg文件就是简单的文本文件，每行都有一个字段类型和字段名称。可以使用的类型为：
- int8, int16, int32, int64 (以及 uint*)
- float32, float64
- string
- time, duration
- 其他msg文件
- `variable-length array[]` 和 `fixed-length array[C]`

ROS中还有一个特殊的数据类型：Header，它含有时间戳和ROS中广泛使用的坐标帧信息。在msg文件的第一行经常可以看到Header header
```bash
[std_msgs/Header]:
uint32 seq
time stamp
string frame_id
```

srv和msg一样，但是它由请求和响应两部分构成，用`---`分割
```ros
int64 A
int64 B
---
int64 Sum
```
上方的例子中A B是请求，Sum是响应

### 使用msg

#### 创建msg
msg文件应放置在节点的msg目录下

###### 1. 更新package.xml

**为了确保msg文件能被转成c++/python的源代码，确保下方两行的代码在package.xml中存在且被启用**
```xml
<build_depend>message_generation</build_depend>
<exec_depend>message_runtime</exec_depend>
```
构建时，只需要message_generation，而在运行时，只需要message_runtime
###### 2. 更新CMakeLists.txt文件

**2.1 find_package中添加message_generation**

```cmake
find_package(catkin REQUIRED COMPONENTS
   roscpp
   rospy
   std_msgs
   message_generation
)
```

**2.2 确保导出消息的运行时依赖关系**
```cmake
catkin_package(
  ...
  CATKIN_DEPENDS message_runtime ...
  ...)
```

**2.3 更新add_message_files**
```cmake
add_message_files(
  FILES
  Num.msg
)
```

**2.4 确保`generate_messages()`函数被调用**
```cmake
generate_messages(
  DEPENDENCIES
  std_msgs
)
```
###### 3. 测试

通过`rosmsg show [message type]`(`rosmsg show beginner_tutorials/Num`)测试ros是否识别

### 使用srv

**srv文件放在srv目录下**

###### 1. 更新package.xml

同[msg](#1-更新packagexml)

###### 2. 更新CMakeLists.txt

- **2.1;2.2;2.4 同[msg](#2-更新cmakeliststxt文件)**

- **2.3 更新`add_service_files**
```cmake
add_service_files(
  FILES
  AddTwoInts.srv
)
```

###### 3. 测试

`rossrv show beginner_tutorials/AddTwoInts`

### 生成结果

msg目录中的任何.msg文件都将生成所有支持语言的代码。C++消息的头文件将生成在`devel/include/beginner_tutorials/`。Python脚本将创建在`devel/lib/python2.7/dist-packages/beginner_tutorials/msg`。而Lisp文件则出现在`devel/share/common-lisp/ros/beginner_tutorials/msg/`。

## c++编写发布者订阅者

<!-- TODO 补全 -->

## 录制和回放


