  

<div style="text-align:center;font-size:2em;font-weight:bold">中国科学技术大学计算机学院</div>


<div style="text-align:center;font-size:2em;font-weight:bold">《数字电路实验报告》</div>







![image-20211028163846705](C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211028163846705.png)







<div style="display: flex;flex-direction: column;align-items: center;font-size:2em">
<div>
<p>实验题目：使用Vivado进行仿真 </p>
<p>学生姓名：叶子昂</p>
<p>学生学号：PB20020586</p>
<p>完成时间：2021年10月18日</p>
</div>
</div>



<div style="page-break-after:always"></div>

#### 实验题目
**使用Vivado进行仿真**

#### 实验目的

* 熟悉Vivado软件的下载，安装使用

* 学习使用Verilog编写仿真文件
* 学习使用Vivado进行仿真，查看并分析波形文件

#### 实验环境

* 装有windows，能连校园网的笔记本电脑

* 本地的Vivado软件

* 配置好环境的VS Code用以编写verilog代码

* vlab.ustc.edu.cn综合平台

#### 实验练习
##### 题目一

*请编写 Verilog 仿真文件，生成如下图所示的波形，并在Vivado中进行仿真。*
															<img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211118155846749.png" alt="image-20211118155846749" style="zoom: 33%;" />

* 据题图编写仿真文件如下：

  ```verilog
  module test_bench();
      reg a,b;
      initial begin
          a=1;
          b=0;
          #100 b=1;
          #100 a=0;
          #100 b=0;
          #100 b=1;
          #100 $stop;
      end
  endmodule
  ```
* 在Vivado中创建项目将所写仿真文件添加到项目中后启动模拟仿真得到如下波形图与题目相符。

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211118160227363.png" alt="image-20211118160227363" style="zoom:67%;" />

##### 题目二		

*请编写 Verilog 仿真文件，生成如下图所示的波形，并在Vivado 中进行仿真。*  

<img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211118160348052.png" alt="image-20211118160348052" style="zoom:33%;" />

* 据题图编写仿真文件如下：

  ```verilog
  module test_bench (  );
    reg clk,RST_N,D;
      //wire o;//在题目三中使用
      //d_ff_r d_ff_r(.clk(clk),.rst_n(RST_N),.d(D),.q(o));//在题目三中使用
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end 
    initial begin
        RST_N=0;D=0;
        #12.5 D=1;
        #15 RST_N=1;
        #10 D=0;
        #17.5 $stop;
    end
  endmodule
  ```
* 在Vivado中创建项目将所写仿真文件添加到项目中后启动模拟仿真得到如下波形图与题目相符。

​	                     <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211118160629131.png" alt="image-20211118160629131" style="zoom: 50%;" />

##### 题目三

*利用题目2 中的信号作为以下代码的输入，在 Vivado 中对其仿真，并观察仿真波形。*

```verilog
/*
module d_ff_r(
input clk,rst_n,d,
output reg q);
	always@(posedge clk)
	begin
        if(rst_n==0)
            q <= 1’b0;
        else
            q <= d;
	end
endmodule
*/
```

* 将题中代码作为源文件添加到与题二中仿真文件相同项目中（取消题二中代码注释）进行仿真得波形图如下：

  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211118161937348.png" alt="image-20211118161937348" style="zoom:80%;" />

##### 题目四

*设计一个 3-8 译码器，编写仿真测试文件， 在 Vivado 中对其进行仿真。 要求仿真时遍历所有的输入情况组合， 给出源代码和仿真截图。*  

* 首先设计译码器使用$$\overline{E_1},\overline{E_2},E_3$$作为使能信号分别为0，0，1时使能有效，有任何一个使能无效时8位二进制输出$$Y$$全部置1。

  当使能有效时将$$Y$$中三位二进制输入$$A$$所对应的十进制数的输出置0

* 源代码如下：

  ```verilog
  module trancode (
      input [3:0] A,
      input _E1,_E2,E3,
      output reg [7:0] _Y
  );
     always@(*)
     begin
         if(E3==1'b0||_E2==1'b1||_E1==1'b1)//使能无效
          _Y=8'b1111_1111;
         else                              //使能有效
         begin
          case(A)
          3'h7:_Y=8'b0111_1111;
          3'h6:_Y=8'b1011_1111;
          3'h5:_Y=8'b1101_1111;
          3'h4:_Y=8'b1110_1111; 
          3'h3:_Y=8'b1111_0111;
          3'h2:_Y=8'b1111_1011;
          3'h1:_Y=8'b1111_1101;
          3'h0:_Y=8'b1111_1110;
          default:_Y=8'b1;
          endcase
         end     
     end 
  endmodule
  ```
  
* 仿真先测试使能无效，此时输入A置为0\~7的随机值。再使使能有效，先使A随机一次再按0~7顺序测试。
  
  ```verilog
  module test_bench (
      
  );
     reg [3:0] A;
     reg _E1,_E2,E3;
     wire [7:0] _Y;
     integer i=0;
     trancode trancode(.A(A),._E1(_E1),._E2(_E2),.E3(E3),._Y(_Y));
     initial begin
         _E1=1;_E2=0; E3=1; A=3'h0;//使能无效，初始化输入A
         #10 _E1=0; _E2=1; E3=1; A={$random}%8;//使能无效，随机输入A
         #10 _E1=0; _E2=0; E3=0; A={$random}%8;//使能无效，随机输入A
         #10 _E1=0; _E2=0; E3=1; A={$random}%8;//使能有效，随即输入A
         for(i=0;i<8;i=i+1)begin//顺序测试0~7
             #10 A=i;
         end
         #10 $stop;
     end 
  ```
  
* 将上两文件加入到同一项目进行模拟仿真，得到波形图如下：  
  
  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211118163949810.png" alt="image-20211118163949810" style="zoom:80%;" />

#### 总结与思考

* 本次实验的收获
* 本次实验的难易程度
* 本次实验的任务量
* 对本次实验的建议

