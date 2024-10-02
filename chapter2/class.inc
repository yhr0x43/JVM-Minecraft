	%include "constants.inc"

;;; Dx macros
%define wbe(x) ((x)>>>8)&0xff,(x)&0xff
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
%macro begin_sized_section 0-1 sized_section‚‚
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
	dwbe %1			; access_flags
	dwbe %2			; name_index
	dwbe %3			; descriptor_index
%endmacro

;;; entry: field
%macro field 3
	%assign %$i %$i+1
	dwbe %1			; access_flags
	dwbe %2			; name_index
	dwbe %3			; descriptor_index
%endmacro

;;; entry: stack_map_frame
%macro same_frame 1
	%assign %$i %$i+1
	db (%1)
%endmacro
%macro same_locals_1_stack_item_frame 2
	%assign %$i %$i+1
	db 64 + (%1)
	db (%2)
%endmacro
%macro same_locals_1_stack_item_frame_extended 2
	%assign %$i %$i+1
	db 247
	dwbe (%1)
	db (%2)
%endmacro
%macro chop_frame 2
	%assign %$i %$i+1
	db 251 - %1
	dwbe (%2)
%endmacro
%macro same_frame_extended 1
	%assign %$i %$i+1
	db 251
	dwbe (%1)
%endmacro
%macro append_frame 2
	%assign %$i %$i+1
	db 251 + (%1)
	dwbe (%2)
%endmacro
%macro full_frame 1
	%assign %$i %$i+1
	db 255
	dwbe (%1)
%endmacro

;;; entry: verification_type_info
%macro Top_variable_info 0
	%assign %$i %$i+1
	db ITEM_Top
%endmacro
%macro Integer_variable_info 0
	%assign %$i %$i+1
	db ITEM_Integer
%endmacro
%macro Float_variable_info 0
	%assign %$i %$i+1
	db ITEM_Float
%endmacro
%macro Double_variable_info 0
	%assign %$i %$i+1
	db ITEM_Double
%endmacro
%macro Long_variable_info 0
	%assign %$i %$i+1
	db ITEM_Long
%endmacro
%macro Null_variable_info 0
	%assign %$i %$i+1
	db ITEM_Null
%endmacro
%macro UninitializedThis_variable_info 0
	%assign %$i %$i+1
	db ITEM_UninitializedThis
%endmacro
%macro Object_variable_info 1
	%assign %$i %$i+1
	db ITEM_Object
	dwbe %1			; cpool_index
%endmacro
%macro Uninitialized_variable_info 1
	%assign %$i %$i+1
	db ITEM_Uninitialized
	dwbe %1			; offset
%endmacro
