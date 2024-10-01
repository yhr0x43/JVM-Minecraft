;;; Dx macros
%define wbe(x) (x)>>8,(x)&0xff
%macro dwbe 1
	db wbe(%1)
%endmacro

%define dbe(x) (x)>>24,((x)>>16)&0xff,((x)>>8)&0xff,(x)&0xff
%macro ddbe 1
	db dbe(%1)
%endmacro

%macro dutf8 1
	dwbe %strlen(%1)	; length
	db %1			; bytes[length]
%endmacro

;;; counted_list, the list entry must increment %$i to keep track of count
%macro begin_counted_list 0-1 counted_list
	%push %1
	dwbe %$field_count
	%assign %$i 0
%endmacro

%macro end_counted_list 0-1 counted_list
	%$field_count equ %$i
	%pop %1
%endmacro

;;; sized_section, store the size of enclosed section as u4
%macro begin_sized_section 0-1 sized_section
	%push %1
	ddbe %$end - %$begin	; attribute_length
%$begin:
%endmacro

%macro end_sized_section 0-1 sized_section
%$end:
	%pop %1
%endmacro

;;; entry: constant
%macro constant 2
	%assign %$i %$i+1
	%1 equ %$i
	db %2
%endmacro

;;; entry: attribute
%macro begin_attribute 1
	%assign %$i %$i+1
	dwbe %1			; attribute_name_index
	begin_sized_section attribute
%endmacro

%macro end_attribute 0
	end_sized_section attribute
%endmacro

;;; entry: method
%macro method 3
	%assign %$i %$i+1
	dwbe %1			; access_flag
	dwbe %2			; name_index
	dwbe %3			; descriptor_index
%endmacro

;;; access flags
%define ACC_PUBLIC		0x0001
%define ACC_PRIVATE		0x0002
%define ACC_PROTECTED		0x0004
%define ACC_STATIC		0x0008
%define ACC_FINAL		0x0010
%define ACC_SYNCHRONIZED	0x0020
%define ACC_BRIDGE		0x0040
%define ACC_VARARGS		0x0080
%define ACC_NATIVE		0x0100
%define ACC_INTERFACE		0x0200
%define ACC_ABSTRACT		0x0400
%define ACC_STRICT		0x0800
%define ACC_SYNTHETIC		0x1000
%define ACC_ANNOTATION		0x2000
%define ACC_ENUM		0x4000
%define ACC_MODULE		0x8000

;;; constant pool entries
%define CONSTANT_Utf8              	0x01
%define CONSTANT_Unicode           	0x02
%define CONSTANT_Integer           	0x03
%define CONSTANT_Float             	0x04
%define CONSTANT_Long              	0x05
%define CONSTANT_Double            	0x06
%define CONSTANT_Class             	0x07
%define CONSTANT_String            	0x08
%define CONSTANT_Fieldref          	0x09
%define CONSTANT_Methodref         	0x0a
%define CONSTANT_InterfaceMethodref	0x0b
%define CONSTANT_NameAndType       	0x0c
%define CONSTANT_MethodHandle      	0x0f
%define CONSTANT_MethodType        	0x10
%define CONSTANT_Dynamic           	0x11
%define CONSTANT_InvokeDynamic     	0x12
%define CONSTANT_Module            	0x13
%define CONSTANT_Package           	0x14
%define CONSTANT_ExternalMax       	0x14

;;; jvm opcode
%macro forms 3
	%assign %%i 0
	%rep %2+1
	%xdefine %1_%%i %3+%%i
	%assign %%i %%i+1
	%endrep
%endmacro

%define nop		db 0x00
%define aconst_null	db 0x01
%define iconst_m1	db 0x02
	forms iconst, 5, 0x03
	forms lconst, 1, 0x09
	forms fconst, 2, 0x0b
	forms dconst, 2, 0x0e
%macro bipush 1
	db 0x10, %1
%endmacro
%macro sipush 1
	db 0x11, wbe(%1)
%endmacro
%macro ldc 1
	db 0x12, %1
%endmacro
%macro ldc_w 1
	db 0x13, wbe(%1)
%endmacro
%macro ldc2_w 1
	db 0x14, wbe(%1)
%endmacro
%macro iload 1
	db 0x15, %1
%endmacro
