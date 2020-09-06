### 开始配置
#### i386 架构问题
1、将 `objc` 和 `objc-trampolines` 中的 `Build Settings` 选项 `Architectures` 中的值切换为 `Standard Architectures(64-bit Intel)`
2、`Base SDK` 选 `macOS`
#### file not found
1、`sys/reason.h` file not found
> a、在 [Apple source：](https://opensource.apple.com/tarballs) https://opensource.apple.com/tarballs/xnu/下载 
> 路径：`xnu/bsd/sys/reason.h` 路径下载
> b、通过谷歌输入 `reason.h site:opensource.apple.com` 定向检索

把找到的文件加入到工程：
* 在根目录创建一个 `common` 文件夹
* 创建 `sys` 文件夹
* 把 `reason.h` 文件加入`sys`文件夹
* 选择 `target -> objc -> Build Settings`
* 在工程的 `Header Serach Paths` 中添加搜索路径 `$(SRCROOT)/common`

2、`mach-o/dyld_priv.h` file not found
   
   * 下载地址：`https://opensource.apple.com/tarballs/dyld/` 
   * 路径：`include/mach-o/dyld_priv.h`
   

3、`'os/lock_private.h' file not found`、`'os/base_private.h' file not found`

* 下载地址：`https://opensource.apple.com/tarballs/libplatform/`
* 路径：`private/os/lock_private.h & base_private.h`
* 路径：`private/_simple.h` 
* 把找到的文件加入工程：
 * 创建 `os` 文件夹
 * 把 `lock_private.h & base_private.h` 放入 `os` 文件夹
 * 把 `_simple.h` 直接放入 `common` 文件夹
 
 
4、`'pthread/tsd_private.h' file not found` & '_simple.h' file not found
 
 * 下载地址：`https://opensource.apple.com/tarballs/libpthread/`
 * 路径：`private/tsd_private.h`
 * 把找到的文件加入工程：
 * 创建 `pthread` 文件夹
 * 把 `tsd_private.h` 放入
 * 把 `_simple.h` 直接放入 `common` 文件夹

5、`'System/machine/cpu_capabilities.h' file not found`
   
 * 下载地址：https://opensource.apple.com/tarballs/xnu/
 * 路径：`osfmk/i386/cpu_capabilities.h`
 * 创建 `System/machine` 文件夹
 * 把 `cpu_capabilities.h` 放入
   
6、`'os/tsd.h' file not found`   
 
 * 下载地址：https://opensource.apple.com/tarballs/xnu/
 * 路径：`libsyscall/os/tsd.h`
 * 把 `tsd.h` 加入 `os` 文件夹

7、`'System/pthread_machdep.h' file not found`

 * 下载地址：https://opensource.apple.com/tarballs/Libc/
 * 路径：`Libc/Libc-825.24/pthreads/pthread_machdep.h`
 * 把 `pthread_machdep.h` 加入 `System` 文件夹

8、'CrashReporterClient.h' file not found

 * 下载地址：https://opensource.apple.com/tarballs/Libc/
 * 路径：`Libc/Libc-825.24/include/CrashReporterClient.h`
 * 把 `CrashReporterClient.h` 加入 `common` 文件夹
 * 需要在 `Build Settings` -> `Preprocessor Macros` 中加入：`LIBC_NO_LIBCRASHREPORTERCLIENT`

9、'objc-shared-cache.h' file not found

  * 路径：`dyld-733.6/include/objc-shared-cache.h`
  * 加入 `common` 文件夹
  
10、'Block_private.h' file not found

  * 路径：`xnu-6153.141.1/libkern/libkern`
  * 加入 `common` 文件夹
  
11、'kern/restartable.h' file not found
  
  * 路径：xnu-6153.141.1/osfmk/kern  
  
#### libobjc.order 路径问题

```
Can't open order file: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/AppleInternal/OrderFiles/libobjc.order
```

* 选择 target -> objc -> Build Settings
* 在工程的 Order File 中添加搜索路径 `$(SRCROOT)/libobjc.order` 

#### lCrashReporterClient 编译不到
```
Library not found for -lCrashReporterClient
```
* 选择 target -> objc -> Build Settings
* 在 Other Linker Flags 中删除 -lCrashReporterClient ( Debug 和 Release 都删了)

#### 脚本编译问题
* 选择 `target -> objc -> Build Phases -> Run Script(markgc)`
* 把脚本文本 `macosx.internal` 改成 `macosx`

#### ObjectiveC.apinotes 异常

```
no such public header file: '/tmp/objc.dst/usr/include/objc/ObjectiveC.apinotes'
```

* 选择 target -> objc -> Build Settings
* `Text-Based InstallAPI Verification Model` 中添加搜索路径 `Errors Only`
* `Other Text-Based InstallAPI Flags` 清空所有内容

#### Use of undeclared identifier

* Use of undeclared identifier 'DYLD_MACOSX_VERSION_10_11'

`dyld_private.h` 添加如下代码：
```
#define DYLD_MACOSX_VERSION_10_11 0x000A0B00
#define DYLD_MACOSX_VERSION_10_12 0x000A0C00
#define DYLD_MACOSX_VERSION_10_13 0x000A0D00
#define DYLD_MACOSX_VERSION_10_14 0x000A0E00
```

* Use of undeclared identifier 'OS_UNFAIR_LOCK_ADAPTIVE_SPIN'

`` 修改如下：
将如下代码：
```
OS_ENUM(os_unfair_lock_options, uint32_t,
	OS_UNFAIR_LOCK_NONE
		OS_UNFAIR_LOCK_AVAILABILITY = 0x00000000,
	OS_UNFAIR_LOCK_DATA_SYNCHRONIZATION
		OS_UNFAIR_LOCK_AVAILABILITY = 0x00010000,
);
```
替换成如下代码：
```
OS_OPTIONS(os_unfair_lock_options, uint32_t,
     OS_UNFAIR_LOCK_NONE OS_SWIFT_NAME(None)
         OS_UNFAIR_LOCK_AVAILABILITY = 0x00000000,
     OS_UNFAIR_LOCK_DATA_SYNCHRONIZATION OS_SWIFT_NAME(DataSynchronization)
         OS_UNFAIR_LOCK_AVAILABILITY = 0x00010000,
     OS_UNFAIR_LOCK_ADAPTIVE_SPIN OS_SWIFT_NAME(AdaptiveSpin)
         __API_AVAILABLE(macos(10.15), ios(13.0),
         tvos(13.0), watchos(6.0)) = 0x00040000
 );

 #if __swift__
 #define OS_UNFAIR_LOCK_OPTIONS_COMPAT_FOR_SWIFT(name) \
         static const os_unfair_lock_options_t \
         name##_FOR_SWIFT OS_SWIFT_NAME(name) = name
 OS_UNFAIR_LOCK_OPTIONS_COMPAT_FOR_SWIFT(OS_UNFAIR_LOCK_NONE);
 OS_UNFAIR_LOCK_OPTIONS_COMPAT_FOR_SWIFT(OS_UNFAIR_LOCK_DATA_SYNCHRONIZATION);
 OS_UNFAIR_LOCK_OPTIONS_COMPAT_FOR_SWIFT(OS_UNFAIR_LOCK_ADAPTIVE_SPIN);
 #undef OS_UNFAIR_LOCK_OPTIONS_COMPAT_FOR_SWIFT
 #endif
```

#### 参考：
* https://juejin.im/post/6844903959161733133
* https://juejin.im/post/6844904082226806792
* https://github.com/LGCooci/objc4_debug
