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

	%_20 = bitcast i8* %this to i8*** 
	%_21 = load i8**, i8*** %_20 
	%_22 = getelementptr i8*, i8** %_21, i32 3 
	%_23 = load i8*, i8** %_22 
	%_24 = bitcast i8* %_23 to i32 (i8* , i32)* 
	%_25 = load i32, i32* %sz
	%_26 = call i32 %_24( i8* %this, i32 %_25) 

	store i32 %_26,i32* %aux01

	%_35 = bitcast i8* %this to i8*** 
	%_36 = load i8**, i8*** %_35 
	%_37 = getelementptr i8*, i8** %_36, i32 1 
	%_38 = load i8*, i8** %_37 
	%_39 = bitcast i8* %_38 to i32 (i8* )* 
	%_40 = call i32 %_39( i8* %this) 

	store i32 %_40,i32* %aux02

	call void (i32) @print_int(i32 9999)

	%_44 = bitcast i8* %this to i8*** 
	%_45 = load i8**, i8*** %_44 
	%_46 = getelementptr i8*, i8** %_45, i32 2 
	%_47 = load i8*, i8** %_46 
	%_48 = bitcast i8* %_47 to i32 (i8* , i32)* 
	%_49 = call i32 %_48( i8* %this, i32 8) 

	call void (i32) @print_int(i32 %_49)

	%_53 = bitcast i8* %this to i8*** 
	%_54 = load i8**, i8*** %_53 
	%_55 = getelementptr i8*, i8** %_54, i32 2 
	%_56 = load i8*, i8** %_55 
	%_57 = bitcast i8* %_56 to i32 (i8* , i32)* 
	%_58 = call i32 %_57( i8* %this, i32 12) 

	call void (i32) @print_int(i32 %_58)

	%_62 = bitcast i8* %this to i8*** 
	%_63 = load i8**, i8*** %_62 
	%_64 = getelementptr i8*, i8** %_63, i32 2 
	%_65 = load i8*, i8** %_64 
	%_66 = bitcast i8* %_65 to i32 (i8* , i32)* 
	%_67 = call i32 %_66( i8* %this, i32 17) 

	call void (i32) @print_int(i32 %_67)

	%_71 = bitcast i8* %this to i8*** 
	%_72 = load i8**, i8*** %_71 
	%_73 = getelementptr i8*, i8** %_72, i32 2 
	%_74 = load i8*, i8** %_73 
	%_75 = bitcast i8* %_74 to i32 (i8* , i32)* 
	%_76 = call i32 %_75( i8* %this, i32 50) 

	call void (i32) @print_int(i32 %_76)

	ret i32 55
}
 
define i32 @LS.Print(i8* %this) {
	%j = alloca i32

	store i32 1,i32* %j

	br label %loop0
	loop0: 
	%_82 = load i32, i32* %j
	%_83 = getelementptr i8, i8* %this, i32 16
	%_84 = bitcast i8* %_83 to i32* 
	%_85 = load i32, i32* %_84
	%_86 = icmp slt i32 %_82, %_85

	br i1 %_86, label %loop1, label %loop2 
	loop1: 
	%_87 = getelementptr i8, i8* %this, i32 8
	%_88 = bitcast i8* %_87 to i32** 
	%_89 = load i32*, i32** %_88
	%_90 = load i32, i32* %j
	%_91 = load i32, i32* %_89
	%_92 = icmp sge i32 %_90, 0
	%_93 = icmp slt i32 %_90, %_91
	%_94 = and i1 %_92, %_93
	br i1 %_94, label %oob_ok_3, label %oob_err_3
 
	oob_err_3: 
	call void @throw_oob()
	br label %oob_ok_3
 
	oob_ok_3: 
	%_95 = add i32 1, %_90
	%_96 = getelementptr i32, i32* %_89, i32 %_95
	%_97 = load i32, i32* %_96

	call void (i32) @print_int(i32 %_97)

	%_103 = load i32, i32* %j
	%_104 = add i32 %_103, 1

	store i32 %_104,i32* %j

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
	%_120 = load i32, i32* %j
	%_121 = getelementptr i8, i8* %this, i32 16
	%_122 = bitcast i8* %_121 to i32* 
	%_123 = load i32, i32* %_122
	%_124 = icmp slt i32 %_120, %_123

	br i1 %_124, label %loop5, label %loop6 
	loop5: 
	%_130 = getelementptr i8, i8* %this, i32 8
	%_131 = bitcast i8* %_130 to i32** 
	%_132 = load i32*, i32** %_131
	%_133 = load i32, i32* %j
	%_134 = load i32, i32* %_132
	%_135 = icmp sge i32 %_133, 0
	%_136 = icmp slt i32 %_133, %_134
	%_137 = and i1 %_135, %_136
	br i1 %_137, label %oob_ok_7, label %oob_err_7
 
	oob_err_7: 
	call void @throw_oob()
	br label %oob_ok_7
 
	oob_ok_7: 
	%_138 = add i32 1, %_133
	%_139 = getelementptr i32, i32* %_132, i32 %_138
	%_140 = load i32, i32* %_139

	store i32 %_140,i32* %aux01

	%_146 = load i32, i32* %num
	%_147 = add i32 %_146, 1

	store i32 %_147,i32* %aux02

	%_148 = load i32, i32* %aux01
	%_149 = load i32, i32* %num
	%_150 = icmp slt i32 %_148, %_149

	br i1 %_150, label %if_then_8, label %if_else_8 
	if_else_8: 
	%_151 = load i32, i32* %aux01
	%_152 = load i32, i32* %aux02
	%_153 = icmp slt i32 %_151, %_152

%_154 = xor i1 1, %_153

	br i1 %_154, label %if_then_9, label %if_else_9 
	if_else_9: 
	store i1 1,i1* %ls01

	store i32 1,i32* %ifound

	%_170 = getelementptr i8, i8* %this, i32 16
	%_171 = bitcast i8* %_170 to i32* 
	%_172 = load i32, i32* %_171
	store i32 %_172,i32* %j

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

	%_188 = load i32, i32* %j
	%_189 = add i32 %_188, 1

	store i32 %_189,i32* %j

	br label %loop4
	loop6: 

	%_190 = load i32, i32* %ifound
	ret i32 %_190
}
 
