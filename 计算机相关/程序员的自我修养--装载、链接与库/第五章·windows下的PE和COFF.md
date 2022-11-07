## 5.1 windows下的二进制文件格式PE/COFF

+ COFF Common Object File Format 目标文件格式
+ PE COFF的扩展，可执行文件格式
+ PE32+ 64位系统，并没有添加任何结构，最大的变化就是把那些原来32位的字段变成了64位，比如文件头中与地址相关的字段。绝大部分情况下，PE32+与PE的格式一致，我们可以将它看作是一般的PE文件。

## 5.2 PE的前身COFF

COFF文件的文件头部包括了两部分，一个是描述文件总体结构和属性的映像头（Image Header），另外一个是描述该文件中包含的段属性的段表（Section Table）。文件头后面紧跟着的就是文件的段，包括代码段、数据段等，最后还有符号表等。整体结构如图5-1所示。

映像（Image）：因为PE文件在装载时被直接映射到进程的虚拟空间中运行，它是进程的虚拟空间的映像。所以PE可执行文件很多时候被叫做映像文件（Image File）

!(图片)[../../../.assets/2022101759.png]

**COFF文件的header**

```
typedef struct _IMAGE_FILE_HEADER {
    WORD    Machine;//目标机器类型
    WORD    NumberOfSections;//段的数量
    DWORD   TimeDateStamp;//文件的创建时间
    DWORD   PointerToSymbolTable;//符号表的位置
    DWORD   NumberOfSymbols;//
    WORD    SizeOfOptionalHeader;//option header的大小，只存在于PE文件中
    WORD    Characteristics;
} 
```
映像头后面紧跟段表，它是一个类型为“IMAGE_SECTION_ HEADER”结构的数组，数组里面每个元素代表一个段，这个结构跟ELF文件中的“Elf32_Shdr”很相似。
```
typedef struct _IMAGE_SECTION_HEADER {
    BYTE    Name[8];//段名
    union {
            DWORD   PhysicalAddress;//物理地址
            DWORD   VirtualSize;//该段被加载至内存后大小
    } Misc;
    DWORD   VirtualAddress;//虚拟地址
    DWORD   SizeOfRawData;//原始数据大小
    DWORD   PointerToRawData;//段在文件中的位置
    DWORD   PointerToRelocations;//该段的重定位表在文件中的位置
    DWORD   PointerToLinenumbers;//该段的行号表在文件中的位置
    WORD    NumberOfRelocations;
    WORD    NumberOfLinenumbers;
    DWORD   Characteristics;//段的属性：段类型（代码、数据、bss）、对齐方式、可读可写可执行
} IMAGE_SECTION_HEADER, *PIMAGE_SECTION_HEADER;
```

段表后面就是一个个段的实际内容。两个ELF文件中不存在的段，这两个段就是“.drectve”段和“.debug$S”段。

## 5.2 链接指示信息
.drectve段，链接指示信息段。

段表中，该段的信息
```
SECTION HEADER #1
.drectve name
    0 physical address
    0 virtual address
    18 size of raw data
    DC file pointer to raw data (000000DC to 000000F3)
    0 file pointer to relocation table
    0 file pointer to line numbers
    0 number of relocations
    0 number of line numbers
  100A00 flags //该段的属性即Characteristics
         Info  //信息段
         Remove //目标文件中移除该段
         1 byte align //1字段对齐

```
该.drectve段的原始数据.
“dumpbin”知道该段是个“.drectve”段，并且对段的内容进行了解析，解析结果为一个“/DEFAULTLIB:‘LIBCMT’”的链接指令”。
```

RAW DATA #1
  00000000: 20 20 20 2F 44 45 46 41 55 4C 54 4C 49 42 3A 22     /DEFAULTLIB:"
  00000010: 4C 49 42 43 4D 54 22 20                          LIBCMT" 

   Linker Directives
   -----------------
   /DEFAULTLIB:"LIBCMT”
```
## 5.4 调试信息
COFF文件中所有以“.debug”开始的段都包含着调试信息。

比如“.debug$S”表示包含的是符号（Symbol）相关的调试信息段；“.debug$P”表示包含预编译头文件（Precompiled Header Files）相关的调试信息段；“.debug$T”表示包含类型（Type）相关的调试信息段。

