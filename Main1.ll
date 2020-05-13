@.Main_vtable = global [0 x i8*] [] 
 
@.ArrayTest_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @ArrayTest.test to i8*)
]
 
@.B_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @B.test to i8*)
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
	%ab = alloca i8*

	%_5 = call i8* @calloc(i32 1, i32 20)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [1 x i8*], [1 x i8*]* @.ArrayTest_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	store i8* %_5,i8** %ab

	%_8 = load i8*, i8** %ab
	%_12 = bitcast i8* %_8 to i8*** 
	%_13 = load i8**, i8*** %_12 
	%_14 = getelementptr i8*, i8** %_13, i32 0 
	%_15 = load i8*, i8** %_14 
	%_16 = bitcast i8* %_15 to i32 (i8* , i32)* 
	%_17 = call i32 %_16( i8* %_8, i32 3) 

	call void (i32) @print_int(i32 %_17)

	ret i32 0
}
 
define i32 @ArrayTest.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32

	%intArray = alloca i32*

	%_23 = load i32, i32* %num
	%_24 = add i32 1, %_23
	%_25 = icmp sge i32 %_24, 1
	br i1 %_25, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_26 = call i8* @calloc(i32 %_24, i32 4) 
	%_27 = bitcast i8* %_26 to i32* 
	store i32 %_23, i32* %_27
 

	store i32* %_27,i32** %intArray

	%_28 = getelementptr i8, i8* %this, i32 16
	%_29 = bitcast i8* %_28 to i32* 
	store i32 0,i32* %_29

	%_35 = getelementptr i8, i8* %this, i32 16
	%_36 = bitcast i8* %_35 to i32* 
	%_37 = load i32, i32* %_36
	call void (i32) @print_int(i32 %_37)

	%_38 = load i32*, i32** %intArray
	%_39 = load i32, i32* %_38

	call void (i32) @print_int(i32 %_39)

	store i32 0,i32* %i

	call void (i32) @print_int(i32 111)

	br label %loop1
	loop1: 
	%_45 = load i32, i32* %i
	%_46 = load i32*, i32** %intArray
	%_47 = load i32, i32* %_46

	%_48 = icmp slt i32 %_45, %_47

	br i1 %_48, label %loop2, label %loop3 
	loop2: 
	%_49 = load i32, i32* %i
	%_50 = add i32 %_49, 1

	call void (i32) @print_int(i32 %_50)

	%_56 = load i32, i32* %i
	%_57 = load i32, i32* %i
	%_58 = add i32 %_57, 1

	%_59 = load i32*, i32** %intArray
	%_60 = load i32, i32* %_59
	%_61 = icmp sge i32 %_56, 0
	%_62 = icmp slt i32 %_56, %_60
	%_63 = and i1 %_61, %_62
	br i1 %_63, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_64 = add i32 1, %_56
	%_65 = getelementptr i32, i32* %_59, i32 %_64
	store i32 %_58, i32* %_65
 

	%_71 = load i32, i32* %i
	%_72 = add i32 %_71, 1

	store i32 %_72,i32* %i

	br label %loop1
	loop3: 

	call void (i32) @print_int(i32 222)

	store i32 0,i32* %i

	br label %loop5
	loop5: 
	%_78 = load i32, i32* %i
	%_79 = load i32*, i32** %intArray
	%_80 = load i32, i32* %_79

	%_81 = icmp slt i32 %_78, %_80

	br i1 %_81, label %loop6, label %loop7 
	loop6: 
	%_82 = load i32*, i32** %intArray
	%_83 = load i32, i32* %i
	%_84 = load i32, i32* %_82
	%_85 = icmp sge i32 %_83, 0
	%_86 = icmp slt i32 %_83, %_84
	%_87 = and i1 %_85, %_86
	br i1 %_87, label %oob_ok_8, label %oob_err_8
 
	oob_err_8: 
	call void @throw_oob()
	br label %oob_ok_8
 
	oob_ok_8: 
	%_88 = add i32 1, %_83
	%_89 = getelementptr i32, i32* %_82, i32 %_88
	%_90 = load i32, i32* %_89

	call void (i32) @print_int(i32 %_90)

	%_96 = load i32, i32* %i
	%_97 = add i32 %_96, 1

	store i32 %_97,i32* %i

	br label %loop5
	loop7: 

	call void (i32) @print_int(i32 333)

	%_98 = load i32*, i32** %intArray
	%_99 = load i32, i32* %_98

	ret i32 %_99
}
 
