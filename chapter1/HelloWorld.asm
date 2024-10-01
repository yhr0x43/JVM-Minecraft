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
	
;;; File version stuff
	db 0xca,0xfe,0xba,0xbe 		; magic
	dwbe 0x0000			; minor_version
	dwbe 0x0043			; major_version
	
	dwbe 0x001d			; constant_pool_count
;;; begin constant_pool[1ch]
	;; 1h
	db 0x0a				; CONSTANT_Methodref
	dwbe 0x0002			; class_index
	dwbe 0x0003			; name_and_type_index
	;; 2h
	db 0x07				; CONSTANT_Class
	dwbe 0x0004			; name_index
	;; 3h
	db 0x0c				; CONSTANT_NameAndType
	dwbe 0x0005			; name_index
	dwbe 0x0006			; descriptor_index
	;; 4h
	db 0x01				; CONSTANT_Utf8
	dutf8 'java/lang/Object'
	;; 5h
	db 0x01				; CONSTANT_Utf8
	dutf8 '<init>'
	;; 6h
	db 0x01				; CONSTANT_Utf8
	dutf8 '()V'
	;; 7h
	db 0x09				; CONSTANT_Fieldref
	dwbe 0x0008			; class_index
	dwbe 0x0009			; name_and_type_index
	;; 8h
	db 0x07				; CONSTANT_Class
	dwbe 0x000a			; name_index
	;; 9h
	db 0x0c				; CONSTANT_NameAndType
	dwbe 0x000b			; name_index
	dwbe 0x000c			; descriptor_index
	;; ah
	db 0x01				; CONSTANT_Utf8
	dutf8 'java/lang/System'
	;; bh
	db 0x01				; CONSTANT_Utf8
	dutf8 'out'
	;; ch
	db 0x01				; CONSTANT_Utf8
	dutf8 'Ljava/io/PrintStream;'
	;; dh
	db 0x08				; CONSTANT_String
	dwbe 0x000e			; string_index
	;; eh
	db 0x01				; CONSTANT_Utf8
	dutf8 'Hello World!'
	;; fh
	db 0x0a				; CONSTANT_Methodref
	dwbe 0x0010			; class_index
	dwbe 0x0011			; name_and_type_index
	;; 10h
	db 0x07				; CONSTANT_Class
	dwbe 0x0012			; name_index
	;; 11h
	db 0x0c				; CONSTANT_NameAndType
	dwbe 0x0013			; name_index
	dwbe 0x0014			; descriptor_index
	;; 12h
	db 0x01				; CONSTANT_Utf8
	dutf8 'java/io/PrintStream'
	;; 13h
	db 0x01				; CONSTANT_Utf8
	dutf8 'println'
	;; 14h
	db 0x01				; CONSTANT_Utf8
	dutf8 '(Ljava/lang/String;)V'
	;; 15h
	db 0x07				; CONSTANT_Class
	dwbe 0x0016			; name_index
	;; 16h
	db 0x01				; CONSTANT_Utf8
	dutf8 'HelloWorld'
	;; 17h
	db 0x01				; CONSTANT_Utf8
	dutf8 'Code'
	;; 18h
	db 0x01				; CONSTANT_Utf8
	dutf8 'LineNumberTable'
	;; 19h
	db 0x01				; CONSTANT_Utf8
	dutf8 'main'
	;; 1ah
	db 0x01				; CONSTANT_Utf8
	dutf8 '([Ljava/lang/String;)V'
	;; 1bh
	db 0x01				; CONSTANT_Utf8
	dutf8 'SourceFile'
	;; 1ch
	db 0x01				; CONSTANT_Utf8
	dutf8 'HelloWorld.java'
;;; end of constant_pool[1ch]

	dwbe 0x0021			; access_flags: ACC_PUBLIC | ACC_SUPER
	dwbe 0x0015			; this_class: HelloWorld
	dwbe 0x0002			; super_class: java/lang/Object
	dwbe 0x0000			; interfaces_count
	dwbe 0x0000			; fields_count
	
	dwbe 0x0002			; methods_count
;;; begin methods[2h]
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
;;; end attributes[1h]
;;; end Code Attribute
;;; end attributes[1h]
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
;;; end line_number_table[2h]
;;; end LineNumberTable Attribute	
;;; end attributes[1h]
;;; end Code Attribute
;;; end attributes[1h]
;;; end methods[2h]
	
	dwbe 0x0001		; attributes_count
;;; begin attributes[1h]
;;; begin SourceFile Attribute	
	dwbe 0x001b		; attribute_name_index: SourceFile
	ddbe 0x00000002		; attribute_length
	dwbe 0x001c		; sourcefile_index: HelloWorld.java
;;; end SourceFile Attribute	
;;; end attributes[1h]
