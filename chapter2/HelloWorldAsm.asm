	%include "class.inc"

;;; File version stuff
	db 0xca,0xfe,0xba,0xbe 		; magic
	dwbe 0x0000			; minor_version
	dwbe 0x0041			; major_version
	
	begin_counted_list constant_pool
	constant Csuper_class, CONSTANT_Class
	dwbe Csuper_class_name			; name_index

	constant Csuper_class_name, CONSTANT_Utf8
	dutf8 'java/lang/Object'

	constant CSystem_out_field, CONSTANT_Fieldref
	dwbe CSystem_class			; class_index
	dwbe Cout_field				; name_and_type_index

	constant CSystem_class, CONSTANT_Class
	dwbe CSystem_name			; name_index

	constant Cout_field, CONSTANT_NameAndType
	dwbe Cout_name				; name_index
	dwbe Cout_type				; descriptor_index

	constant CSystem_name, CONSTANT_Utf8
	dutf8 'java/lang/System'

	constant Cout_name, CONSTANT_Utf8
	dutf8 'out'

	constant Cout_type, CONSTANT_Utf8
	dutf8 'Ljava/io/PrintStream;'

	constant CString_Hello, CONSTANT_String
	dwbe CUtf8_Hello			; string_index

	constant CUtf8_Hello, CONSTANT_Utf8
	dutf8 'Hello World!'

	constant Cout_println, CONSTANT_Methodref
	dwbe CPrintStream_class			; class_index
	dwbe Cprintln_method			; name_and_type_index

	constant CPrintStream_class, CONSTANT_Class
	dwbe CPrintStream_name			; name_index

	constant Cprintln_method, CONSTANT_NameAndType
	dwbe Cprintln_name			; name_index
	dwbe Cprintln_desc			; descriptor_index

	constant CPrintStream_name, CONSTANT_Utf8
	dutf8 'java/io/PrintStream'

	constant Cprintln_name, CONSTANT_Utf8
	dutf8 'println'

	constant Cprintln_desc, CONSTANT_Utf8
	dutf8 '(Ljava/lang/String;)V'

	constant Cthis_class, CONSTANT_Class
	dwbe Cthis_name				; name_index

	constant Cthis_name, CONSTANT_Utf8
	dutf8 'HelloWorldAsm'

	constant CCode, CONSTANT_Utf8
	dutf8 'Code'
	
	constant Cmain_name, CONSTANT_Utf8
	dutf8 'main'

	constant Cmain_desc, CONSTANT_Utf8
	dutf8 '([Ljava/lang/String;)V'

	%assign %$i %$i+1
	end_counted_list constant_pool

	dwbe ACC_PUBLIC | ACC_SUPER	; access_flags
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
	begin_sized_section code
	
	getstatic CSystem_out_field
	ldc CString_Hello
	invokevirtual Cout_println
	return
	
	end_sized_section code
	dwbe 0x0000		; exception_table_length
	dwbe 0x0000		; attributes_count
	end_attribute
	end_counted_list attributes
	end_counted_list methods
	
	dwbe 0x0000		; attributes_count
