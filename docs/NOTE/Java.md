# Java

!!! warning "本JAVA教程是为了CS61B而做的，不涉及讲解太深的JAVA知识，待CS61B completed才系统讲解"  

## Java简介  

**Java**是一种广泛使用的计算机编程语言，拥有跨平台、面向对象、泛型编程的特性，广泛应用于企业级Web应用开发和移动应用开发。  
  
Java不同于一般的编译语言或解释型语言。它首先将源代码编译成字节码，再依赖各种不同平台上的**虚拟机**来解释执行**字节码**，也就是先编译后解释，从而具有“一次编写，到处运行”的跨平台特性。以下是其程序的构建过程  

![image](../assets/quote/compilation_figure.svg)  

Java 的构建方式如下：  

```Java
$ javac Hello.java
$ java Hello
Hello World!
```  

## Java 基本语法  
这里给出Java 的关键语法特征  

- Java 程序是`.class`结尾，必须保证创建的Java文件名和类名相同，且要想该类能够作为入口调用，必须写上`main`方法  
- Java 程序中的基本组成单位是`class`，所有的代码都是放在类中运行的，类声明由关键字`public class`  
- Java 程序的运行入口为该类的`main`方法，该方法声明为`public static void main(String[] args)`  
- 语句必须以`;`结束；每个语句块使用`{`和`}`包括起来  
- 变量的声明创建必须说明其数据类型（静态数据类型，Java 变量只能包含该类型的值） 
- 函数必须指定返回类型，如果没有返回值，则使用`void`关键字  
  
??? note "Java 的静态数据类型"  
    Java 编译器的一个关键特性就是其执行静态类型检查，假设下面的程序：  
    ``` Java
    public class HelloNumbers {
        public static void main(String[] args) {
            int x = 0;
            while (x < 10) {
                System.out.print(x + " ");
                x = x + 1;
            }
            x = "horse";
        }
    }
    ```  
    编译时会有如下的结果，原因就在于Java 编译器在编译前会对变量进行**类型检查**，这时程序在编译时发现问题，就保证了程序类型的正确性    
    ``` Java
    $ javac HelloNumbers.java 
    HelloNumbers.java:9: error: incompatible types: String cannot be converted to int
            x = "horse";
                    ^
    1 error
    ```  
  

下面给出一个`sample`程序，去理解上面的特征  
``` Java
public class HelloNumbers {
    public static void main(String[] args) {
        int x = 0;
        //打印从0-9的数字
        while (x < 10) {
            System.out.print(x + " ");
            x = x + 1;
        }
    }
}

```  


### 基本数据类型  
Java 的数据类型和C语言基本一致，有如下的数据类型  

| 类型 | 分类 | 占用空间 |
| --- | --- | --- |
|byte|整数|一字节|
|short|整数|二字节|
|int|整数|四字节|
|long|整数|八字节|
|float|浮点数|四字节|
|double|浮点数|八字节|
|char|字符|二字节|
|boolean|布尔|四字节|

创建变量时按照上图的进行变量的声明和定义  
  
**引用数据类型**  
  
除开基本数据类型外的其他数据类型，都称为**引用数据类型**  
  
对于引用数据类型，本质赋值给变量的值*都是该数据类型创建后的数据块最前面块的首地址*，所以对其成员的任何访问都可以修改影响到实际(思考函数的传参)  
  
看如下的`sample`来理解，这里一个关键点就是参数的传递等价于其复制了传入参数的值给他，以及`=`表示直接将右值给左式  
``` Java  
public class Foo {
    public int x, y;
    public Foo (int x, int y) {
        this.x = x;
        this.y = y;
    }
    public static void switcheroo (Foo a, Foo b) {
        Foo temp = a;
        a = b;
        b = temp;
    }
    public static void fliperoo (Foo a, Foo b) {
        Foo temp = new Foo(a.x, a.y);
        a.x = b.x;
        a.y = b.y;
        b.x = temp.x;
        b.y = temp.y;
    }
    public static void swaperoo (Foo a, Foo b) {
        Foo temp = a;
        a.x = b.x;
        a.y = b.y;
        b.x = temp.x;
        b.y = temp.y;
    }
    public static void main (String[] args) {
        Foo foobar = new Foo(10, 20);
        Foo baz = new Foo(30, 40);
        switcheroo(foobar, baz); //foobar.x: 10 foobar.y: 20 baz.x: 30 baz.y: 40
        fliperoo(foobar, baz);//foobar.x: 30 foobar.y: 40 baz.x: 10 baz.y: 20
        swaperoo(foobar, baz);//foobar.x: 10 foobar.y: 20 baz.x: 10 baz.y: 20
    }
}
```  


