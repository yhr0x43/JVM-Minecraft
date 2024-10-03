# Chapter 2 - Making a Java Program

## Guess.asm

In order to practice using the assembler to make something useful and more complex. I set out to write a little program to try out the "features" of JVM. I ended up writing a guessing game, the program generate a random integer and let the player guess it, as simple as that. The important thing is it demonstrate branching (and looping). You can compile and run the program:
``` cmd
nasm Guess.asm -o Guess.class
java Guess
```
Then it outputs something like this:
```
input an integer between 0 and 100: 50
the guess is too big.
...
```
I'll skip the introduction of the constant pool. All entries inside that pool is added as I see necessary while writing the program. Instead of spending time on this inter-referenced network of entries, your probably should just look at the code.

A tip on developing the program: use `javap` and `java` often to check the produced class file! I am pleasantly surprised that `java` provide some quite helpful information on what's wrong with the class file. These errors is very helpful in figuring out what to do to fix it.

Now, I will explain the code and therefore some basic concept of how these JVM instructions work. First, remember the structure of class file, we are mostly concerned with the `methods` field, specifically in the `Code` attribute of `main([Ljava/lang/String;)V`. So we'll take a look at that attribute first. The actual code begins at the [main](Guess.asm#L182) label of the program.

``` nasm
main:
	new ScannerClass	 		; -> _scanner
	dup					; -> _scanner,_scanner
	getstatic System.in	 		; -> _scanner,_scanner,in
	invokespecial Scanner.init		; -> scanner
	astore_0				; ->
	new RandomClass				; -> _random
	dup					; -> _random,_random
	invokespecial Random.init		; -> random
	astore_1				; ->
```

This first part creates a new `java/util/Scanner` object using `java/lang/System.in` as its parameter. The first thing to explain is what do those comments mean. They are actually for me to keep track of the content of "operand stack" (sometimes simply known as "the stack"). JVM's instruction is stack based, which means most instructions use the stack as the means to pass parameters, save return values, and perform type-checking. The last point will become important later.

Then, what this code does becomes mostly self-explained when you take a look at the mnemonic of the instruction and what they do to the stack. Only some details need explaining:
 - `new` instruction creates an uninitialized reference to the specified class, then I must call `java/util/Scanner.<init>(L/java/io/InputStream;)V` on this reference.
 - normally, to call a member method of an object you would use `invokevirtual`, but to call the `<init>` you'll have to use `invokespecial`. I'm sure there is a reasoning hiding in how they search for the actual implementation, but I figure this out just by having `java` run this program and yell at me.
 - `astore_0` stores the top value on stack into local variable 0. In this method local variable 0 was holding the program arguments, but I don't need that so I just overwrite it.

 ``` nasm
 .restart:					; ->
	aload_1					; -> random
	ldc GUESS_MAX				; -> random,GUESS_MAX
	ldc GUESS_MIN				; -> random,GUESS_MAX,GUESS_MIN
	dup_x2					; -> GUESS_MIN,random,GUESS_MAX,GUESS_MIN
	isub					; -> GUESS_MIN,random,range
	invokevirtual Random.nextInt		; -> GUESS_MIN,intInRange
	iadd					; -> target
	istore_2				; ->
 ```

 This part generates the random integer for this round, it computes `GUESS_MIN + Random.nextInt(GUESS_MAX-GUESS_MIN)` and stores it in local 2.

 ``` nasm
 .guess:					; ->
	getstatic System.out			; -> out
	ldc makeGuessString			; -> out,makeGuess
	iconst_2				; -> out,makeGuess,2
	anewarray ObjectClass			; -> out,makeGuess,array
	dup					; -> out,makeGuess,array,array
	iconst_0				; -> out,makeGuess,array,array,0
	ldc GUESS_MIN				; -> out,makeGuess,array,array,0,GUESS_MIN
	invokestatic Integer.valueOf		; -> out,makeGuess,array,array,0,Int(GUESS_MIN)
	aastore					; -> out,makeGuess,array
	dup					; -> out,makeGuess,array,array
	iconst_1				; -> out,makeGuess,array,array,0
	ldc GUESS_MAX				; -> out,makeGuess,array,array,0,GUESS_MAX
	invokestatic Integer.valueOf		; -> out,makeGuess,array,array,0,Int(GUESS_MAX)
	aastore					; -> out,makeGuess,array
	invokevirtual PrintStream.format	; -> out
	pop					; ->
 ```

 This part looks intimidating until you realize it just runs `System.out.format("...", GUESS_MIN, GUESS_MAX)`.
 The complication comes from how Java handles variable arguments, they are passed as an array of objects as the last parameter to the function. Nevertheless, this part gives me a chance to play with arrays. The only thing that throw me off here is the wrapping of integers. I unfortunately don't have Java's auto wrapping available here.

 ``` nasm
 	iload_2					; -> target
	aload_0					; -> target,scanner
	invokevirtual Scanner.nextInt		; -> target,input
	isub					; -> diff
	dup					; -> diff,diff
	ifeq .success				; -> diff
	ifgt .too_small				; ->
.too_big:					; ->
	getstatic System.out			; -> out
	ldc tooBigString			; -> out,tooBig
	invokevirtual PrintStream.println       ; ->
	goto .guess				; ->
.too_small:					; ->
	getstatic System.out			; -> out
	ldc tooSmallString			; -> out,tooSmall
	invokevirtual PrintStream.println       ; ->
	goto .guess				; ->
.success:					; -> diff
	pop					; ->
	getstatic System.out			; -> out
	ldc successString			; -> out,success
	invokevirtual PrintStream.println       ; ->
	goto .restart				; ->
```

