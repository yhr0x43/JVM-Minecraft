%macro dwbe 1
	db (%1)>>8,(%1)&0xff
%endmacro
	
%macro ddbe 1
	db (%1)>>24,((%1)>>16)&0xff,((%1)>>8)&0xff,(%1)&0xff
%endmacro
	
%macro dutf8 1
	dwbe %strlen(%1)	; length
	db %1			; bytes[length]
%endmacro
	
%macro constant 1
	%assign i i+1
	%1 equ i
%endmacro
	
;;; File version stuff
	db 0xca,0xfe,0xba,0xbe 		; magic
	dwbe 0x0000			; minor_version
	dwbe 0x0041			; major_version
	
	dwbe poolcount			; constant_pool_count
	%assign i 0
;;; begin constant_pool[1ch]
	constant Csuper_init
	db 0x0a				; CONSTANT_Methodref
	dwbe Csuper_class		; class_index
	dwbe Cinit_method		; name_and_type_index
	
	constant Csuper_class
	db 0x07				; CONSTANT_Class
	dwbe Csuper_class_name		; name_index

	constant Cinit_method
	db 0x0c				; CONSTANT_NameAndType
	dwbe Cinit_method_name		; name_index
	dwbe Cinit_method_desc		; descriptor_index

	constant Csuper_class_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'java/lang/Object'

	constant Cinit_method_name
	db 0x01				; CONSTANT_Utf8
	dutf8 '<init>'

	constant Cinit_method_desc
	db 0x01				; CONSTANT_Utf8
	dutf8 '()V'

	constant CSystem_out_field
	db 0x09				; CONSTANT_Fieldref
	dwbe CSystem_class		; class_index
	dwbe Cout_field			; name_and_type_index

	constant CSystem_class
	db 0x07				; CONSTANT_Class
	dwbe CSystem_name			; name_index

	constant Cout_field
	db 0x0c				; CONSTANT_NameAndType
	dwbe Cout_name			; name_index
	dwbe Cout_type			; descriptor_index

	constant CSystem_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'java/lang/System'

	constant Cout_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'out'

	constant Cout_type
	db 0x01				; CONSTANT_Utf8
	dutf8 'Ljava/io/PrintStream;'

	constant CString_Hello
	db 0x08				; CONSTANT_String
	dwbe CUtf8_Hello		; string_index

	constant CUtf8_Hello
	db 0x01				; CONSTANT_Utf8
	dutf8 'Hello World!'
	;; fh
	constant Cout_println
	db 0x0a				; CONSTANT_Methodref
	dwbe CPrintStream_class		; class_index
	dwbe 0x0011			; name_and_type_index
	;; 10h
	constant CPrintStream_class
	db 0x07				; CONSTANT_Class
	dwbe CPrintStream_name		; name_index
	;; 11h
	constant Cprintln_method
	db 0x0c				; CONSTANT_NameAndType
	dwbe Cprintln_name		; name_index
	dwbe Cprintln_desc		; descriptor_index
	;; 12h
	constant CPrintStream_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'java/io/PrintStream'
	;; 13h
	constant Cprintln_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'println'
	;; 14h
	constant Cprintln_desc
	db 0x01				; CONSTANT_Utf8
	dutf8 '(Ljava/lang/String;)V'
	;; 15h
	constant Cthis_class
	db 0x07				; CONSTANT_Class
	dwbe Cthis_name			; name_index
	;; 16h
	constant Cthis_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'HelloWorld'
	;; 17h
	constant CCode
	db 0x01				; CONSTANT_Utf8
	dutf8 'Code'
	;; 18h
	constant CLineNumberTable
	db 0x01				; CONSTANT_Utf8
	dutf8 'LineNumberTable'
	;; 19h
	constant Cmain_name
	db 0x01				; CONSTANT_Utf8
	dutf8 'main'
	;; 1ah
	constant Cmain_desc
	db 0x01				; CONSTANT_Utf8
	dutf8 '([Ljava/lang/String;)V'
	;; 1bh
	constant CSourceFile
	db 0x01				; CONSTANT_Utf8
	dutf8 'SourceFile'
	;; 1ch
	constant Cfilename
	db 0x01				; CONSTANT_Utf8
	dutf8 'HelloWorld.java'
	
	poolcount equ i+1