**数组**  
  
Java 中的数组创建行为和 C 基本类似，但是直接支持动态和静态大小的创建，而不使用`malloc`这样的函数，看如下`sample`  
  
一个小技巧就是将`[]`视为`C`中的`*`，即创建了指针类型(事实上本质就是)  

``` Java
int[] array = new int[8];//声明但是无值
int[] array = new int[]{1,3,4,5};//声明的同时初始化  

int[] array = new int[n];//动态长度的数组  

//二维数组
int[][] array = new int[][];//可以视为二级指针，注意第一个数字必须指定，第二个可以不指定大小  
```  


### 条件分支和循环  
  
Java 中的条件分支和循环语句和 C 中的一致  

#### 条件分支  

- `if`语句  
    ``` Java
    if(condition){
        statements;
    }
    ```  

- `if-else` 语句
    ``` Java
    if (conditon){
        statements;
    }
    else{
        statements;
    }
    ```  
- `if-else if-else` 语句  
    ``` Java
    if (condition){
        statements;
    }
    else if(condition){
        statements;
    }
    else{
        statements;
    }
    ```  

#### 循环  
  
- `while` 语句  
    ``` Java
    while(condition){
        statements;
    }
    ```  

- `for` 语句  
    ``` Java
    for(init;conditon;increment){
        statements;
    }

    /*以下为增强for循环，可以用于遍历数组等内置的数据结构
      注意对于数组的遍历时等效于复制数组的值给变量，则修改变量时不会影响到数组的数据
    */
    for(type elem:arr){
        statements;
    }
    ```  

> `continue` 和 `break` 在Java中的行为同 C 一致，`goto`关键字虽然被保留，但是无法使用  

### 函数  
  
Java 中任何函数的定义都必须写在**类**中，并要求使用`public static`的关键字和指明其返回的数据类型，其他行为同 C ，如下是其一个`sample`  
``` Java  
public static int function(int x,int y){
    return max(x,y);
}
```  
  
在这里去掉函数名和相关修饰符并保留输入输出类型，我们把`int (int,int)`叫作**函数签名**  

事实上，在Java 中，函数都被称为方法，因为其总是在类中实现  
  
注意函数传参中只要不是引用类型就不会对传入的参数造成影响  
  
#### 高阶函数  
  
接收一个函数为参数的函数称之为高阶函数，在Java 中主要依靠类来实现（传递类实例，然后调用方法），看如下`sample`  
``` Java
/* python形式
def time10(x):
    return 10*x

def do-twice(f,x):
    return f(f(x))

do-twice(time10,x)

*/

/* Java 实现 */
public interface IntUnaryFunction{
    int apply(int x);
}

//不一定要继承，也可以直接写，这里是为了通过继承，写任意操作的(避免写多个类)
public class TenX implements IntUnaryFunction{
    int apply(int x){
        return x*10;
    }
}

//某个类内
public class do-twice(IntUnaryFunction f,x){
    return f.apply(f.apply(x));
}

```  
$~~$  

## 类  

### 定义和使用

在Java 中，要定义类，有如下的语法  

``` JAVA
public class <name>{

}

/* 类可以嵌套创建 可以将类中的嵌套类看成结构体 */
public class <name>{
    public class <nested>{
        ....
    }

    ....
}

```  
  
这样便创建了一个类，使用类比Python 中我们将其看成一个数据类型  

``` Java  
<classname> variable = new <classname>()

```  
被创建的`variable`称为**对象**或**实例**，创建的过程称为实例化(instantiated)  
  
以下为`sample`以供你理解类，如何去创建和使用访问类的成员  

``` Java  
public class dog{
    public static int age = 12;
    public static int makenoise(){
        System.out.println("woooof!");
    }
}

public class dogLauncher{
    public static void main(String args[]){
        dog d = new dog();
        d.makenoise();
        System.out.println(d.age);
    }
}
```  
  