```
SECTION HEADER #2
.debug$S name
    0 physical address
    0 virtual address
     86 size of raw data
      F4 file pointer to raw data (000000F4 to 00000179)
    0 file pointer to relocation table
    0 file pointer to line numbers
    0 number of relocations
    0 number of line numbers
42100040 flags
         Initialized Data
         Discardable
         1 byte align
         Read Only
```

```
RAW DATA #2
  00000000: 02 00 00 00 46 00 09 00 00 00 00 00 3F 43 3A 5C  ....F.......?C:\
  00000010: 57 6F 72 6B 69 6E 67 5C 62 6F 6F 6B 5C 63 6F 64  Working\book\cod
  00000020: 65 5C 43 68 61 70 74 65 72 20 32 5C 53 69 6D 70  e\Chapter 2\Simp
  00000030: 6C 65 53 65 63 74 69 6F 6E 73 5C 53 69 6D 70 6C  leSections\Simpl
  00000040: 65 53 65 63 74 69 6F 6E 2E 6F 62 6A 38 00 13 10  eSection.obj8...
  00000050: 00 22 00 00 07 00 0E 00 00 00 27 C6 0E 00 00 00  ."........'?....
  00000060: 27 C6 21 4D 69 63 72 6F 73 6F 66 74 20 28 52 29  '?!Microsoft (R)
  00000070: 20 4F 70 74 69 6D 69 7A 69 6E 67 20 43 6F 6D 70   Optimizing Comp”
```

## 5.5 符号表
```
COFF SYMBOL TABLE
000 006DC627 ABS    notype      Static        | @comp.id
001 00000001 ABS    notype      Static      | @feat.00
002 00000000 SECT1  notype      Static      | .drectve
    Section length   18, #relocs  0, #linenums  0, checksum     0
004 00000000 SECT2  notype      Static      | .debug$S
    Section length   86, #relocs  0, #linenums  0, checksum     0
006 00000004 UNDEF  notype      External    | _global_uninit_var
007 00000000 SECT3  notype      Static      | .data
    Section length    C, #relocs  0, #linenums  0, checksum AC5AB941
009 00000000 SECT3  notype      External    | _global_init_var
00A 00000004 SECT3  notype      Static      | $SG594
00B 00000008 SECT3  notype      Static      | ?static_var@?1??main@@9@9 (`main'::`2'::static_var)
00C 00000000 SECT4  notype      Static      | .text
    Section length   4E, #relocs    5, #linenums  0, checksum CC61DB94
00E 00000000 SECT4  notype ()   External    | _func1
00F 00000000 UNDEF  notype ()   External    | _printf
010 00000020 SECT4  notype ()   External    | _main
011 00000000 SECT5  notype      Static    | .bss
    Section length    4, #relocs  0, #linenums  0, checksum     0
