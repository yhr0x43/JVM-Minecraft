# Chapter 1

## Hello World in Java

We first begin by compiling and run a classic Java hello world program:
Write the following in `HelloWorld.java` (the class name must be the same as filename by java requirement)

``` java
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
}
```

Compile and Run:

``` cmd
javac HelloWolrld.java
java HelloWorld
Hello World!
```

Interestingly, if you pay attention, `java` actually takes the class name instead of the filename.
It just assumes the `HelloWorld` class must exists in `HelloWorld.class` file, but what does it mean "to exist" in there?
The file isn't that big, only 426 bytes in my case:

``` cmd
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        2024/09/29     12:38            426 HelloWorld.class
...
```

So how about just take a look inside with a hex editor?

``` hexl
00000000: cafe babe 0000 0043 001d 0a00 0200 0307  .......C........
00000010: 0004 0c00 0500 0601 0010 6a61 7661 2f6c  ..........java/l
00000020: 616e 672f 4f62 6a65 6374 0100 063c 696e  ang/Object...<in
00000030: 6974 3e01 0003 2829 5609 0008 0009 0700  it>...()V.......
00000040: 0a0c 000b 000c 0100 106a 6176 612f 6c61  .........java/la
00000050: 6e67 2f53 7973 7465 6d01 0003 6f75 7401  ng/System...out.
00000060: 0015 4c6a 6176 612f 696f 2f50 7269 6e74  ..Ljava/io/Print
00000070: 5374 7265 616d 3b08 000e 0100 0c42 7965  Stream;......Bye
00000080: 2020 2057 6f72 6c64 210a 0010 0011 0700     World!.......
00000090: 120c 0013 0014 0100 136a 6176 612f 696f  .........java/io
000000a0: 2f50 7269 6e74 5374 7265 616d 0100 0770  /PrintStream...p
000000b0: 7269 6e74 6c6e 0100 1528 4c6a 6176 612f  rintln...(Ljava/
000000c0: 6c61 6e67 2f53 7472 696e 673b 2956 0700  lang/String;)V..
000000d0: 1601 000a 4865 6c6c 6f57 6f72 6c64 0100  ....HelloWorld..
000000e0: 0443 6f64 6501 000f 4c69 6e65 4e75 6d62  .Code...LineNumb
000000f0: 6572 5461 626c 6501 0004 6d61 696e 0100  erTable...main..
00000100: 1628 5b4c 6a61 7661 2f6c 616e 672f 5374  .([Ljava/lang/St
00000110: 7269 6e67 3b29 5601 000a 536f 7572 6365  ring;)V...Source
00000120: 4669 6c65 0100 0f48 656c 6c6f 576f 726c  File...HelloWorl
00000130: 642e 6a61 7661 0021 0015 0002 0000 0000  d.java.!........
00000140: 0002 0001 0005 0006 0001 0017 0000 001d  ................
00000150: 0001 0001 0000 0005 2ab7 0001 b100 0000  ........*.......
00000160: 0100 1800 0000 0600 0100 0000 0100 0900  ................
00000170: 1900 1a00 0100 1700 0000 2500 0200 0100  ..........%.....
00000180: 0000 09b2 0007 120d b600 0fb1 0000 0001  ................
00000190: 0018 0000 000a 0002 0000 0003 0008 0004  ................
000001a0: 0001 001b 0000 0002 001c                 ..........
```

Interesting, looks like a lot of strings here. Maybe there is something I can mess with? I see the string "Hello World!" here, let me hex edit it to something else:

``` hexl
...
00000060: 0015 4c6a 6176 612f 696f 2f50 7269 6e74  ..Ljava/io/Print
00000070: 5374 7265 616d 3b08 000e 0100 0c42 7965  Stream;......Bye
00000080: 2020 2057 6f72 6c64 210a 0010 0011 0700     World!.......
00000090: 120c 0013 0014 0100 136a 6176 612f 696f  .........java/io
...
```

And... it works!

``` cmd
java HelloWorld
Bye   World!
```

OK, that is enough exciting messing around, let's try to understand what we are looking at by reading some specs, here I find the oracle documentaion very helpful: [Chapter 4. The class File Format](https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html)

Walking through all of the fields is suprisingly tedious, so I'm not going to 😜. The difficulty comes from the variable length field, different types can actually be different length. But please still try reading the file if you want to. Try to understand the syntax and change something to see what will happen!

## Hello World hand made

Now armed with our new understanding of the class file. Can we make our own class file by just deposit bytes into a file? The class file structure seems simple enough for me to just do so.

I am going to use [NASM](https://nasm.us/) for this purpose, honestly, any assembler probably works for this purpose since we are not *actually* doing assembler, only using the `db` directory to deposit bytes directly into the file.

Speaking of `db`, you should investigate it a bit more and NASM has a great documentation on this: [3.2.1 Dx: Declaring Initialized Data](https://www.nasm.us/doc/nasmdoc3.html#section-3.2.1). But the simple explaination is that `db` just put a byte into the file, and we want to put the number in byte-by-byte because Java is big-endian and Intel platform (which NASM targets) is little-endian. So just put in bytes makes a lot more sense for our use case.

Now, let's finally start writing our class in assembly!

I used a NASM macro to cleanup the code. But if your assembler don't understand that,
use something like `db 0x00,0x43` achives the same effect of `dwbe 0x0043`.
``` nasm
%macro dwbe 1
	db ((%1)>>8),((%1)&0xff)
%endmacro
```

Now, if you want to, take a look at [HelloWorld.asm](HelloWorld.asm) which is a translation of the class file I have shown erlier.
The result is quite messy, so I'll only explain some big picture things.

 - The first 8 bytes is just some stuff to let JVM know this is a valid class file and it can run the file.
 - Next is the "constant section", which makes up the majority part of the file. The type of entires is identified by the first byte of each entry. But most specification is quite simple, you can probably guess what each entry does by looking at the assembly file.
 - Then some other information about the class: the access flags (public/private/interface), name of the class, name of the super class.
 - We don't implement interfaces and there is no fields in the class, so those can be skipped.
 - Methods! This is the most interesting part, but that also makes it the most complicated part. I'll save the exploration of this part for later and you can refer to [Section 6](https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.6) of *The class File Format* for more info.
 - At the end here is attributes for the entire class file. In our case it just stores `SourceFile=HelloWorld.java`.

To assemble the program and test it:
``` cmd
nasm -f bin -o HelloWorld.class HelloWorld.asm
java HelloWolrd
```
`-f bin` specify the output format, here we request NASM just output whatever it generates and do not try to package them into some linkable or executable format.
`-o HelloWorld.class` specify the name of output file, this is important because Java looks for class by filename.
When compiled correctly, the new `HelloWorld.class` should be **identical** to the file compiled with `javac` earlier, and execute it with `java` of course still works.

## References

- The Java® Virtual Machine Specification Java SE 8 Edition Chapter 4. The class File Format https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html
- The Netwide Assembler (NASM) https://nasm.us/
- flat assembler https://flatassembler.net/docs.php