类似的，在Java 中也有构造函数(constructor)，用于实例化时快速的初始化对象的一些属性，构造函数不需要返回类型和`static`关键字  
``` Java
public class dog{
    public int age;
    public dog(int age){
        this.age = age; //this等价于python中的self
    }
}

public class dogLauncher{
    public static void main(String args[]){
        dog d = new dog(12);
    }
}
```  
$~~$   
**静态成员和非静态成员**  
  
成员：属性和方法的统称  
  
`static`关键字在类中的作用，主要确定该成员是否是在类中使用还是被实例化时使用，看如下的`sample`  
``` Java  
public class dog{
    public static String name = "dog";
    public int age;
    public static int maxDog(dog d1,dog d2){
        return d1.age>d2.age?d1:d2;
    }
    public int maxDog(dog d2){
        return this.age>d2.age?this:d2;
    }
}
public class dogLanucher{
    public static void main(String args[]){
        dog d1 = new dog(12),d2 = new dog(14);
        System.out.println(d1.age);
        Syetem.out.println(dog.age);
        dog maxd = dog.maxDog(d1,d2);//调用dog中的第一个方法
        maxd = d1.maxDog(d2);//调用dog中的第二个方法
    }
}
```  
  
- 对于`static`关键字的成员称为类成员/静态成员，只能使用类名访问使用  
- 不含`static`关键字的成员称为实例成员/非静态成员，只有实例化后才能使用  
- 静态方法不能访问非静态成员；**实例可以访问静态成员**，且所有实例共享同一个静态变量  
  

### 继承  
  
Java 中同样可以实现子类对父类的继承，主要通过`interface`和`implements`以及`extends`关键字  
  
然而在Java 中的对父类定义是通过定义接口，实现细节由子类确定，只指明**干什么**（默认方法可以由父类实现），而不说咋做  
  
注意当什么也为继承的类，其继承`Object`类  

``` Java  
/*
    使用interface关键字
    当需要默认方法实现时用dafault关键字，此时该函数内部只能调用接口的函数
    对于implement 为interface的子类，必须实现全部的父类的接口函数，否则报错
*/
public interface name{
    public void function1();

    public void function2();

    ...

    default void function3();
}


/* 
    继承由下面的格式
    implements 关键字
    默认函数也可以override
    覆写的函数可以加@Override关键字来标记其是覆写函数
*/

public class subname implements name{
    public void function1(){
        ....
    }
    
    public void function2(){
        ....
    }

    ...
}


/*  extends关键字用于在已经实现了interface的情况下继续继承上一个，形成层次结构
    仍然支持覆写父类的所有方法
*/

public class subclass extends superclass{
    ....
}

```  
  

**重载和覆写**  

 重载：对同一个函数的函数签名进行修改，修改函数处理类型，而不改变函数的功能  
   
 覆写：对已有的函数进行重新写，会影响改变函数的功能  

``` Java
/* 重载  */
public class name{
    //函数签名为 int(int int)
    public static int max(int a,int b){
        return Math.max(a,b)
    }
    //此时就是重载 函数签名为 float (float float)
    public static float max(float a,float b){
        return Math.max(a,b)
    }
}

/* 覆写 */
public interface super{
    public void function();

    default void function2(){
        ....
    }
}

public class sub1 implements super{
    public void function(){
        ....
    }

    public void function2(){
        ....
    }

    /* 
    这两个过程都属于覆写 
    继承写接口实现按接口的功能来就行了
    */
}

```  
  
**区分**：区分两者的区别就用是否修改**函数签名**来判断，修改就是`overloading`否则`override`  
$~~$  
**引用类型在继承中的影响**  
  
对于子父类的继承，父类型可以存储子类型的实例，Java中父类包含子类，看如下的例子  

``` Java
/* smallDog 是Dog的子类 */
Dog d = new smallDog();//该操作是合法的

```  
  
当访问d实例的成员时，该访问誰的呢？遵循的原则就是 先子类 再父类  
  
??? note "静态数据类型与类" 
    对于类的类型，Java 同样会进行静态数据类型的检查，遵循  
      
    - 父类可以接受子类的实例  
    - 子类不能接受父类的实例  
      
    要想强制让子类接受父类实例时，只需要强制类型转换即可，但是请保证运行时其类型一定为子类的类型  

**静态数据类型和动态数据类型**：  

思考下面的一段代码：
  