define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32

	%k = alloca i32

	%aux01 = alloca i32

	%aux02 = alloca i32

	%_191 = getelementptr i8, i8* %this, i32 16
	%_192 = bitcast i8* %_191 to i32* 
	%_198 = load i32, i32* %sz
	store i32 %_198,i32* %_192

	%_199 = getelementptr i8, i8* %this, i32 8
	%_200 = bitcast i8* %_199 to i32** 
	%_206 = load i32, i32* %sz
	%_207 = add i32 1, %_206
	%_208 = icmp sge i32 %_207, 1
	br i1 %_208, label %nsz_ok_10, label %nsz_err_10
 
	nsz_err_10: 
	call void @throw_nsz()
	br label %nsz_ok_10
 
	nsz_ok_10: 
	%_209 = call i8* @calloc(i32 %_207, i32 4) 
	%_210 = bitcast i8* %_209 to i32* 
	store i32 %_206, i32* %_210
 

	store i32* %_210,i32** %_200

	store i32 1,i32* %j

	%_221 = getelementptr i8, i8* %this, i32 16
	%_222 = bitcast i8* %_221 to i32* 
	%_223 = load i32, i32* %_222
	%_224 = add i32 %_223, 1

	store i32 %_224,i32* %k

	br label %loop11
	loop11: 
	%_225 = load i32, i32* %j
	%_226 = getelementptr i8, i8* %this, i32 16
	%_227 = bitcast i8* %_226 to i32* 
	%_228 = load i32, i32* %_227
	%_229 = icmp slt i32 %_225, %_228

	br i1 %_229, label %loop12, label %loop13 
	loop12: 
	%_235 = load i32, i32* %j
	%_236 = mul i32 2, %_235

	store i32 %_236,i32* %aux01

	%_242 = load i32, i32* %k
	%_243 = sub i32 %_242, 3

	store i32 %_243,i32* %aux02

	%_244 = getelementptr i8, i8* %this, i32 8
	%_245 = bitcast i8* %_244 to i32** 
	%_251 = load i32, i32* %j
	%_252 = load i32, i32* %aux01
	%_253 = load i32, i32* %aux02
	%_254 = add i32 %_252, %_253

	%_255 = load i32*, i32** %_245
	%_256 = load i32, i32* %_255
	%_257 = icmp sge i32 %_251, 0
	%_258 = icmp slt i32 %_251, %_256
	%_259 = and i1 %_257, %_258
	br i1 %_259, label %oob_ok_14, label %oob_err_14
 
	oob_err_14: 
	call void @throw_oob()
	br label %oob_ok_14
 
	oob_ok_14: 
	%_260 = add i32 1, %_251
	%_261 = getelementptr i32, i32* %_255, i32 %_260
	store i32 %_254, i32* %_261
 

	%_267 = load i32, i32* %j
	%_268 = add i32 %_267, 1

	store i32 %_268,i32* %j

	%_274 = load i32, i32* %k
	%_275 = sub i32 %_274, 1

	store i32 %_275,i32* %k

	br label %loop11
	loop13: 

	ret i32 0
}
 
