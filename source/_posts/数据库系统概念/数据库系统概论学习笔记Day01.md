---
title: 数据库系统概念Day01
date: 2024-06-22 00:00:00
---
# 数据库系统概念 学习笔记 Day01

>  本笔记记录粗略学习数据库系统概论的笔记

## 数据库管理系统概念

- **数据库管理系统<sup>DataBase-Management system,DBMS</sup>**是由一个**互相关联的数据的集合**和一组用于访问这些数据的**程序**

## 数据库应该具有的功能

- 信息存储结构的定义
- 信息操作机制的提供
- 提供所存储信息的安全性保证<sup> 即使系统崩溃或有人企图越权访问时也可以保证信息安全性</sup>

## 数据库适用于以下数据集合

- 具有**高价值**的数据集合
- 相对**庞大**的数据集合
- 常常**同时**被多个用户和应用系统**访问**的数据集合

> 数据库系统充分利用数据结构中的公共特性以获取高特性，同时也允许弱结构化的数据和格式易变的数据
>
> 数据库系统是一个大型的复杂的软件系统，它的任务是管理大型的复杂的数据集合
>
> 对复杂性进行管理的关键是**抽象**这个概念。抽象可以使人们利用复杂的设备或系统，而**不必了解**该设备或系统是**如何实现**的

## 数据库的实现方式有两种

- 联机事务处理<sup>online transaction processing</sup>

  用户使用数据库，每个用户检索相对少量的数据，进行小的更新<sup>写入</sup>。这是数据库系统绝大多数的使用方式

- 数据分析<sup>data analytics</sup>

  即审查数据，根据数据分析结果给出结论，并得出规则或程序，以驱动业务决策者

## 使用**文件处理系统<sup>file-processing system</sup>**存储数据的弊端

- **数据的冗余和不一致性**。相同的信息可能在不同的位置重复存储，同一数据的不同副本不一致
- **数据访问困难**。总是需要设计新的程序来满足新的需求
- **数据孤立**。由于数据分散在不同的文件中，这些文件可能具有不同的格式，编写新的程序来检索数据是困难的
- **完整性问题**。数据库中所存储的数据的值必须满足某些特定类型的**一致性约束**。
- **原子性问题**。数据库中的数据改变应保持一致性，比如：转账这个操作必须是原子的，要么全部发生，要么就全部不发生。在传统的文件处理系统中很难实现这一点。
- **并发访问异常<sup>脏数据</sup>**。多个用户同时读取并更新数据时，可能会造成数据不一致。
- **安全性问题**。并非数据库系统的每一个用户都可以访问所有数据。在文件处理系统中，很难实现这一点

## 数据视图

数据库系统是一些**相互关联的数据**以及一组使得用户可以访问和修改这些数据的**程序**的集合。数据库的主要目的是给用户提供数据的**抽象**视图，系统隐藏关于数据存储和维护的某些细节

### 数据模型

数据库结构的基础是**数据模型<sup>data model</sup>**：一个描述数据、数据联系、数据语义以及一致性约束的概念工具的集合

数据模型可以被划分为**四**类：

- **关系模型**。关系模型用表的集合来表示数据和数据间的联系。

  > 关系数据模型是使用最广泛的数据模型，大多数数据库系统都基于这种关系模型。

- **实体-联系模型**。实体-联系（E-R）模型使用称作实体的基本对象的集合，以及对象间的联系。

  > **实体**是可区别于其他对象的“**事情**”或“**物体**”
  >
  > 实体-联系模型广泛使用于**数据库设计**

- **半结构化数据模型**。半结构化数据模型允许在其数据定义中某些相同类型的数据项含有不同的属性集

  > JSON xml

- **基于对象的数据模型**。面向对象的程序设计已成成为占主导地位的软件开发方法。这在最初的时候导致了一个独特的面向对象数据模型的发展。

  > 但是现在对象的概念已经被整合到关系型数据库中，并由数据库系统来执行他们

### 关系数据模型

在关系数据模型中，数据以表的形式表示

### 数据抽象

一个可用的系统必须能**高效**的检索数据。这种对高效性的需求促使数据库系统开发人员在数据库中使用复杂的数据结构来表示数据。由于许多数据库系统用户并未受过计算机专业训练，系统开发人员通过**数据抽象<sup>data abstraction</sup>**来对用户屏蔽复杂性。

- **物理层**。最低层次的抽象，描述数据实际上是怎样存储的。物理层详细描述复杂的底层数据结构

