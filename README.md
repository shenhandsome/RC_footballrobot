# RC_footballrobot
##################robocom国赛注意事项####################1

1.总共有15版代码，其中各版代码里的1,2,3,4,5分别对应不同的点位，后场，中场，前场，角球，点球

2.其中，1为当初的测试版本，可以直接删除，2为华中科技大学的模板代码，自己写的时候可以参考，不过经过多次测试，由于场地和机器人因素，2基本废了，除非所有代码都没用，再采用2。

3.3为人工智能赛省赛代码，特点是点对点传球，传球力度无法控制，容易出现传到机器人身上弹出，4为3的激进版，不过是 在仿真环境里最稳定的，不过实地效果不佳。

4.5和8为人工智能赛的国赛代码，跟据1，2场地因素调的，采用最原始的瞄球门中心点向前传球，其中5的后场，中场，前场的力度分别为15，12，10，角球采用的是oppshoot1的dll（力度是15），8的后场，中场，前场的力度分别是12，10，8，角球用的是oppshoot2的dll（力度是12）。

5.第7版代码是测试版本，11，111，123，shuzhijieqiu是zsh采用竖直接球的测试版本，成功版本只有zsh有，test719是我写的所有比较成功的代码的模板（也是我自己写的哦），7的test96没啥用，单纯测试。

6.9是xyj的代码，给我们备份用的

7.第10版代码以第8版代码为基础，在射门环节加入了左右判断，后，中，前，角的力度为12，10，8，12.

8.！！！！！！！！！！！！！！！第11版代码尤为重要，是睿抗省赛代码，效果最理想，大概率是5球全进，用这版代码的除zsh点背，都进入了国赛。第11版代码改变了原来的传统思路，采用的是mid变量，对应的球场中心坐标，实现了传球版本的三合一，只要在此基础上改变传球力度即可（底层c++源码我会放在GitHub上开源或者发给你们）

9.第12版代码为11版力度减小版，后，中，前，角的力度分别是11，9，8，10，第13版代码是11版力度加大版，后，中，前，角的力度分别是15，12，10，15(由于1，2号场地略有不同，第一轮统一先用11，根据实时效果，采取力度变大或变小的策略)。

10.第14版代码是第10版代码的力度减小版，后，中，前，角的力度为11，9，8，10，第15版代码是第10版代码的力度加大版，后，中，前，角的力度分别为15，12，10，15（10，14，15三版代码为人工智能赛的国赛代码，作为备选方案）。

11.**！！！！！！！底层c++改变和dll生成：**至于底层c++无需多大改动了，可直接采用现有代码改变力度即可，由于我的代码是基于射门的改的，所以名字是shoot.sln，用vs2013直接打开它，在下图此处更改即可.

![image-20221017191024208](C:\Users\PC\AppData\Roaming\Typora\typora-user-images\image-20221017191024208.png)

然后点击下图的生成解决方案

![image-20221017191242645](C:\Users\PC\AppData\Roaming\Typora\typora-user-images\image-20221017191242645.png)

如果没有报错，则说明生成dll成功

!!!!!!!!!!!!!!!!!!!!!!!然后在Release文件夹里找到生成的dll。

12.至于射门的底层c++代码不是俺写的，是zsh写的，可以找他要。

####################################希望大家robocom国赛都能拿国一################################
