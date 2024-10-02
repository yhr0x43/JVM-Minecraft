;;; access flags
%define ACC_PUBLIC		0x0001
%define ACC_PRIVATE		0x0002
%define ACC_PROTECTED		0x0004
%define ACC_STATIC		0x0008
%define ACC_FINAL		0x0010
%define ACC_SYNCHRONIZED	0x0020
%define ACC_SUPER		0x0020
%define ACC_VOLATILE		0x0040
%define ACC_BRIDGE		0x0040
%define ACC_TRANSIENT		0x0080
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
%define OPC_nop				0
%define OPC_aconst_null			1
%define OPC_iconst_m1			2
%define OPC_iconst_0			3
%define OPC_iconst_1			4
%define OPC_iconst_2			5
%define OPC_iconst_3			6
%define OPC_iconst_4			7
%define OPC_iconst_5			8
%define OPC_lconst_0			9
%define OPC_lconst_1			10
%define OPC_fconst_0			11
%define OPC_fconst_1			12
%define OPC_fconst_2			13
%define OPC_dconst_0			14
%define OPC_dconst_1			15
%define OPC_bipush			16
%define OPC_sipush			17
%define OPC_ldc				18
%define OPC_ldc_w			19
%define OPC_ldc2_w			20
%define OPC_iload			21
%define OPC_lload			22
%define OPC_fload			23
%define OPC_dload			24
%define OPC_aload			25
%define OPC_iload_0			26
%define OPC_iload_1			27
%define OPC_iload_2			28
%define OPC_iload_3			29
%define OPC_lload_0			30
%define OPC_lload_1			31
%define OPC_lload_2			32
%define OPC_lload_3			33
%define OPC_fload_0			34
%define OPC_fload_1			35
%define OPC_fload_2			36
%define OPC_fload_3			37
%define OPC_dload_0			38
%define OPC_dload_1			39
%define OPC_dload_2			40
%define OPC_dload_3			41
%define OPC_aload_0			42
%define OPC_aload_1			43
%define OPC_aload_2			44
%define OPC_aload_3			45
%define OPC_iaload			46
%define OPC_laload			47
%define OPC_faload			48
%define OPC_daload			49
%define OPC_aaload			50
%define OPC_baload			51
%define OPC_caload			52
%define OPC_saload			53
%define OPC_istore			54
%define OPC_lstore			55
%define OPC_fstore			56
%define OPC_dstore			57
%define OPC_astore			58
%define OPC_istore_0			59
%define OPC_istore_1			60
%define OPC_istore_2			61
%define OPC_istore_3			62
%define OPC_lstore_0			63
%define OPC_lstore_1			64
%define OPC_lstore_2			65
%define OPC_lstore_3			66
%define OPC_fstore_0			67
%define OPC_fstore_1			68
%define OPC_fstore_2			69
%define OPC_fstore_3			70
%define OPC_dstore_0			71
%define OPC_dstore_1			72
%define OPC_dstore_2			73
%define OPC_dstore_3			74
%define OPC_astore_0			75
%define OPC_astore_1			76
%define OPC_astore_2			77
%define OPC_astore_3			78
%define OPC_iastore			79
%define OPC_lastore			80
%define OPC_fastore			81
%define OPC_dastore			82
%define OPC_aastore			83
%define OPC_bastore			84
%define OPC_castore			85
%define OPC_sastore			86
%define OPC_pop				87
%define OPC_pop2			88
%define OPC_dup				89
%define OPC_dup_x1			90
%define OPC_dup_x2			91
%define OPC_dup2			92
%define OPC_dup2_x1			93
%define OPC_dup2_x2			94
%define OPC_swap			95
%define OPC_iadd			96
%define OPC_ladd			97
%define OPC_fadd			98
%define OPC_dadd			99
%define OPC_isub			100
%define OPC_lsub			101
%define OPC_fsub			102
%define OPC_dsub			103
%define OPC_imul			104
%define OPC_lmul			105
%define OPC_fmul			106
%define OPC_dmul			107
%define OPC_idiv			108
%define OPC_ldiv			109
%define OPC_fdiv			110
%define OPC_ddiv			111
%define OPC_irem			112
%define OPC_lrem			113
%define OPC_frem			114
%define OPC_drem			115
%define OPC_ineg			116
%define OPC_lneg			117
%define OPC_fneg			118
%define OPC_dneg			119
%define OPC_ishl			120
%define OPC_lshl			121
%define OPC_ishr			122
%define OPC_lshr			123
%define OPC_iushr			124
%define OPC_lushr			125
%define OPC_iand			126
%define OPC_land			127
%define OPC_ior				128
%define OPC_lor				129
%define OPC_ixor			130
%define OPC_lxor			131
%define OPC_iinc			132
%define OPC_i2l				133
%define OPC_i2f				134
%define OPC_i2d				135
%define OPC_l2i				136
%define OPC_l2f				137
%define OPC_l2d				138
%define OPC_f2i				139
%define OPC_f2l				140
%define OPC_f2d				141
%define OPC_d2i				142
%define OPC_d2l				143
%define OPC_d2f				144
%define OPC_i2b				145
%define OPC_i2c				146
%define OPC_i2s				147
%define OPC_lcmp			148
%define OPC_fcmpl			149
%define OPC_fcmpg			150
%define OPC_dcmpl			151
%define OPC_dcmpg			152
%define OPC_ifeq			153
%define OPC_ifne			154
%define OPC_iflt			155
%define OPC_ifge			156
%define OPC_ifgt			157
%define OPC_ifle			158
%define OPC_if_icmpeq			159
%define OPC_if_icmpne			160
%define OPC_if_icmplt			161
%define OPC_if_icmpge			162
%define OPC_if_icmpgt			163
%define OPC_if_icmple			164
%define OPC_if_acmpeq			165
%define OPC_if_acmpne			166
%define OPC_goto			167
%define OPC_jsr				168
%define OPC_ret				169
%define OPC_tableswitch			170
%define OPC_lookupswitch		171
%define OPC_ireturn			172
%define OPC_lreturn			173
%define OPC_freturn			174
%define OPC_dreturn			175
%define OPC_areturn			176
%define OPC_return			177
%define OPC_getstatic			178
%define OPC_putstatic			179
%define OPC_getfield			180
%define OPC_putfield			181
%define OPC_invokevirtual		182
%define OPC_invokespecial		183
%define OPC_invokestatic		184
%define OPC_invokeinterface		185
%define OPC_invokedynamic		186
%define OPC_new				187
%define OPC_newarray			188
%define OPC_anewarray			189
%define OPC_arraylength			190
%define OPC_athrow			191
%define OPC_checkcast			192
%define OPC_instanceof			193
%define OPC_monitorenter		194
%define OPC_monitorexit			195
%define OPC_wide			196
%define OPC_multianewarray		197
%define OPC_ifnull			198
%define OPC_ifnonnull			199
%define OPC_goto_w			200
%define OPC_jsr_w			201
%define OPC_MAX				201

