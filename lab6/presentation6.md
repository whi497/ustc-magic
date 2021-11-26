  

<div style="text-align:center;font-size:2em;font-weight:bold">中国科学技术大学计算机学院</div>


<div style="text-align:center;font-size:2em;font-weight:bold">《数字电路实验报告》</div>







![image-20211028163846705](C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211028163846705.png)







<div style="display: flex;flex-direction: column;align-items: center;font-size:2em">
<div>
<p>实验题目：FPGA原理及Vivado综合 </p>
<p>学生姓名：叶子昂</p>
<p>学生学号：PB20020586</p>
<p>完成时间：2021年11月24日</p>
</div>
</div>





<div style="page-break-after:always"></div>

#### 实验题目

**FPGA原理及Vivado综合**

#### 实验目的

* 了解FPGA的工作原理
* 了解Verilog文件和约束文件在FPGA开发中的作用
* 学会使用Vivado进行FPGA开发的完整的流程

#### 实验环境

* Vlab平台

* FPGAOL实验平台

* Logisim工具

* Vivado工具

####   实验练习

##### 题目一：

> 请通过实验中给出的可编程逻辑单元、交叉互连矩阵及 IOB电路图，实现如下代码，并将其输出到引脚 B 上。 给出配置数据和电路截图。  

```verilog
/*
module test(input clk,output reg a);
always@(posedge clk)
a <= a ^ 1’b1;
endmodule
*/
```

* 首先绘制出可编程逻辑单元，交叉互联矩阵及IOB电路图。

  <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab6\电路.png" alt="电路" style="zoom:50%;" />

* 功能模块要求使用output reg a，故二选一数据选择器选0端。时钟上升沿时执行异或操作，故四选一数据选择器置为0110，b输入引脚为1。模块实现的为时序电路故第二个二选一数据选择器选0端。由于需要反馈结果和输出结果到引脚B，故可设置交叉互联矩阵为3，1，3。

  ![结果](D:\wh030917\Documents\GitHub\magic\a魔术作业\lab6\结果.png)

​	编程配置为：| 0 | 0110 | 0 | 3 1 3 |

##### 题目二：

> 实验中的开关和 LED 的对应关系是相反的，即最左侧的开关控制最右侧的 LED，最右侧的开关控制最左侧的 LED， 请修改实验中给出的 XDC 文件， 使开关和 LED 一一对应（最左侧的开关控制最左侧的 LED） ，如下图所示。  

![image-20211126110027178](C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211126110027178.png)

* 先将原文件综合出的bit文件烧写进入FPGA在线平台。发现灯与开关对应关系如上左图所示。

* 打开test.xdc文件，调换输出接口与FPGA端口的对应关系，再综合生成bit文件烧写入FPGA在线平台。

* 测试开关与LED等对应关系如下图：

  <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab6\屏幕截图 2021-11-18 151002.png" alt="屏幕截图 2021-11-18 151002" style="zoom:38%;" />

​	修改正确。

##### 题目三：

> 设计一个 30 位计数器， 每个时钟周期加 1， 用右侧的 8 个LED 表示计数器的高 8 位，观察实际运行结果。将该计数器改成 32位，将高 8 位输出到 LED，与前面的运行结果进行对比，分析结果及时钟信号在其中所起的作用。  

* 设计30位计数器：

  ```verilog
  module conculator (
      input clk,rst,
      output [7:0] cout
  );
      reg [29:0] Q;
      always @(posedge clk or posedge rst)
      begin
          if(rst==1)Q<=30'b0;
          else Q<=Q+30'b1;
      end
      assign cout=Q[29:22];
  endmodule
  ```
  
* 在.xdc中约束管脚，将cout分配到FPGA8个LED端口。利用Vivado综合生成bit文件。

* 烧写bit文件进入FPGA在线平台。观察结果：

  <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab6\屏幕截图 2021-11-21 220401.png" alt="屏幕截图 2021-11-21 220401" style="zoom:28%;" />

* 设计32位计数器：

  ```verilog
  module conculator (
      input clk,rst,
      output [7:0] cout
  );
      reg [31:0] Q;
      always @(posedge clk or posedge rst)
      begin
          if(rst==1)Q<=32'b0;
          else Q<=Q+32'b1;
      end
      assign cout=Q[31:24];
  endmodule
  ```
  
* 使用相同的.xdc文件，利用Vivado生成bit文件。

* 烧写进入FPGA在线平台，观察结果如下：

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211126111429598.png" alt="image-20211126111429598" style="zoom:33%;" />

* 对比观察发现32位计数器LED变更明显慢于30位计数器。时钟信号起驱动计数器计数的作用（时钟上升沿到来一次计数器加一）。

##### 总结与思考
* 本次实验的收获
* 本次实验的难易程度
* 本次实验的任务量
* 对本次实验的建议