- **逻辑层**。比物理层层次稍高的抽象，描述数据库中存储什么数据以及这些数据间的联系

  > 逻辑层的用户**不必**了解复杂的物理层结构，这称作**物理数据独立性**。数据库管理员使用抽象的逻辑层，他必须确定数据库中应该保存哪些信息。

- **视图层**。视图层是最高层次的抽象，它只描述数据库的某个部分。

  > 尽管逻辑层使用的行对简单的结构，但由于数据库中所存储信息的多样性，使逻辑层仍具有一定的复杂性。
  >
  > 数据库系统的很多用户并不需要所有的这些信息，而只需要访问数据库的一部分。视图层抽象简化了用户与系统的交互

>  这三种抽象之间的关系![image-20220110100351861](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220110100351861.png)

## 数据库语言

数据库系统提供**数据定义语言<sup>DDL</sup>**来定义数据库模式，并提供**数据库操作语言<sup>DML</sup>**来表达数据库的查询和更新。实际上，这两种并不是相互分离的语言，而是构成了**数据库语言<sup>例如SQL</sup>**的不同部分。

> 几乎所有的关系数据库系统都是以SQL语言

### 数据定义语言

数据模式是通过一系列定义来说明的，这些定义由DDL来表达，这种特定的DDL被称作**数据存储和定义**语言。这些语句定义了数据库模式的实现细节，这些细节对用户来说通常是隐藏的。  
**存储在数据库中的数据值必须满足某些一致性约束**。当数据库被更新时，数据库系统会检查这些约束。

- **域约束**。每个属性都必须对应一个所有可能的取值构成的域（例如：整形、字符串、时间等）。声明一个属性属于某个域就可以约束该属性可以取的值。域约束是完整性约束的基本形式。

- **引用完整性**。我们希望能确保一个关系中给定属性集上的取值也在另一关系的某一取值中出现

  > 例如：每门课程所属的系必须是大学中实际存在的系

- **授权**。对于不同的用户在数据库中的不同数据值上允许不同的访问类型。这些区别以**授权**来表达

  > - **读权限**：允许读取数据，但不能修改数据
  > - **插入权限**：允许插入新数据，但不允许修改已有数据
  > - **更新权限**：允许修改已有的数据，但不允许删除数据
  > - **删除权限**：允许删除数据
  >
  > 我们可以赋予用户部分这些权限，也可以不赋予任何权限

对DDL的处理会产生一些输出。DDL的输出放在**数据字典<sup>data dictinary</sup>**中，数据字典包含**元数据**，元数据是关于数据的数据。可以把数据字典看作特殊的表，这种表只能由数据系统本身来访问和修改。在读取和修改实际的数据前，数据库系统先要参考字典

### 数据操纵语言

数据操纵语言使用户可以访问或操作那些按照某种适当的数据模式组织起来的数据，有以下访问类型

- 对存储在数据库中的信息进行检索
- 向数据库中插入新的信息
- 修改存储在数据库中的信息
- 删除存储在数据库中的信息

> 增删改查

基本上有两种类型的数据操纵语言

- **过程化的DML**要求用户指定需要什么数据以及如何获得这些数据
- 声明式的<sup>非过程化的</sup>DML只要求用户提供指定需要什么数据，而不必指明如何获得这些数据

**查询**是要求对信息进行检索的语句。DML中设计信息检索的部分称作**查询语言**。实际使用中常把查询语言和数据操纵语言作为同义词使用<sup>尽管从技术上来说这并不正确</sup>

> SQL 查询语言是非过程化的

## 数据库设计

- 数据库系统被设计用来管理大量的信息。数据库设计的主要内同时数据库模式的设计。

- **需求分析 **高层次的数据模型为数据库设计者提供了概念框架，来说明数据库用户的数据需求，以及怎样构造数据库结构满足这些需求。这个阶段的成果是用户需求说明书文档

- **概念设计 **设计者选定一个数据模型，将需求转换为一个数据库的概念模式，在这一阶段的重点是描述数据以及他们之间的联系。

  > 从关系模型来看，概念设计阶段涉及决定数据库在应该包括哪些属性，以及如何组织这些属性到各个表中
  >
  > 一个开发完全的概念模式还将指出企业的功能需求。在**功能需求说明**中，用户描述将在数据之上执行各种操作

- **逻辑设计** 设计人员将高层的概念模式映射到要使用的实现数据库系统的模型上

- **物理设计** 说明数据库的物理特性，这些特性包括文件组织形式以及内部的存储结构

## 数据库引擎

数据库系统被划分为多个模块，每个模块完成整个系统的一个功能。数据库系统的功能部件大致可分为：存储管理器、查询处理器和事务管理

