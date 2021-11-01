  

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
#### 实验题目
**简单时序电路**

#### 实验目的

* 掌握时序电路相关器件的原理以及底层结构
* 能够用基本的逻辑门搭建割裂时序逻辑电路
* 能够使用Verilog HDL设计简单逻辑电路
* 进一步掌握logisim的图形化操作以及模拟功能
* 进一步了解掌握Verilog HDL的语法以及设计方法

#### 实验环境

* 装有windows11的笔记本电脑
* 本地的Logisim，和Vivado软件
* 配置好环境的VS Code用以编写verilog代码


#### 实验过程
1. 搭建双稳态电路

   * Logisim按照顺序画出电路图

     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\eg'.png" alt="eg'" style="zoom:20%;" /><img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\eg1.png" alt="eg1" style="zoom:20%;" />

2. 搭建SR锁存器

   * Logisim画出逻辑图

     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\SR锁存器.png" alt="SR锁存器" style="zoom:16%;" />

   * 改变输入观察输出

     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\sr.png" alt="sr" style="zoom:10%;" /><img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\Sr.png" alt="Sr" style="zoom:10%;" /><img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\SR.png" alt="SR" style="zoom:10%;" />

3. 搭建D锁存器

   * 使用Logisim画出电路图

     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\eg3.png" alt="eg3" style="zoom:15%;" />
     
     
   
4. 搭建D触发器

   * 使用Logisim画出电路图

     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\D触发器.png" alt="D触发器" style="zoom:15%;" />

   * 根据电路写出Verilog代码

     ```verilog
     module d_ff (
         input clk,d,
         output reg q
     );
         always@(posedge clk) 
             q<=d;
     endmodule
     ```

   * 在电路中添加同步复位功能
     
     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\eg4-1.png" alt="eg4-1" style="zoom:15%;" />
     
   * 根据电路写出Verilog代码

     ```verilog
     module d_ff_r (
         input clk,rst_n,d,
         output reg q
     );
         always@(posedge clk)
         begin
             if(rst_n==0)
                 q<=1'b0;
             else
                 q<=d;
         end
     endmodule
     ```
     
    * 在电路中添加异步复位功能

    * 根据电路写出Verilog代码

      ```verilog
      module d_ff_s (
          input clk,rst_n,d,
          output reg q
      );
          always@(posedge clk or negedge rst_n)
          begin
              if(rst_n==0)
                  q<=1'b0;
              else
                  q<=d;
          end
      endmodule
      ```

      

5. 搭建寄存器

   * 使用logisim绘制电路图

     <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\寄存器.png" alt="寄存器" style="zoom:13%;" />

   * 根据电路图写出Verilog代码

     ```verilog
     module REG4(
         input clk,rst_n,
         input [3:0] D_IN,
         output reg [3:0] D_OUT
     );
         always@(posedge clk)
         begin
             if(rst_n==0)
                 D_OUT<=4'b0;
             else
                 D_OUT<=D_IN;
         end
     endmodule
     ```

     

6. 搭建简单时序逻辑电路

   * 使用logisim绘制电路

   * 根据电路写出Verilog代码

     ```verilog
     module RGE4 (
         input clk,rst_n,
         output reg [3:0] CNT
     );
         always@(posedge clk)
         begin 
             if(rst_n==0)
                 CNT<=4'b0;
             else
                 CNT<=CNT+4'b1;
         end
     endmodule
     ```

     

#### 实验练习

##### 题目一

* 使用Logisim绘制出电路图

  <img src="D:\wh030917\Documents\GitHub\magic\a魔术作业\lab3\pr1.png" alt="pr1" style="zoom:15%;" />

* 若S非为0则会使
  


#### 总结与思考