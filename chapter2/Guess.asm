	%include "class.inc"

	db 0xca,0xfe,0xba,0xbe		; magic
	dwbe 0x0000			; minor_version
	dwbe 0x0041			; major_version

	begin_counted_list constant_pool

	constant ObjectClass, CONSTANT_Class
	dwbe ObjectClassName
	constant ObjectClassName, CONSTANT_Utf8
	dutf8 "java/lang/Object"
	constant Object.init, CONSTANT_Methodref
	dwbe ObjectClass
	dwbe initNT
	constant initNT, CONSTANT_NameAndType
	dwbe initName
	dwbe initType
	constant initName, CONSTANT_Utf8
	dutf8 "<init>"
	constant initType, CONSTANT_Utf8
	dutf8 "()V"

	constant thisClass, CONSTANT_Class
	dwbe thisClassName
	constant thisClassName, CONSTANT_Utf8
	dutf8 "Guess"

	constant mainName, CONSTANT_Utf8
	dutf8 "main"
	constant mainType, CONSTANT_Utf8
	dutf8 "([Ljava/lang/String;)V"

	constant RandomClass, CONSTANT_Class
	dwbe RandomClassName
	constant RandomClassName, CONSTANT_Utf8
	dutf8 "java/util/Random"
	constant Random.init, CONSTANT_Methodref
	dwbe RandomClass
	dwbe initNT
	constant Random.nextInt, CONSTANT_Methodref
	dwbe RandomClass
	dwbe nextIntINT
	constant nextIntINT, CONSTANT_NameAndType
	dwbe nextIntName
	dwbe nextIntIType
	constant nextIntName, CONSTANT_Utf8
	dutf8 "nextInt"
	constant nextIntIType, CONSTANT_Utf8
	dutf8 "(I)I"

	constant SystemClass, CONSTANT_Class
	dwbe SystemClassName
	constant SystemClassName, CONSTANT_Utf8
	dutf8 "java/lang/System"
	constant System.in, CONSTANT_Fieldref
	dwbe SystemClass
	dwbe System.inNT
	constant System.inNT, CONSTANT_NameAndType
	dwbe inName
	dwbe inType
	constant inName, CONSTANT_Utf8
	dutf8 "in"
	constant inType, CONSTANT_Utf8
	dutf8 "Ljava/io/InputStream;"
	constant System.out, CONSTANT_Fieldref
	dwbe SystemClass
	dwbe System.outNT
	constant System.outNT, CONSTANT_NameAndType
	dwbe outName
	dwbe outType
	constant outName, CONSTANT_Utf8
	dutf8 "out"
	constant outType, CONSTANT_Utf8
	dutf8 "Ljava/io/PrintStream;"

	constant ScannerClass, CONSTANT_Class
	dwbe ScannerClassName
	constant ScannerClassName, CONSTANT_Utf8
	dutf8 "java/util/Scanner"
	constant Scanner.init, CONSTANT_Methodref
	dwbe ScannerClass
	dwbe initInputStreamNT
	constant initInputStreamNT, CONSTANT_NameAndType
	dwbe initName
	dwbe initInputStreamType
	constant initInputStreamType, CONSTANT_Utf8
	dutf8 "(Ljava/io/InputStream;)V"
	constant Scanner.nextInt, CONSTANT_Methodref
	dwbe ScannerClass
	dwbe nextIntNT
	constant nextIntNT, CONSTANT_NameAndType
	dwbe nextIntName
	dwbe nextIntType
	constant nextIntType, CONSTANT_Utf8
	dutf8 "()I"

	constant PrintStreamClass, CONSTANT_Class
	dwbe PrintStreamClassName
	constant PrintStreamClassName, CONSTANT_Utf8
	dutf8 "java/io/PrintStream"
	constant PrintStream.format, CONSTANT_Methodref
	dwbe PrintStreamClass
	dwbe formatNT
	constant formatNT, CONSTANT_NameAndType
	dwbe formatName
	dwbe formatType
	constant formatName, CONSTANT_Utf8
	dutf8 "format"
	constant formatType, CONSTANT_Utf8
	dutf8 "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;"
	constant PrintStream.println, CONSTANT_Methodref
	dwbe PrintStreamClass
	dwbe printlnNT
	constant printlnNT, CONSTANT_NameAndType
	dwbe printlnName
	dwbe printlnType
	constant printlnName, CONSTANT_Utf8
	dutf8 "println"
	constant printlnType, CONSTANT_Utf8
	dutf8 "(Ljava/lang/String;)V"

	constant IntegerClass, CONSTANT_Class
	dwbe IntegerClassName
	constant IntegerClassName, CONSTANT_Utf8
	dutf8 "java/lang/Integer"
	constant Integer.valueOf, CONSTANT_Methodref
	dwbe IntegerClass
	dwbe valueOfNT
	constant valueOfNT, CONSTANT_NameAndType
	dwbe valueOfName
	dwbe valueOfType
	constant valueOfName, CONSTANT_Utf8
	dutf8 "valueOf"
	constant valueOfType, CONSTANT_Utf8
	dutf8 "(I)Ljava/lang/Integer;"

	constant CodeAttrName, CONSTANT_Utf8
	dutf8 "Code"
	constant StackMapTableAttrName, CONSTANT_Utf8
	dutf8 "StackMapTable"

	constant makeGuessString, CONSTANT_String
	dwbe makeGuessUtf8
	constant makeGuessUtf8, CONSTANT_Utf8
	dutf8 "input an integer between %d and %d: "
	constant tooBigString, CONSTANT_String
	dwbe tooBigUtf8
	constant tooBigUtf8, CONSTANT_Utf8
	dutf8 "the guess is too big."
	constant tooSmallString, CONSTANT_String
	dwbe tooSmallUtf8
	constant tooSmallUtf8, CONSTANT_Utf8
	dutf8 "the guess is too small."
	constant successString, CONSTANT_String
	dwbe successUtf8
	constant successUtf8, CONSTANT_Utf8
	dutf8 `the guess is correct! restarting the game...\n`

	;; range of guess, inclusive
	constant GUESS_MAX, CONSTANT_Integer
	ddbe 100
	constant GUESS_MIN, CONSTANT_Integer
	ddbe 0

	%assign %$i %$i+1
	end_counted_list constant_pool

	dwbe ACC_PUBLIC | ACC_SUPER	; access_flags
	dwbe thisClass			; this_class
	dwbe ObjectClass			; super_class
	dwbe 0x0000			; interfaces_count
	dwbe 0x0000			; fields_count

	begin_counted_list methods
	method ACC_PUBLIC | ACC_STATIC, mainName, mainType
	begin_counted_list attributes
	begin_attribute CodeAttrName
	dwbe 0x0006			; max_stack
	dwbe 0x0003			; max_locals
	begin_sized_section code
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
.restart:					; ->
	aload_1					; -> random
	ldc GUESS_MAX				; -> random,GUESS_MAX
	ldc GUESS_MIN				; -> random,GUESS_MAX,GUESS_MIN
	dup_x2					; -> GUESS_MIN,random,GUESS_MAX,GUESS_MIN
	isub					; -> GUESS_MIN,random,range
	invokevirtual Random.nextInt		; -> GUESS_MIN,intInRange
	iadd					; -> target
	istore_2				; ->
.guess:						; ->
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
	end_sized_section code
	dwbe 0x0000				; exception_table_length
	begin_counted_list attributes
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
	end_attribute
	end_counted_list attributes
	end_attribute
	end_counted_list attributes
	end_counted_list methods

	dwbe 0x0000
