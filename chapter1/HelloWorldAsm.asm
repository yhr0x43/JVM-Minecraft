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
	
%macro begin_counted_list 0-1 counted_list
	%push %1
	dwbe %$field_count
	%assign %$i 0
%endmacro

%macro end_counted_list 0-1 counted_list
	%$field_count equ %$i
	%pop %1
%endmacro

%macro begin_sized_section 0-1 sized_section
	%push %1
	ddbe %$end - %$begin	; attribute_length
%$begin:
%endmacro

%macro end_sized_section 0-1 sized_section
%$end:
	%pop %1
%endmacro
	
%macro constant 2
	%assign %$i %$i+1
	%1 equ %$i
	db %2
%endmacro

%macro begin_attribute 1
	%assign %$i %$i+1
	dwbe %1			; attribute_name_index
	begin_sized_section attribute
%endmacro
	
%macro end_attribute 0
	end_sized_section attribute
%endmacro

%macro method 3
	%assign %$i %$i+1
	dwbe %1			; access_flag
	dwbe %2			; name_index
	dwbe %3			; descriptor_index
%endmacro
	
;;; File version stuff
	db 0xca,0xfe,0xba,0xbe 		; magic
	dwbe 0x0000			; minor_version
	dwbe 0x0041			; major_version
	
	begin_counted_list constant_pool
	constant Csuper_class, 0x07		; CONSTANT_Class
	dwbe Csuper_class_name			; name_index

	constant Csuper_class_name, 0x01	; CONSTANT_Utf8
	dutf8 'java/lang/Object'

	constant CSystem_out_field, 0x09	; CONSTANT_Fieldref
	dwbe CSystem_class			; class_index
	dwbe Cout_field				; name_and_type_index

	constant CSystem_class, 0x07		; CONSTANT_Class
	dwbe CSystem_name			; name_index

	constant Cout_field, 0x0c		; CONSTANT_NameAndType
	dwbe Cout_name				; name_index
	dwbe Cout_type				; descriptor_index

	constant CSystem_name, 0x01		; CONSTANT_Utf8
	dutf8 'java/lang/System'

	constant Cout_name, 0x01		; CONSTANT_Utf8
	dutf8 'out'

	constant Cout_type, 0x01		; CONSTANT_Utf8
	dutf8 'Ljava/io/PrintStream;'

	constant CString_Hello, 0x08		; CONSTANT_String
	dwbe CUtf8_Hello			; string_index

	constant CUtf8_Hello, 0x01		; CONSTANT_Utf8
	dutf8 'Hello World!'

	constant Cout_println, 0x0a		; CONSTANT_Methodref
	dwbe CPrintStream_class			; class_index
	dwbe Cprintln_method			; name_and_type_index

	constant CPrintStream_class, 0x07	; CONSTANT_Class
	dwbe CPrintStream_name			; name_index

	constant Cprintln_method, 0x0c		; CONSTANT_NameAndType
	dwbe Cprintln_name			; name_index
	dwbe Cprintln_desc			; descriptor_index

	constant CPrintStream_name, 0x01	; CONSTANT_Utf8
	dutf8 'java/io/PrintStream'

	constant Cprintln_name, 0x01		; CONSTANT_Utf8
	dutf8 'println'

	constant Cprintln_desc, 0x01		; CONSTANT_Utf8
	dutf8 '(Ljava/lang/String;)V'

	constant Cthis_class, 0x07		; CONSTANT_Class
	dwbe Cthis_name				; name_index

	constant Cthis_name, 0x01		; CONSTANT_Utf8
	dutf8 'HelloWorldAsm'

	constant CCode, 0x01			; CONSTANT_Utf8
	dutf8 'Code'
	
	constant Cmain_name, 0x01		; CONSTANT_Utf8
	dutf8 'main'

	constant Cmain_desc, 0x01		; CONSTANT_Utf8
	dutf8 '([Ljava/lang/String;)V'

	%assign %$i %$i+1
	end_counted_list constant_pool

	dwbe 0x0021			; access_flags: ACC_PUBLIC | ACC_SUPER
	dwbe Cthis_class		; this_class: HelloWorld
	dwbe Csuper_class		; super_class: java/lang/Object
	dwbe 0x0000			; interfaces_count
	dwbe 0x0000			; fields_count
	
	begin_counted_list methods
	method 0x0009, Cmain_name, Cmain_desc
	begin_counted_list attributes
	begin_attribute CCode
	dwbe 0x0002		; max_stack
	dwbe 0x0001		; max_locals
	ddbe 0x00000009		; code_length
;;; begin code[9h]
	db 0xb2			; getstatic
	dwbe CSystem_out_field	; java/lang/System.out:Ljava/io/PrintStream;
	
	db 0x12			; ldc
	db CString_Hello	; String "Hello Wolrd!"
	
	db 0xb6			; invokevirtual
	dwbe Cout_println	; java/io/PrintStream.println:(Ljava/lang/String;)V
	db 0xb1			; return
;;; end code[9h]
	dwbe 0x0000		; exception_table_length
	dwbe 0x0000		; attributes_count
	end_attribute
	end_counted_list attributes
	end_counted_list methods
	
	dwbe 0x0000		; attributes_count