;;; end of constant_pool[1ch]

	dwbe 0x0021			; access_flags: ACC_PUBLIC | ACC_SUPER
	dwbe 0x0015			; this_class: HelloWorld
	dwbe 0x0002			; super_class: java/lang/Object
	dwbe 0x0000			; interfaces_count
	dwbe 0x0000			; fields_count
	
	dwbe 0x0002			; methods_count
;;; begin methods[2h]
	;; 1h
	dwbe 0x0001		; access_flag: ACC_PUBLIC
	dwbe 0x0005		; name_index: <init>
	dwbe 0x0006		; descriptor_index: ()V
	dwbe 0x0001		; attributes_count
;;; begin attributes[1h]
;;; begin Code Attribute
	dwbe 0x0017		; attribute_name_index: Code
	ddbe 0x0000001d		; attribute_length
	dwbe 0x0001		; max_stack
	dwbe 0x0001		; max_locals;
	ddbe 0x00000005		; code_length;
;;; begin code[5h]
	db 0x2a			; aload_0
	db 0xb7, 0x00,0x01	; invokespecial java/lang/Object."<init>":()V
	db 0xb1			; return
;;; end code[5h]
	dwbe 0x0000		; exception_table_length
	dwbe 0x0001		; attributes_count
;;; begin attributes[1h]
;;; begin LineNumberTable Attribute
	dwbe 0x0018		; attribute_name_index: LineNumberTable
	ddbe 0x00000006		; attribute_length
	dwbe 0x0001		; line_number_table_length
;;; begin line_number_table[1h]
	dwbe 0x0000		; start_pc
	dwbe 0x0001		; line_number
;;; end LineNumberTable Attribute
;;; end Code Attribute
;;; end attributes[1h]
	;; 2h
	dwbe 0x0009		; access_flag: ACC_PUBLIC | ACC_STATIC
	dwbe 0x0019		; name_index: main
	dwbe 0x001a		; descriptor_index: ([Ljava/lang/String;)V
	dwbe 0x0001		; attributes_count
;;; begin attributes[1h]
;;; begin Code Attribute
	dwbe 0x0017		; attribute_name_index: Code
	ddbe 0x00000025		; attribute_length
	dwbe 0x0002		; max_stack
	dwbe 0x0001		; max_locals
	ddbe 0x00000009		; code_length
;;; begin code[9h]
	db 0xb2, 0x00,0x07	; getstatic java/lang/System.out:Ljava/io/PrintStream;
	db 0x12, 0x0d		; ldc String "Hello Wolrd!"
	db 0xb6, 0x00,0x0f	; invokevirtual java/io/PrintStream.println:(Ljava/lang/String;)V
	db 0xb1			; return
;;; end code[9h]
	dwbe 0x0000		; exception_table_length
	dwbe 0x0001		; attributes_count
;;; begin attributes[1h]
;;; begin LineNumberTable Attribute
	dwbe 0x0018		; attribute_name_index: LineNumberTable
	ddbe 0x0000000a		; attribute_length
	dwbe 0x0002		; line_number_table_length
;;; begin line_number_table[2h]
	dwbe 0x0000		; start_pc
	dwbe 0x0003		; line_number
	dwbe 0x0008		; start_pc
	dwbe 0x0004		; line_number
;;; end LineNumberTable Attribute	
;;; end attributes[2h]
;;; end Code Attribute
;;; end attributes[1h]
;;; end methods[2h]
	
	dwbe 0x0001		; attributes_count
;;; end attributes[1h]
;;; begin SourceFile Attribute	
	dwbe 0x001b		; attribute_name_index: SourceFile
	ddbe 0x00000002		; attribute_length
	dwbe 0x001c		; sourcefile_index: HelloWorld.java
;;; end SourceFile Attribute	
;;; end attributes[1h]
