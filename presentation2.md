#  模拟数字电路实验
实验题目：简单组合逻辑电路 
学生姓名：叶子昂
学生学号：PB20020586
完成时间：

### 实验题目
**简单组合逻辑电路**

### 实验目的
* 课本
  	- 熟悉Logism的基本用法
  	- 进一步熟悉Logisim更多功能
  	- 用Logisim设计组合逻辑电路并进行仿真
  	- 初步学习Verilog语法

### 实验环境
* 有Windows系统的电脑，能连接校园网
* Logisim仿真工具
* Vivido软件
* vlab.ustc.edu.cn平台
### 实验步骤
1. 使用真值表用Logisim自动生成电路
* 真值表

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017224802403.png" alt="image-20211017224802403" style="zoom:50%;" /> 
* 使用Logism自动建立电路

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017224621633.png" alt="image-20211017224621633" style="zoom: 50%;" />
2. 用表达式生成电路图
* 输入表达式

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017233844734.png" alt="image-20211017233844734" style="zoom:30%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017233918830.png" alt="image-20211017233918830" style="zoom:30%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017233950671.png" alt="image-20211017233950671" style="zoom:30%;" />
  
* Logisim自动建立

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017234449823.png" alt="image-20211017234449823" style="zoom:33%;" />
3. Verilog HDL入门
* 
### 实验练习
#### 题目一
* 首先设置端口

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211021153900016.png" alt="image-20211021153900016" style="zoom:50%;" />
  
* 输入真值表

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211021154412197.png" alt="image-20211021154412197" style="zoom:50%;" />
  
* 建立电路

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211021154502425.png" alt="image-20211021154502425" style="zoom:33%;" />

#### 题目二
* 首先列出表达式

  a,b,c分别为A2到A0

  d,e,f分别为G1到G3

  x到t即为Y7到Y0

  x=~a + ~b + ~c + ~d + e + f
  y=~a + ~b + ~c + ~d + e + f
  z=~a + ~c + b + ~d + e + f
  u=~a + c + b + ~d + e + f
  v=~b + ~c + a + ~d + e + f
  w=~b + c + a + ~d + e + f
  s=~b + c + a + ~d + e + f
  t=c + b + a + ~d + e + f
