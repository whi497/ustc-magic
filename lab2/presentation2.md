<div style="text-align:center;font-size:2em;font-weight:bold">中国科学技术大学计算机学院</div>


<div style="text-align:center;font-size:2em;font-weight:bold">《数字电路实验报告》</div>


![image-20211028163846705](C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211028163846705.png)
<div style="display: flex;flex-direction: column;align-items: center;font-size:2em">
<div>
<p>实验题目：简单组合逻辑电路 </p>
<p>学生姓名：叶子昂</p>
<p>学生学号：PB20020586</p>
<p>完成时间：2021年10月28日</p>
</div>
</div>


<div style="page-break-after:always"></div>


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
* 例一：（简单模块）

  ```verilog
  module test (
      input in,
      output out,
      output out_n
  );
      assign out=in;
      assign out_n=~in;
  endmodule
  ```

* 例二：（位拼接）

  ```verilog
  module add(
      input a,b,
      output sum,cout
  );
      assign{cout,sum}=a+b;
  endmodule
  ```
  
* 例三（模块例化）
  
  ```verilog
  module full_add (
      input a,b,cin,
      output sum,cout
  );
      wire s,carry1,carry2;
      add add_inst1(.a(a),.b(b),.sum(s),.cout(carr1));
      add add_inst2(.a(s),.b(cin),.sum(sum),.cout(carr2));
      assign cout=carry1|carry2;
  endmodule
  ```
  
  

### 实验练习
#### 题目一
* 首先设置端口

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211021153900016.png" alt="image-20211021153900016" style="zoom:50%;" />
  
* 输入真值表

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211028164653509.png" alt="image-20211028164653509" style="zoom: 50%;" />
  
* 建立电路

  <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab2\pr1.png" alt="pr1" style="zoom:15%;" />

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
*  输入Logisim中自动生成电路如下：
  <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab2\2.png" alt="2" style="zoom:10%;" />

#### 题目三
* 使用Logisim画出1bit位宽的二选一数据选择器

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211027152750400.png" alt="image-20211027152750400" style="zoom:33%;" />
  
* 根据电路图按要求用verilog实现

  ```verilog
  module selsct (
      input a,b,sel,
      output cout
  );
      wire s,carry1,carry2,carry3,carry4;
      not(s,sel);
      and(carry1,s,a);
      and(carry2,sel,b);
      or(cout,carry1,carry2);
  endmodule
  ```

#### 题目四
* 画出由二选一选择器构成四选一选择器的电路图

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211027153445042.png" alt="image-20211027153445042" style="zoom:33%;" />

* 例化题目三中的二选一选择器

  ```verilog
  module top_module(
    input a,b,c,d,sel1,sel2,
    output out
  );
  wire temp1,temp2;
  selsct instance1(a,b,sel1,temp1);
  selsct instance2(c,d,sel1,temp2);
  selsct instance3(temp1,temp2,sel2,out);
  endmodule
  ```

#### 题目五

* 根据真值表列出逻辑表达式

   y2=i[7] | i[6] | i[5] | i[4]

   y1=i[7] | i[6] | \~i[5]&~i[4]&i[3] | \~i[5]&\~i[4]&i[2]

   y0=i[7] | \~i[6]&i[5] | \~i[6]&\~i[4]&i[3] | \~i[6]&\~i[4]&\~i[2]&i[1]
* 用verilog代码实现
   ```verilog
   module preinfor (
       input [7:0] i,
       output [2:0] y
   );
       assign y2=i[7] | i[6] | i[5] | i[4];
       assign y1=i[7] | i[6] | ~i[5]&~i[4]&i[3] | ~i[5]&~i[4]&i[2];
       assign y0=i[7] | ~i[6]&i[5] | ~i[6]&~i[4]&i[3] | ~i[6]&~i[4]&~i[2]&i[1];
   endmodule
   ```


#### 题目六

* 根据verilog代码得到逻辑表达式

  s1=\~a&\~b&c | \~a&b&\~c | a&\~b&\~c | a&b&c;

  s2=\~a&b&c | a&\~b&c | a&b&\~c | \~a&\~b&\~c;

* 输入Logisim得到电路图以及真值表

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211027155740506.png" alt="image-20211027155740506" style="zoom: 50%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211027155713243.png" alt="image-20211027155713243" style="zoom: 50%;" />
  
* 从真值表可以看出当输入有0个或2个为1时 **s1为0 s2为1** 而当输入有1个或3个为1时 **s1为1 s2为0** 从而得知该电路功能为判断输入为高电平信号的个数（或奇偶性）。

### 总结与思考
1. * 通过本次实验我进一步了解和熟悉了Logisim的功能，学会了通过Logisim自动生成和分析电路，能够利用Logisim设计实现组合逻辑电路并进行仿真。
   * 初步了解了verilog并通过实验和oj平台掌握了verilog的基本语法，能够用其描述一些简单的电路，能够将实现的模块实例化并简单的应用

2.  本次实验进一步应用Logisim和简单讲解使用verilog，较为简单
3. 本次实验分块明确，讲解清楚，任务量适中
4. 希望能加入如运算优先级，关键词含义之类的讲解