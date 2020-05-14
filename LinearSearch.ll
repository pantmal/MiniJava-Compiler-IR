@.LinearSearch_vtable = global [0 x i8*] [] 
 
@.LS_vtable = global [ 4 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @LS.Start to i8*),
	i8* bitcast (i32 (i8*)* @LS.Print to i8*),
	i8* bitcast (i32 (i8*,i32)* @LS.Search to i8*),
	i8* bitcast (i32 (i8*,i32)* @LS.Init to i8*)
]
 

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32) 
 
@_cint = constant [4 x i8] c"%d\0a\00" 
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00" 
@_cNSZ = constant [15 x i8] c"Negative Size\0a\00" 
 
define void @print_int(i32 %i) { 
	%_str = bitcast [4 x i8]* @_cint to i8* 
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i) 
	ret void 
}
 
define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void 
}
 
define void @throw_nsz() {
	%_str = bitcast [15 x i8]* @_cNSZ to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void 
}
 
define i32 @main() {
	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	%_6 = bitcast i8* %_0 to i8*** 
	%_7 = load i8**, i8*** %_6 
	%_8 = getelementptr i8*, i8** %_7, i32 0 
	%_9 = load i8*, i8** %_8 
	%_10 = bitcast i8* %_9 to i32 (i8* , i32)* 
	%_11 = call i32 %_10( i8* %_0, i32 10) 

	call void (i32) @print_int(i32 %_11)

	ret i32 0
}
 
define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%aux02 = alloca i32
	%_15 = bitcast i8* %this to i8*** 
	%_16 = load i8**, i8*** %_15 
	%_17 = getelementptr i8*, i8** %_16, i32 3 
	%_18 = load i8*, i8** %_17 
	%_19 = bitcast i8* %_18 to i32 (i8* , i32)* 
	%_20 = load i32, i32* %sz
	%_21 = call i32 %_19( i8* %this, i32 %_20) 

	store i32 %_21,i32* %aux01

	%_25 = bitcast i8* %this to i8*** 
	%_26 = load i8**, i8*** %_25 
	%_27 = getelementptr i8*, i8** %_26, i32 1 
	%_28 = load i8*, i8** %_27 
	%_29 = bitcast i8* %_28 to i32 (i8* )* 
	%_30 = call i32 %_29( i8* %this) 

	store i32 %_30,i32* %aux02

	call void (i32) @print_int(i32 9999)

	%_34 = bitcast i8* %this to i8*** 
	%_35 = load i8**, i8*** %_34 
	%_36 = getelementptr i8*, i8** %_35, i32 2 
	%_37 = load i8*, i8** %_36 
	%_38 = bitcast i8* %_37 to i32 (i8* , i32)* 
	%_39 = call i32 %_38( i8* %this, i32 8) 

	call void (i32) @print_int(i32 %_39)

	%_43 = bitcast i8* %this to i8*** 
	%_44 = load i8**, i8*** %_43 
	%_45 = getelementptr i8*, i8** %_44, i32 2 
	%_46 = load i8*, i8** %_45 
	%_47 = bitcast i8* %_46 to i32 (i8* , i32)* 
	%_48 = call i32 %_47( i8* %this, i32 12) 

	call void (i32) @print_int(i32 %_48)

	%_52 = bitcast i8* %this to i8*** 
	%_53 = load i8**, i8*** %_52 
	%_54 = getelementptr i8*, i8** %_53, i32 2 
	%_55 = load i8*, i8** %_54 
	%_56 = bitcast i8* %_55 to i32 (i8* , i32)* 
	%_57 = call i32 %_56( i8* %this, i32 17) 

	call void (i32) @print_int(i32 %_57)

	%_61 = bitcast i8* %this to i8*** 
	%_62 = load i8**, i8*** %_61 
	%_63 = getelementptr i8*, i8** %_62, i32 2 
	%_64 = load i8*, i8** %_63 
	%_65 = bitcast i8* %_64 to i32 (i8* , i32)* 
	%_66 = call i32 %_65( i8* %this, i32 50) 

	call void (i32) @print_int(i32 %_66)

	ret i32 55
}
 
define i32 @LS.Print(i8* %this) {
	%j = alloca i32
	store i32 1,i32* %j

	br label %loop0
	loop0: 
	%_67 = load i32, i32* %j
	%_68 = getelementptr i8, i8* %this, i32 16
	%_69 = bitcast i8* %_68 to i32* 
	%_70 = load i32, i32* %_69
	%_71 = icmp slt i32 %_67, %_70

	br i1 %_71, label %loop1, label %loop2 
	loop1: 
	%_72 = getelementptr i8, i8* %this, i32 8
	%_73 = bitcast i8* %_72 to i32** 
	%_74 = load i32*, i32** %_73
	%_75 = load i32, i32* %j
	%_76 = load i32, i32* %_74
	%_77 = icmp sge i32 %_75, 0
	%_78 = icmp slt i32 %_75, %_76
	%_79 = and i1 %_77, %_78
	br i1 %_79, label %oob_ok_3, label %oob_err_3
 
	oob_err_3: 
	call void @throw_oob()
	br label %oob_ok_3
 
	oob_ok_3: 
	%_80 = add i32 1, %_75
	%_81 = getelementptr i32, i32* %_74, i32 %_80
	%_82 = load i32, i32* %_81

	call void (i32) @print_int(i32 %_82)

	%_83 = load i32, i32* %j
	%_84 = add i32 %_83, 1

	store i32 %_84,i32* %j

	br label %loop0
	loop2: 

	ret i32 0
}
 