define i32 @B.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32

	%intArray = alloca i32*

	%_105 = load i32, i32* %num
	%_106 = add i32 1, %_105
	%_107 = icmp sge i32 %_106, 1
	br i1 %_107, label %nsz_ok_9, label %nsz_err_9
 
	nsz_err_9: 
	call void @throw_nsz()
	br label %nsz_ok_9
 
	nsz_ok_9: 
	%_108 = call i8* @calloc(i32 %_106, i32 4) 
	%_109 = bitcast i8* %_108 to i32* 
	store i32 %_105, i32* %_109
 

	store i32* %_109,i32** %intArray

	%_110 = getelementptr i8, i8* %this, i32 20
	%_111 = bitcast i8* %_110 to i32* 
	store i32 12,i32* %_111

	%_117 = getelementptr i8, i8* %this, i32 20
	%_118 = bitcast i8* %_117 to i32* 
	%_119 = load i32, i32* %_118
	call void (i32) @print_int(i32 %_119)

	%_120 = load i32*, i32** %intArray
	%_121 = load i32, i32* %_120

	call void (i32) @print_int(i32 %_121)

	store i32 0,i32* %i

	call void (i32) @print_int(i32 111)

	br label %loop10
	loop10: 
	%_127 = load i32, i32* %i
	%_128 = load i32*, i32** %intArray
	%_129 = load i32, i32* %_128

	%_130 = icmp slt i32 %_127, %_129

	br i1 %_130, label %loop11, label %loop12 
	loop11: 
	%_131 = load i32, i32* %i
	%_132 = add i32 %_131, 1

	call void (i32) @print_int(i32 %_132)

	%_138 = load i32, i32* %i
	%_139 = load i32, i32* %i
	%_140 = add i32 %_139, 1

	%_141 = load i32*, i32** %intArray
	%_142 = load i32, i32* %_141
	%_143 = icmp sge i32 %_138, 0
	%_144 = icmp slt i32 %_138, %_142
	%_145 = and i1 %_143, %_144
	br i1 %_145, label %oob_ok_13, label %oob_err_13
 
	oob_err_13: 
	call void @throw_oob()
	br label %oob_ok_13
 
	oob_ok_13: 
	%_146 = add i32 1, %_138
	%_147 = getelementptr i32, i32* %_141, i32 %_146
	store i32 %_140, i32* %_147
 

	%_153 = load i32, i32* %i
	%_154 = add i32 %_153, 1

	store i32 %_154,i32* %i

	br label %loop10
	loop12: 

	call void (i32) @print_int(i32 222)

	store i32 0,i32* %i

	br label %loop14
	loop14: 
	%_160 = load i32, i32* %i
	%_161 = load i32*, i32** %intArray
	%_162 = load i32, i32* %_161

	%_163 = icmp slt i32 %_160, %_162

	br i1 %_163, label %loop15, label %loop16 
	loop15: 
	%_164 = load i32*, i32** %intArray
	%_165 = load i32, i32* %i
	%_166 = load i32, i32* %_164
	%_167 = icmp sge i32 %_165, 0
	%_168 = icmp slt i32 %_165, %_166
	%_169 = and i1 %_167, %_168
	br i1 %_169, label %oob_ok_17, label %oob_err_17
 
	oob_err_17: 
	call void @throw_oob()
	br label %oob_ok_17
 
	oob_ok_17: 
	%_170 = add i32 1, %_165
	%_171 = getelementptr i32, i32* %_164, i32 %_170
	%_172 = load i32, i32* %_171

	call void (i32) @print_int(i32 %_172)

	%_178 = load i32, i32* %i
	%_179 = add i32 %_178, 1

	store i32 %_179,i32* %i

	br label %loop14
	loop16: 

	call void (i32) @print_int(i32 333)

	%_180 = load i32*, i32** %intArray
	%_181 = load i32, i32* %_180

	ret i32 %_181
}
 
