# 模拟数字电路实验
实验题目：Logisim入门 
学生姓名：叶子昂
学生学号：PB20020586
完成时间：2021年10月21日

### 实验题目
**logisim入门**
### 实验目的
* 能够自行搭建Logisim实验环境
* 熟悉Logisim的各种基本器件和基本操作
* 能够使用Logisim搭建组合逻辑电路并进行仿真
* 能够使用封装子电路并进行电路设计
* 了解虚拟机以及Lunix的基本操作
* 能够通过指导册上的样例电路举一反三完成题目
* 通过实践巩固模拟数字电路数字部分的知识
### 实验环境
* PC一台：Windows操作系统/Java运行环境(jre)
* 从官网上下载到本地的Logism仿真工具
* vlab实验中心(vlab.ustc.edu.cn)
### 实验过程
1. 从官网下载Logism
   - 找到官网  
     ![](D:\wh030917\Pictures\屏幕截图 2021-10-15 201018.png)
   - 下载  
     <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017193256264.png" alt="image-20211017193256264" style="zoom: 33%;" />
   
2. 观察Logisim的图形化界面熟悉了解界面各部分功能

   - 基本的菜单界面    

     <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017193537457.png" alt="image-20211017193537457" style="zoom: 50%;" />

3. 熟悉Logism的基本操作
	- 按指导书上的说明做一些简单的尝试  
	  
	  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017195444691.png" alt="image-20211017195444691" style="zoom: 50%;" />
	  
	- 参照help中的教程进一步了解Logisim的操作
	
	  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017195652238.png" alt="image-20211017195652238" style="zoom: 50%;" />
	
4. 模块封装

	- 作出电路结构
	
	  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017200343145.png" alt="image-20211017200343145" style="zoom: 50%;" />
	
	- 进行封装
	
	  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017200542425.png" alt="image-20211017200542425" style="zoom:50%;" />

### 实验练习
>#### 题目一
>
>* 先设置合适大小的LED点阵
>
> <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017200945088.png" alt="image-20211017200945088" style="zoom:80%;" />
>
>* 再连上合适位数的引脚控制
>
> <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017201135944.png" alt="image-20211017201135944" style="zoom: 35%;"/>
>
>
>
>* 按照自己的姓名点亮对应区域的LED灯
>
>  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211021221750779.png" alt="image-20211021221750779" style="zoom: 25%;" />
>
>


>#### 题目二
>* 按学号数目放置适宜个数的七段数码管
>
>  <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017202124680.png" alt="image-20211017202124680" style="zoom:80%;" />
>
>* 根据自己的学号点亮适宜位置的灯光
>
> <img src="D:\wh030917\a魔术作业\lab 1\学号图片.png" alt="学号图片" style="zoom:50%;" />

>#### 题目三
>* 按照指导书搭建或，与，非门
>
><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017202824984.png" alt="image-20211017202824984" style="zoom:39%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017203042955.png" alt="image-20211017203042955" style="zoom:37%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017203220369.png" alt="image-20211017203220369" style="zoom:30%;" />
>
>* 改变输入端状态观察输出情况判断上图分别为非门，与门，或门。
>
>* 尝试与非，或非门和异或，同或门。
>
><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017205458194.png" alt="image-20211017205458194" style="zoom:36%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017205536803.png" alt="image-20211017205536803" style="zoom: 40%;" /> 
>
><center style="color:#C0C0C0;text-decoration:underline">与非门或非门</center>
><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017210127522.png" alt="image-20211017210127522" style="zoom:50%;" />
>
><center style="color:#C0C0C0;text-decoration:underline">同或门异或门</center>

> #### 题目四
>
> * 先将题目三中与，或，非门封装
>
>   <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017210511472.png" alt="image-20211017210511472" style="zoom:67%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017210537066.png" alt="image-20211017210537066" style="zoom:67%;" /><img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017210610802.png" alt="image-20211017210610802" style="zoom: 50%;" />
>
> * 依据数字模拟电路所学知识设计1bit位宽二选一选择器
>
>   <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211017210829014.png" alt="image-20211017210829014" style="zoom:57%;" />
>   
> * 进一步设计2bit位宽四选一选择器
>
>   <img src="C:\Users\wh030917\AppData\Roaming\Typora\typora-user-images\image-20211021221554644.png" alt="image-20211021221554644" style="zoom: 33%;" />
>	即可知与或非门各需要12，6，2个
> 

### 总结与思考

1. 实验的收获

	- 通过本次实验我了解了Logisim的基本操作，了解了Logisim的用途，能够利用Logisim完成一些基本电路的设计和仿真
	- 通过vlab上的虚拟机简单了解了Linux系统，学会了一些基本的操作，知道了一些Linux系统的特性
2. 实验的难易程度
	- 个人感觉本次实验较为简单，仅涉及基础的电路设计（如题三，题四）和仿真基本的应用（如题一，题二）并无太多思考上的困难
3. 实验的任务量
	- 一般，思考上较为简单，但第一次配置环境和题目一，二中不少繁复的重复性点击仍消耗不少时间
4. 对本实验的建议
	- 可以适当减少题一这种类型的重复工作量（而且点好的无法保存）如仅需显示自己的姓氏等
	- 可以增加题目中元器件的种类以便在实践中掌握更多元器件的功能和特性
