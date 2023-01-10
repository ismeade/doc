# JVM基础入门

## java从编码到执行

### javac
x.java -> javac -> x.class  

### java
[API Documents](https://docs.oracle.com/en/java/javase/index.html)
 
### JVM
跨语言平台，可以执行100多种语言，如java、kotlin、groovy、jruby等

jvm与class有关，与java无关，任何语言只要能编译成class文件，符合class文件格式就可以在jvm中执行

jvm是一种规范  
[JVM规范](https://docs.oracle.com/javase/specs/index.html)
```
#JVM
x.class -> ClassLoader <- java类库  
           |       |
    字节码解释器 JIT即时编译器
           |       |
           执行引擎
               ｜
               OS硬件
        
x.class -> 类加载子系统 -> 方法区 -> 执行引擎(解释器，JIT编译器，垃圾回收器)
```
#### 执行引擎
解释器：执行字节码指令  
JIT编译器：把热点字节码指令编译成机器指令并缓存起来，提高执行效率。

#### 运行时数据区
方法区：由类加载子系统，将字节码指令存放到内存中的方法区  
Java方法栈：存放java方法  
本地方法栈：native方法  
程序计数器：记录下一条要执行的指令地址

#### 类加载子系统
```
#类加载过程
x.class -> 加载 -> 链接(验证 -> 准备 -> 解析) -> 初始化

```
加载：把class文件从硬盘读取到内存中  
验证：验证待加载的class文件是否正确  
准备：为static变量分配内存并赋默认值  
解析：将符号引用解析为直接引用，符号引用相当于类的名字，直接引用相当于类的内存地址  
初始化：为static变量赋初始值

#### 类加载器
- 引导类加载器 BootStrapClassLoader

- 自定义类加载器 继承实现ClassLoader类

#### 懒加载
什么时候需要什么时候加载