``` Java  
public interface Animal{
    default void greet(Animal a){...}
    default void sniff(Animal a){...}
    default void praise(Animal a){...}
}

public class Dog implements Animal{
    @Override
    void sniff(Animal a){...}

    @Override
    void praise(Dog a){...} //这个是覆写还是重载? 
}

/* 调用  */
Animal a = new Dog();
Dog d = new Dog();
a.greet(d);
a.sniff(d);
d.praise(d);
a.praise(d);

```  
  
- 静态数据类型：程序编译时的类型，即声明变量前的类型  
  
- 动态数据类型：实际运行时的类型，后面`new`关键字创建的实际类型  

在Java 中，当程序执行时，先是调用静态类型下的方法，通过静态类型确定方法签名，当真正执行时再去动态类型中找是否有其`override`，无则回到`default`中；无论静态动态都会先在子类找，后再去寻找父类的方法  
  
当执行`a.praise(d)`静态时的函数签名为`void(Animal)`，而`Dog`实现中进行了`overload`，导致函数签名为`void(Dog)`，调用时无法找到动态类型中的相同函数签名，由此分析可以得出`a.praise(d)`实际调用的函数是`Animal`类  

**值得注意**的是，当编译进行静态数据检查时，进行严格的数据类型检查，会优先匹配子类的方法参数类型（自动隐式转换（向上且最近父亲）），然后再去父类寻找，直到参数类型不匹配直接报错；而对于显式向下转换，只能将其转换到动态类型的类，要是转到更低的类会报错（子类含有的方法比父类多）  
  
$~~$  

**构造函数的继承**  

子类会继承父类所有的成员，包括如下  

  - 所有实例和静态变量  
  - 所有方法  
  - 所有嵌套类  

但是对于父类的构造函数，并不会继承，当创建子类进入子的构造函数时，会先调用父类的构造函数后再执行子类的初始化，看如下的代码  

``` Java
public class anotherSList extends SList{
    ....

    public anotherSList(){
        System.out.println("completed!");
    }
}


anotherSList one = new anotherSList();//当调用该函数时实际构造函数如下

public anotherSList(){
    super();//不显示调用时，都默认调用该构造函数
    System.out.pritnln("completed!"); 
}


```  

因此注意到，当创建子类带参数的构造函数访问时，若也要用参数初始化父类，则需要显示调用`super()`并传入参数  
  
`super`还代表父类，当子类想要访问父类的方法或成员时，可以通过`super.<member>`来访问；但**注意`super`只能使用一次**，即子类只能访问自己的父类，不能访问所有的祖先    
  
$~~$  
  
**接口在自定义比较方式上的运用**  
  
对于用户自定义的对象，有时会想要对对象按照某种规则来比较‘大小’，传统方法时对每个类都写一个方法来实现；在C或Python中高级的用法是重载比较符，但在Java 中无法实现  
  
Java实现的方法有两种；  
  
 - 类继承接口`Comparable`，实现其中的`compareTo`方法，然后写通用比较函数时传入的参数是`Comparable`类  
 - 类中嵌套一个类，其实现`comprator`接口的`compare`方法，然后创建`comparator`继承类的实例，调用他的方法来比较对象  
   
这两者的区别就主要在于前者是调用自己的方法来实现；后者则是通过一个嵌套类的方法来比较，所以创建实例的方法是`static`方法  

``` Java  
/* way1  */
public class Dog implements Comparable<Dog>{
    ....

    public int compareTo(Dog uddaDog){
        ....
    }
}

//比较方法  具有通用性，只要自定义类实现Comparable<T>
public static Comparable max(Comparable items) {
    int maxDex = 0;
    for (int i = 0; i < items.length; i += 1) {
        int cmp = items[i].compareTo(items[maxDex]);//这里是比较
        if (cmp > 0) {
            maxDex = i;
        }
    }
    return items[maxDex];
}

/* way2 */
public class Dog{
    ....
    private static class NameComparator implements Comparator<Dog>{
        public int compare(Dog a,Dog b){
            ....
        }
    }

    public static Comparator<Dog> getNameComparator() {
        return new NameComparator();
    }
}

//使用时 当你有一个comparator对象时，直接用他方法即可！
Comparator<Dog> nc = Dog.getNameComparator();
Dog greatest = nc.compare(d1,d2);

```  
  