013 00000000 SECT5  notype      Static    | ?static_var2@?1??main@@9@9 ('main'::'2'::static_var2)
```
从左向右，每一列表示
+ 符号下标 
+ 符号大小 
+ 符号所在位置 
+ 符号类型
    + notype 变量和其他
    + notype() 函数
+ 符号的可见范围
    + static 局部
    + External 全局
+ 符号名
+ 另外所有的段名都是一个符号，“dumpbin”如果碰到某个符号是一个段的段名，那么它还会解析该符号所表示的段的基本属性，每个段名符号后面紧跟着一行就是段的基本属性，分别是段长度、重定位数、行号数和校验和

## 5.6 Windows下的ELF--PE

PE是基于COFF的扩展，它比COFF多了几个结构。

+ DOS MZ File Header and stub
    + IMAGE_DOS_HEADER
    + Image DOS stub
+ IMAGE_NT_HEADERS
    + IMAGE_FILE_HEADERS
    + IMAGE_OPTIONAL_HEADER32/64
历史包袱，早期的windows不能脱离DOS单独运行。 Image DOS Header 和 DOS stub是为了兼容DOS系统设计。当pe文件在DOS下被执行时，会读取e_cs 和e_ip俩个值，跳转到DOS stub。

dos stub是一小段可以在dos 下执行的代码，效果是输出“This program cannot be run in DOS”。

所以我们唯一需要关心的是e_lfanew这个成员，表示PE文件头在文件中的偏移。为0则为真正的DOS‘MZ’文件，不为0则是PE文件。


**IMAGE_NT_HEADERS 真正的文件头**
```
typedef struct _IMAGE_NT_HEADERS {
    /**
      “合法的PE文件来说，它的值为0x00004550，按照小端字节序，它对应的是’P’、‘E’、‘\0’、‘\0’这4个字符的ASCII码”
    */
    DWORD Signature;
    /**
    COFF通用的文件头结构
    */
    /**
    PE文件来说必须得扩展结构，COFF文件非必须。
    */
    IMAGE_OPTIONAL_HEADER OptionalHeader;
} IMAGE_NT_HEADERS, *PIMAGE_NT_HEADERS;
```
**IMAGE_OPTIONAL_ HEADER32 PE文件头的必须扩展结构**

64位和32位大同小异，只不过关于地址和长度的一些成员从32位扩展成了64位，还增加了若干个额外的成员之外，没有其他区别。

里面很多成员跟PE文件的装载和运行有关。

```
typedef struct _IMAGE_OPTIONAL_HEADER {
    //
    // Standard fields.
    //
    WORD    Magic;
    BYTE    MajorLinkerVersion;
    BYTE    MinorLinkerVersion;
    DWORD   SizeOfCode;
    DWORD   SizeOfInitializedData;
    DWORD   SizeOfUninitializedData;
    DWORD   AddressOfEntryPoint;
    DWORD   BaseOfCode;
    DWORD   BaseOfData;

    //
    // NT additional fields.”
    “    DWORD   ImageBase;
    DWORD   SectionAlignment;
    DWORD   FileAlignment;
    WORD    MajorOperatingSystemVersion;
    WORD    MinorOperatingSystemVersion;
    WORD    MajorImageVersion;
    WORD    MinorImageVersion;
    WORD    MajorSubsystemVersion;
    WORD    MinorSubsystemVersion;
    DWORD   Win32VersionValue;
    DWORD   SizeOfImage;
    DWORD   SizeOfHeaders;
    DWORD   CheckSum;
    WORD    Subsystem;
    WORD    DllCharacteristics;
    DWORD   SizeOfStackReserve;
    DWORD   SizeOfStackCommit;
    DWORD   SizeOfHeapReserve;
    DWORD   SizeOfHeapCommit;
    DWORD   LoaderFlags;
    DWORD   NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
} IMAGE_OPTIONAL_HEADER32, *PIMAGE_OPTIONAL_HEADER32;
```

### 5.6.1 PE 数据目录
在Windows系统装载PE可执行文件时，往往须要很快地找到一些装载所须要的数据结构，比如导入表、导出表、资源、重定位表等。这些常用的数据的位置和长度都被保存在了一个叫数据目录（Data Directory）的结构里面，其实它就是前面“IMAGE_OPTIONAL_ HEADER”结构里面的“DataDirectory”成员。这个成员是一个“IMAGE_DATA_DIRECTORY”的结构数组，相关的定义如下：

```
//IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];

typedef struct _IMAGE_DATA_DIRECTORY {
    DWORD   VirtualAddress; //虚拟地址
    DWORD   Size;//长度
} IMAGE_DATA_DIRECTORY, *PIMAGE_DATA_DIRECTORY;

#define IMAGE_NUMBEROF_DIRECTORY_ENTRIES    16
```
WinNT.h”里面定义了一些以“IMAGE_DIRECTORY_ENTRY_”开头的宏，数值从0到15，它们实际上就是相关的表的宏定义在数组中的下标。
比如：IMAGE_DIRECTORY_ENTRY_EXPORT”被定义为0，所以这个数组的第一个元素所包含的地址和长度就是导出表（Export Table）所在的地址和长度。

这个数组中还包含其他的表，比如导入表、资源表、异常表、重定位表、调试信息表、线程私有存储（TLS）等的地址和长度。这些表多数跟装载和DLL动态链接有关.

## 5.7 本章小结

在这一章中，我们介绍了Windows下的可执行文件和目标文件格式PE/COFF。PE/COFF文件与ELF文件非常相似，它们都是基于段的结构的二进制文件格式。Windows下最常见的目标文件格式就是COFF文件格式，微软的编译器产生的目标文件都是这种格式。COFF文件有一个很有意思的段叫“.drectve段”，这个段中保存的是编译器传递给链接器的命令行参数，可以通过这个段实现指定运行库等功能。

Windows下的可执行文件、动态链接库等都使用PE文件格式，PE文件格式是COFF文件格式的改进版本，增加了PE文件头、数据目录等一些结构，使得能够满足程序执行时的需求。