define i32 @LS.Search(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%j = alloca i32
	%ls01 = alloca i1
	%ifound = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
	store i32 1,i32* %j

	store i1 0,i1* %ls01

	store i32 0,i32* %ifound

	br label %loop4
	loop4: 
	%_85 = load i32, i32* %j
	%_86 = getelementptr i8, i8* %this, i32 16
	%_87 = bitcast i8* %_86 to i32* 
	%_88 = load i32, i32* %_87
	%_89 = icmp slt i32 %_85, %_88

	br i1 %_89, label %loop5, label %loop6 
	loop5: 
	%_90 = getelementptr i8, i8* %this, i32 8
	%_91 = bitcast i8* %_90 to i32** 
	%_92 = load i32*, i32** %_91
	%_93 = load i32, i32* %j
	%_94 = load i32, i32* %_92
	%_95 = icmp sge i32 %_93, 0
	%_96 = icmp slt i32 %_93, %_94
	%_97 = and i1 %_95, %_96
	br i1 %_97, label %oob_ok_7, label %oob_err_7
 
	oob_err_7: 
	call void @throw_oob()
	br label %oob_ok_7
 
	oob_ok_7: 
	%_98 = add i32 1, %_93
	%_99 = getelementptr i32, i32* %_92, i32 %_98
	%_100 = load i32, i32* %_99

	store i32 %_100,i32* %aux01

	%_101 = load i32, i32* %num
	%_102 = add i32 %_101, 1

	store i32 %_102,i32* %aux02

	%_103 = load i32, i32* %aux01
	%_104 = load i32, i32* %num
	%_105 = icmp slt i32 %_103, %_104

	br i1 %_105, label %if_then_8, label %if_else_8 
	if_else_8: 
	%_106 = load i32, i32* %aux01
	%_107 = load i32, i32* %aux02
	%_108 = icmp slt i32 %_106, %_107

	%_109 = xor i1 1, %_108

	br i1 %_109, label %if_then_9, label %if_else_9 
	if_else_9: 
	store i1 1,i1* %ls01

	store i32 1,i32* %ifound

	%_110 = getelementptr i8, i8* %this, i32 16
	%_111 = bitcast i8* %_110 to i32* 
	%_112 = load i32, i32* %_111
	store i32 %_112,i32* %j

	br label %if_end_9
	if_then_9: 
	store i32 0,i32* %nt

	br label %if_end_9
	if_end_9: 

	br label %if_end_8
	if_then_8: 
	store i32 0,i32* %nt

	br label %if_end_8
	if_end_8: 

	%_113 = load i32, i32* %j
	%_114 = add i32 %_113, 1

	store i32 %_114,i32* %j

	br label %loop4
	loop6: 

	%_115 = load i32, i32* %ifound
	ret i32 %_115
}
 
define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%_116 = getelementptr i8, i8* %this, i32 16
	%_117 = bitcast i8* %_116 to i32* 
	%_118 = load i32, i32* %sz
	store i32 %_118,i32* %_117

	%_119 = getelementptr i8, i8* %this, i32 8
	%_120 = bitcast i8* %_119 to i32** 
	%_121 = load i32, i32* %sz
	%_122 = add i32 1, %_121
	%_123 = icmp sge i32 %_122, 1
	br i1 %_123, label %nsz_ok_10, label %nsz_err_10
 
	nsz_err_10: 
	call void @throw_nsz()
	br label %nsz_ok_10
 
	nsz_ok_10: 
	%_124 = call i8* @calloc(i32 %_122, i32 4) 
	%_125 = bitcast i8* %_124 to i32* 
	store i32 %_121, i32* %_125
 

	store i32* %_125,i32** %_120

	store i32 1,i32* %j

	%_126 = getelementptr i8, i8* %this, i32 16
	%_127 = bitcast i8* %_126 to i32* 
	%_128 = load i32, i32* %_127
	%_129 = add i32 %_128, 1

	store i32 %_129,i32* %k

	br label %loop11
	loop11: 
	%_130 = load i32, i32* %j
	%_131 = getelementptr i8, i8* %this, i32 16
	%_132 = bitcast i8* %_131 to i32* 
	%_133 = load i32, i32* %_132
	%_134 = icmp slt i32 %_130, %_133

	br i1 %_134, label %loop12, label %loop13 
	loop12: 
	%_135 = load i32, i32* %j
	%_136 = mul i32 2, %_135

	store i32 %_136,i32* %aux01

	%_137 = load i32, i32* %k
	%_138 = sub i32 %_137, 3

	store i32 %_138,i32* %aux02

	%_139 = getelementptr i8, i8* %this, i32 8
	%_140 = bitcast i8* %_139 to i32** 
	%_141 = load i32, i32* %j
	%_142 = load i32, i32* %aux01
	%_143 = load i32, i32* %aux02
	%_144 = add i32 %_142, %_143

	%_145 = load i32*, i32** %_140
	%_146 = load i32, i32* %_145
	%_147 = icmp sge i32 %_141, 0
	%_148 = icmp slt i32 %_141, %_146
	%_149 = and i1 %_147, %_148
	br i1 %_149, label %oob_ok_14, label %oob_err_14
 
	oob_err_14: 
	call void @throw_oob()
	br label %oob_ok_14
 
	oob_ok_14: 
	%_150 = add i32 1, %_141
	%_151 = getelementptr i32, i32* %_145, i32 %_150
	store i32 %_144, i32* %_151
 

	%_152 = load i32, i32* %j
	%_153 = add i32 %_152, 1

	store i32 %_153,i32* %j

	%_154 = load i32, i32* %k
	%_155 = sub i32 %_154, 1

	store i32 %_155,i32* %k

	br label %loop11
	loop13: 

	ret i32 0
}
 