;;; instructions
	;; macro for defining simple instructions
%macro inst0 1
	%xdefine %1 db OPC_%*??
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

%macro branch2 1
	%macro %1 1
		db OPC_%??, wbe(%1-$)
	%endmacro
%endmacro
%macro branch4 1
	%macro %1 1
		db OPC_%??, wbe(%1-$)
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
%macro iinc 2
	db OPC_%??, %1, %2
%endmacro
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
	branch2 ifeq
	branch2 ifne
	branch2 iflt
	branch2 ifge
	branch2 ifgt
	branch2 ifle
	branch2 if_icmpeq
	branch2 if_icmpne
	branch2 if_icmplt
	branch2 if_icmpge
	branch2 if_icmpgt
	branch2 if_icmple
	branch2 if_acmpeq
	branch2 if_acmpne
	branch2 goto
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
	branch2 ifnull
	branch2 ifnonnull
	branch4 goto_w
	branch4 jsr_w

;;; verification_type_info
%define ITEM_Top		0x00
%define ITEM_Integer		0x01
%define ITEM_Float		0x02
%define ITEM_Double		0x03
%define ITEM_Long		0x04
%define ITEM_Null		0x05
%define ITEM_UninitializedThis	0x06
%define ITEM_Object		0x07
%define ITEM_Uninitialized	0x08