### 存储管理器

 存储管理器是数据库系统中负责在数据库中存储的低层数据与应用程序以及向系统提交的查询之间提供**接口**的部件。存储管理器负责与文件管理器进行交互。原始数据通过操作系统提供的文件系统存储在磁盘上，存储管理器将各种DML语句**解释**为底层文件系统命令。因此，存储管理器负责数据库中数据的**存储**、**检索**、和**更新**

存储管理器部件包括：

- **权限及完整性管理器** 它检测是否满足完整性约束，并检查试图访问数据的用户的权限
- **事务管理器** 它保证计时系统发生了故障，数据库也保持在一致的（正确的）状态，并保证并发事务的执行不发生冲突
- **文件管理器** 它管理磁盘存储空间的分配，管理用于表示磁盘上所存储信息的数据结构
- **缓冲区管理器** 它负责将数据从磁盘读取到内存中，并决定哪些数据应被缓冲区存储在内存中。
- **数据文件** 它存储数据库自身
- **数据字典** 它存储关于数据库结构的元数据，特别是数据库模式
- **索引** 它提供对数据项的快速访问，数据库索引提供了包含特定值的数据项的指针。

### 查询处理器

查询处理器组件包括：

- **DDL解释器** 它解释DDL语句并将这些定义记录在数据字典中

- **DML编译器** 它将查询语言的DML语句解释为一系列查询执行引擎能理解的低级指令的执行计划方案

  > 一个查询通常可以被翻译成给出相同结果的多个执行计划的任何一个。DML编译器还进行**查询优化**，从多个执行计划在选出代价最小的那个计划

- **查询执行引擎 **它执行由DML编译器产生的低级指令

### 事务管理

**事务**是数据库中完成单一逻辑功能的操作集合，每一个事物是一个既具有原子性又具有一致性的单元。事务不违反任何的数据库一致性约束

> 在转账操作中，从账户A转到账户B可能被分为两个程序执行，程序A对账户A执行取出操作，程序B对账户B存入操作，这两个程序依次执行时可以保持一致性，但这两个程序自身都不是把数据库从一个一致的状态转入新的一致性状态，因此程序A和程序B都不是事务

原子性和持久性的保证时数据库系统自身的职责

> **持久性**: 当事务执行完毕后，即使系统发生故障，也应该保持事务执行完后的新的信息

事务管理器包括**恢复管理器**和**并发控制管理器**

- 恢复管理器

  在故障发生时，事务并不总是能执行完毕，为了保持原子性，失败的事务不能对数据库产生任何影响，因此数据库应该恢复到该事务执行之前的状态，此时数据库进行**故障恢复**

  - 并发控制管理器
    当多个事务对数据库进行更新时，即使每个事务都是正确的，数据库的一致性也可能会被破坏。并发控制器控制事务间的相互影响，保证数据库的一致性

## 关系数据库的结构

- 关系数据库由**表**的集合构成，每张表由唯一的名称
- 在关系数据库中，术语**关系**被用来指代表，术语**元组**用来指代行<sup>记录</sup>，术语**属性**被用来指代表中的列<sup>字段</sup>。
- 我们用**关系实例**来这一术语来指代一个关系的特定实例
- 对于关系的每个属性都存在一个允许取值的集合，被称为该属性的**域**
- 如果域中的元素**被认为**是不可分割的单元，则该域就是**原子的**

### 数据库模式

我们在谈论数据库时，必须在**数据库模式**和**数据库实例**之间进行区分，**数据库模式**是数据库的逻辑设计，**数据库实例**是在某一时刻数据库中数据的一个快照
关系的概念对应于程序设计中**变量**的概念，关系模型的概念对应于程序设计中**数据类型**的概念，关系实例的概念对应于程序设计中**变量的值**的概念

> 一个给定变量<sup>关系</sup>的值<sup>关系实例</sup>可能会发生变化。而数据类型<sup>关系模型</sup>则不常发生改变



**码**/**超码**/**主码**是属于**关系**的一种性质，而不是但属于某一个元组的性质

### 码

一个关系中不可以有两个元组完全相同

### 超码

超码是一个或多个属性的集合，超码可以在一个关系中唯一的识别出一个元组，超码的**任意超集**也是超码，当一个超码的任意**真子集**都不是超码时，这样的最小超码我们成为**候选码**（我们通常只对候选码感兴趣）

#### 主码

我们用主码表示被数据库设计者选中作为在一个关系中区分不同元组的**候选码**

## 模式图

多个关系之间的主码和外码约束可以用模式图来表示

![20240623211709](http://img.wanstu.cn/vscode/picgo/20240623211709.png)
## 数据库设计

