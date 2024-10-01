	%include "constants.inc"
	
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

;;; instructions
	;; macro for defining simple instructions
%macro inst0 1
	%xdefine %1 db OPC_%1
%endmacro
%macro inst1 1
	%macro %1 1
		db OPC_%??, %1
	%endmacro
%endmacro
%macro inst2 1
	%macro %1 1
		db OPC_%??, wbe(%1)
	%endmacro
%endmacro
%macro inst4 1
	%macro %1 1
		db OPC_%??, dbe(%1)
	%endmacro
%endmacro
	
%macro inst_forms 2
	%assign %%i 0
	%rep %2+1
	;; all these short-hand instructions has no explicit operand
	inst0 %1_%eval(%%i)
	%assign %%i %%i+1
	%endrep
%endmacro

	inst0 nop
	inst0 aconst_null
	inst0 iconst_m1
	inst_forms iconst, 5
	inst_forms lconst, 1
	inst_forms fconst, 2
	inst_forms dconst, 2
	inst1 bipush
	inst2 sipush
	inst1 ldc
	inst2 ldc_w
	inst2 ldc2_w
	inst1 iload
	inst1 lload
	inst1 fload
	inst1 dload
	inst1 aload
	inst_forms iload, 3
	inst_forms lload, 3
	inst_forms fload, 3
	inst_forms dload, 3
	inst_forms aload, 3
	inst0 iaload
	inst0 laload
	inst0 faload
	inst0 daload
	inst0 aaload
	inst0 baload
	inst0 caload
	inst0 saload
	inst1 istore
	inst1 lstore
	inst1 fstore
	inst1 dstore
	inst1 astore
	inst_forms istore, 3
	inst_forms lstore, 3
	inst_forms fstore, 3
	inst_forms dstore, 3
	inst_forms astore, 3
	inst0 iastore
	inst0 lastore
	inst0 fastore
	inst0 dastore
	inst0 aastore
	inst0 bastore
	inst0 castore
	inst0 sastore
	inst0 pop
	inst0 pop2
	inst0 dup
	inst0 dup_x1
	inst0 dup_x2
	inst0 dup2
	inst0 dup2_x1
	inst0 swap
	inst0 iadd
	inst0 ladd
	inst0 fadd
	inst0 dadd
	inst0 isub
	inst0 lsub
	inst0 fsub
	inst0 dsub
	inst0 imul
	inst0 lmul
	inst0 fmul
	inst0 dmul
	inst0 idiv
	inst0 ldiv
	inst0 fdiv
	inst0 ddiv
	inst0 irem
	inst0 lrem
	inst0 frem
	inst0 drem
	inst0 ineg
	inst0 lneg
	inst0 fneg
	inst0 dneg
	inst0 ishl
	inst0 lshl
	inst0 ishr
	inst0 lshr
	inst0 iushr
	inst0 lushr
	inst0 iand
	inst0 land
	inst0 ior
	inst0 lor
	inst0 ixor
	inst0 lxor
	inst2 iinc
	inst0 i2l
	inst0 i2f
	inst0 i2d
	inst0 l2i
	inst0 l2f
	inst0 l2d
	inst0 f2i
	inst0 f2l
	inst0 f2d
	inst0 d2i
	inst0 d2l
	inst0 d2f
	inst0 i2b
	inst0 i2c
	inst0 i2s
	inst0 lcmp
	inst0 fcmpl
	inst0 fcmpg
	inst0 dcmpl
	inst0 dcmpg
	inst2 ifeq
	inst2 ifne
	inst2 iflt
	inst2 ifge
	inst2 ifgt
	inst2 ifle
	inst2 if_icmpeq
	inst2 if_icmpne
	inst2 if_icmplt
	inst2 if_icmpge
	inst2 if_icmpgt
	inst2 if_icmple
	inst2 if_acmpeq
	inst2 if_acmpne
	inst2 goto
	inst2 jsr
	inst1 ret
%macro tableswitch 3
	db OPC_%??
	TIMES ((4 - ($ - %$begin) % 4) % 4) db 0
	ddbe %1
	ddbe %2
	ddbe %3
%endmacro
%macro tableswitch 2
	db OPC_%??
	TIMES ((4 - ($ - %$begin) % 4) % 4) db 0
	ddbe %1
	ddbe %2
%endmacro
	inst0 ireturn
	inst0 lreturn
	inst0 freturn
	inst0 dreturn
	inst0 areturn
	inst0 return
	inst2 getstatic
	inst2 putstatic
	inst2 getfield
	inst2 putfield
	inst2 invokevirtual
	inst2 invokespecial
	inst2 invokestatic
%macro invokeinterface 2
	db OPC_%??
	dwbe %1
	db %2, 0x00
%endmacro
%macro invokedynamic 1
	db OPC_%??
	dwbe %1
	db 0x00, 0x00
%endmacro
	inst2 new
	inst1 newarray
	inst2 anewarray
	inst0 arraylength
	inst0 athrow
	inst2 checkcast
	inst2 instanceof
	inst0 monitorenter
	inst0 monitorexit
%macro wide 2-3
	db OPC_%??, OPC_%1
	dwbe %2
	%if 3 == %0
	dwbe %3
	%endif
%endmacro
%macro multianewarray 2
	db OPC_%??
	dwbe %1
	db %2
%endmacro
	inst2 ifnull
	inst2 ifnonnull
	inst4 goto_w
	inst4 jsr_w