So, the rest of the code is just getting a user input, compare it to the secret and branch based on the result of that. The code itself is very straightforward and it is now complete! Let's test run this.
``` cmd
java Guess
```
it then outputs this:
```
Error: Unable to initialize main class Guess
Caused by: java.lang.VerifyError: Expecting a stackmap frame at branch target 95
Exception Details:
  Location:
    Guess.main([Ljava/lang/String;)V @67: ifeq
  Reason:
    Expected stackmap frame at this location.
  Bytecode:
    0000000: bb00 1c59 b200 14b7 001e 4bbb 000b 59b7
    0000010: 000d 4c2b 123e 123f 5b64 b600 0e60 3db2
    0000020: 0018 1236 05bd 0001 5903 123f b800 3053
    0000030: 5904 123e b800 3053 b600 2657 1c2a b600
    0000040: 2164 5999 001c 9d00 0eb2 0018 1238 b600
    0000050: 2aa7 ffce b200 1812 3ab6 002a a7ff c357
    0000060: b200 1812 3cb6 002a a7ff ab
  Stackmap Table:

```
Well, that's not good, but what even is a stackmap anyways?
To get an answer to that question, we can take a look at Oracle's JDK documentation: [4.7.4. The StackMapTable Attribute](https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.7.4), but here is my summary:
The `StackMapTable` described what should be on the stack and in the locals. Specifically, they describe the type of what should be on there. Normally JVM can infer this information by knowing what each instruction should do to the stack and locals. But apparently it needs some hint whenever a branch happens. That's not a big problem for me especially I have all the states of the stack in the comment!

`StackMapTable` needs to be an attribute of the `Code` attribute, like [here](Guess.asm#246):
``` nasm
	begin_attribute StackMapTableAttrName
	begin_counted_list stack_map_frame
	;; stack_map @ .restart
	full_frame main.restart - main
	begin_counted_list locals
	Object_variable_info ScannerClass
	Object_variable_info RandomClass
	end_counted_list locals
	begin_counted_list stack_items
	end_counted_list stack_items
	;; stack_map @ .guess
	full_frame main.guess - main.restart - 1
	begin_counted_list locals
	Object_variable_info ScannerClass
	Object_variable_info RandomClass
	Integer_variable_info
	end_counted_list locals
	begin_counted_list stack_items
	end_counted_list stack_items
	;; stack_map @ .too_small
	same_frame_extended main.too_small - main.guess - 1
	;; stack_map @ .success
	same_locals_1_stack_item_frame_extended main.success - main.too_small - 1, ITEM_Integer
	end_counted_list stack_map_frame
```
One complication is that each individual stack_map_frame is located using a `offset_delta`, means it actually records the number of bytes offset from the previous frame instead of some absolute address.