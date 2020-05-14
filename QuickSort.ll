@.QuickSort_vtable = global [0 x i8*] [] 
 
@.QS_vtable = global [ 4 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @QS.Start to i8*),
	i8* bitcast (i32 (i8*,i32,i32)* @QS.Sort to i8*),
	i8* bitcast (i32 (i8*)* @QS.Print to i8*),
	i8* bitcast (i32 (i8*,i32)* @QS.Init to i8*)
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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.QS_vtable, i32 0, i32 0 
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
 
define i32 @QS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
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
	%_27 = getelementptr i8*, i8** %_26, i32 2 
	%_28 = load i8*, i8** %_27 
	%_29 = bitcast i8* %_28 to i32 (i8* )* 
	%_30 = call i32 %_29( i8* %this) 

	store i32 %_30,i32* %aux01

	call void (i32) @print_int(i32 9999)

	%_31 = getelementptr i8, i8* %this, i32 16
	%_32 = bitcast i8* %_31 to i32* 
	%_33 = load i32, i32* %_32
	%_34 = sub i32 %_33, 1

	store i32 %_34,i32* %aux01

	%_38 = bitcast i8* %this to i8*** 
	%_39 = load i8**, i8*** %_38 
	%_40 = getelementptr i8*, i8** %_39, i32 1 
	%_41 = load i8*, i8** %_40 
	%_42 = bitcast i8* %_41 to i32 (i8* , i32, i32)* 
	%_43 = load i32, i32* %aux01
	%_44 = call i32 %_42( i8* %this, i32 0, i32 %_43) 

	store i32 %_44,i32* %aux01

	%_48 = bitcast i8* %this to i8*** 
	%_49 = load i8**, i8*** %_48 
	%_50 = getelementptr i8*, i8** %_49, i32 2 
	%_51 = load i8*, i8** %_50 
	%_52 = bitcast i8* %_51 to i32 (i8* )* 
	%_53 = call i32 %_52( i8* %this) 

	store i32 %_53,i32* %aux01

	ret i32 0
}
 
define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
	%left = alloca i32
	store i32 %.left, i32* %left
	%right = alloca i32
	store i32 %.right, i32* %right
	%v = alloca i32
	%i = alloca i32
	%j = alloca i32
	%nt = alloca i32
	%t = alloca i32
	%cont01 = alloca i1
	%cont02 = alloca i1
	%aux03 = alloca i32
	store i32 0,i32* %t

	%_54 = load i32, i32* %left
	%_55 = load i32, i32* %right
	%_56 = icmp slt i32 %_54, %_55

	br i1 %_56, label %if_then_0, label %if_else_0 
	if_else_0: 
	store i32 0,i32* %nt

	br label %if_end_0
	if_then_0: 
	%_57 = getelementptr i8, i8* %this, i32 8
	%_58 = bitcast i8* %_57 to i32** 
	%_59 = load i32*, i32** %_58
	%_60 = load i32, i32* %right
	%_61 = load i32, i32* %_59
	%_62 = icmp sge i32 %_60, 0
	%_63 = icmp slt i32 %_60, %_61
	%_64 = and i1 %_62, %_63
	br i1 %_64, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_65 = add i32 1, %_60
	%_66 = getelementptr i32, i32* %_59, i32 %_65
	%_67 = load i32, i32* %_66

	store i32 %_67,i32* %v

	%_68 = load i32, i32* %left
	%_69 = sub i32 %_68, 1

	store i32 %_69,i32* %i

	%_70 = load i32, i32* %right
	store i32 %_70,i32* %j

	store i1 1,i1* %cont01

	br label %loop2
	loop2: 
	%_71 = load i1, i1* %cont01
	br i1 %_71, label %loop3, label %loop4 
	loop3: 
	store i1 1,i1* %cont02

	br label %loop5
	loop5: 
	%_72 = load i1, i1* %cont02
	br i1 %_72, label %loop6, label %loop7 
	loop6: 
	%_73 = load i32, i32* %i
	%_74 = add i32 %_73, 1

	store i32 %_74,i32* %i

	%_75 = getelementptr i8, i8* %this, i32 8
	%_76 = bitcast i8* %_75 to i32** 
	%_77 = load i32*, i32** %_76
	%_78 = load i32, i32* %i
	%_79 = load i32, i32* %_77
	%_80 = icmp sge i32 %_78, 0
	%_81 = icmp slt i32 %_78, %_79
	%_82 = and i1 %_80, %_81
	br i1 %_82, label %oob_ok_8, label %oob_err_8
 
	oob_err_8: 
	call void @throw_oob()
	br label %oob_ok_8
 
	oob_ok_8: 
	%_83 = add i32 1, %_78
	%_84 = getelementptr i32, i32* %_77, i32 %_83
	%_85 = load i32, i32* %_84

	store i32 %_85,i32* %aux03

	%_86 = load i32, i32* %aux03
	%_87 = load i32, i32* %v
	%_88 = icmp slt i32 %_86, %_87

	%_89 = xor i1 1, %_88

	br i1 %_89, label %if_then_9, label %if_else_9 
	if_else_9: 
	store i1 1,i1* %cont02

	br label %if_end_9
	if_then_9: 
	store i1 0,i1* %cont02

	br label %if_end_9
	if_end_9: 

	br label %loop5
	loop7: 

	store i1 1,i1* %cont02

	br label %loop10
	loop10: 
	%_90 = load i1, i1* %cont02
	br i1 %_90, label %loop11, label %loop12 
	loop11: 
	%_91 = load i32, i32* %j
	%_92 = sub i32 %_91, 1

	store i32 %_92,i32* %j

	%_93 = getelementptr i8, i8* %this, i32 8
	%_94 = bitcast i8* %_93 to i32** 
	%_95 = load i32*, i32** %_94
	%_96 = load i32, i32* %j
	%_97 = load i32, i32* %_95
	%_98 = icmp sge i32 %_96, 0
	%_99 = icmp slt i32 %_96, %_97
	%_100 = and i1 %_98, %_99
	br i1 %_100, label %oob_ok_13, label %oob_err_13
 
	oob_err_13: 
	call void @throw_oob()
	br label %oob_ok_13
 
	oob_ok_13: 
	%_101 = add i32 1, %_96
	%_102 = getelementptr i32, i32* %_95, i32 %_101
	%_103 = load i32, i32* %_102

	store i32 %_103,i32* %aux03

	%_104 = load i32, i32* %v
	%_105 = load i32, i32* %aux03
	%_106 = icmp slt i32 %_104, %_105

	%_107 = xor i1 1, %_106

	br i1 %_107, label %if_then_14, label %if_else_14 
	if_else_14: 
	store i1 1,i1* %cont02

	br label %if_end_14
	if_then_14: 
	store i1 0,i1* %cont02

	br label %if_end_14
	if_end_14: 

	br label %loop10
	loop12: 

	%_108 = getelementptr i8, i8* %this, i32 8
	%_109 = bitcast i8* %_108 to i32** 
	%_110 = load i32*, i32** %_109
	%_111 = load i32, i32* %i
	%_112 = load i32, i32* %_110
	%_113 = icmp sge i32 %_111, 0
	%_114 = icmp slt i32 %_111, %_112
	%_115 = and i1 %_113, %_114
	br i1 %_115, label %oob_ok_15, label %oob_err_15
 
	oob_err_15: 
	call void @throw_oob()
	br label %oob_ok_15
 
	oob_ok_15: 
	%_116 = add i32 1, %_111
	%_117 = getelementptr i32, i32* %_110, i32 %_116
	%_118 = load i32, i32* %_117

	store i32 %_118,i32* %t

	%_119 = getelementptr i8, i8* %this, i32 8
	%_120 = bitcast i8* %_119 to i32** 
	%_121 = load i32, i32* %i
	%_122 = getelementptr i8, i8* %this, i32 8
	%_123 = bitcast i8* %_122 to i32** 
	%_124 = load i32*, i32** %_123
	%_125 = load i32, i32* %j
	%_126 = load i32, i32* %_124
	%_127 = icmp sge i32 %_125, 0
	%_128 = icmp slt i32 %_125, %_126
	%_129 = and i1 %_127, %_128
	br i1 %_129, label %oob_ok_16, label %oob_err_16
 
	oob_err_16: 
	call void @throw_oob()
	br label %oob_ok_16
 
	oob_ok_16: 
	%_130 = add i32 1, %_125
	%_131 = getelementptr i32, i32* %_124, i32 %_130
	%_132 = load i32, i32* %_131

	%_133 = load i32*, i32** %_120
	%_134 = load i32, i32* %_133
	%_135 = icmp sge i32 %_121, 0
	%_136 = icmp slt i32 %_121, %_134
	%_137 = and i1 %_135, %_136
	br i1 %_137, label %oob_ok_17, label %oob_err_17
 
	oob_err_17: 
	call void @throw_oob()
	br label %oob_ok_17
 
	oob_ok_17: 
	%_138 = add i32 1, %_121
	%_139 = getelementptr i32, i32* %_133, i32 %_138
	store i32 %_132, i32* %_139
 

	%_140 = getelementptr i8, i8* %this, i32 8
	%_141 = bitcast i8* %_140 to i32** 
	%_142 = load i32, i32* %j
	%_143 = load i32, i32* %t
	%_144 = load i32*, i32** %_141
	%_145 = load i32, i32* %_144
	%_146 = icmp sge i32 %_142, 0
	%_147 = icmp slt i32 %_142, %_145
	%_148 = and i1 %_146, %_147
	br i1 %_148, label %oob_ok_18, label %oob_err_18
 
	oob_err_18: 
	call void @throw_oob()
	br label %oob_ok_18
 
	oob_ok_18: 
	%_149 = add i32 1, %_142
	%_150 = getelementptr i32, i32* %_144, i32 %_149
	store i32 %_143, i32* %_150
 

	%_151 = load i32, i32* %j
	%_152 = load i32, i32* %i
	%_153 = add i32 %_152, 1

	%_154 = icmp slt i32 %_151, %_153

	br i1 %_154, label %if_then_19, label %if_else_19 
	if_else_19: 
	store i1 1,i1* %cont01

	br label %if_end_19
	if_then_19: 
	store i1 0,i1* %cont01

	br label %if_end_19
	if_end_19: 

	br label %loop2
	loop4: 

	%_155 = getelementptr i8, i8* %this, i32 8
	%_156 = bitcast i8* %_155 to i32** 
	%_157 = load i32, i32* %j
	%_158 = getelementptr i8, i8* %this, i32 8
	%_159 = bitcast i8* %_158 to i32** 
	%_160 = load i32*, i32** %_159
	%_161 = load i32, i32* %i
	%_162 = load i32, i32* %_160
	%_163 = icmp sge i32 %_161, 0
	%_164 = icmp slt i32 %_161, %_162
	%_165 = and i1 %_163, %_164
	br i1 %_165, label %oob_ok_20, label %oob_err_20
 
	oob_err_20: 
	call void @throw_oob()
	br label %oob_ok_20
 
	oob_ok_20: 
	%_166 = add i32 1, %_161
	%_167 = getelementptr i32, i32* %_160, i32 %_166
	%_168 = load i32, i32* %_167

	%_169 = load i32*, i32** %_156
	%_170 = load i32, i32* %_169
	%_171 = icmp sge i32 %_157, 0
	%_172 = icmp slt i32 %_157, %_170
	%_173 = and i1 %_171, %_172
	br i1 %_173, label %oob_ok_21, label %oob_err_21
 
	oob_err_21: 
	call void @throw_oob()
	br label %oob_ok_21
 
	oob_ok_21: 
	%_174 = add i32 1, %_157
	%_175 = getelementptr i32, i32* %_169, i32 %_174
	store i32 %_168, i32* %_175
 

	%_176 = getelementptr i8, i8* %this, i32 8
	%_177 = bitcast i8* %_176 to i32** 
	%_178 = load i32, i32* %i
	%_179 = getelementptr i8, i8* %this, i32 8
	%_180 = bitcast i8* %_179 to i32** 
	%_181 = load i32*, i32** %_180
	%_182 = load i32, i32* %right
	%_183 = load i32, i32* %_181
	%_184 = icmp sge i32 %_182, 0
	%_185 = icmp slt i32 %_182, %_183
	%_186 = and i1 %_184, %_185
	br i1 %_186, label %oob_ok_22, label %oob_err_22
 
	oob_err_22: 
	call void @throw_oob()
	br label %oob_ok_22
 
	oob_ok_22: 
	%_187 = add i32 1, %_182
	%_188 = getelementptr i32, i32* %_181, i32 %_187
	%_189 = load i32, i32* %_188

	%_190 = load i32*, i32** %_177
	%_191 = load i32, i32* %_190
	%_192 = icmp sge i32 %_178, 0
	%_193 = icmp slt i32 %_178, %_191
	%_194 = and i1 %_192, %_193
	br i1 %_194, label %oob_ok_23, label %oob_err_23
 
	oob_err_23: 
	call void @throw_oob()
	br label %oob_ok_23
 
	oob_ok_23: 
	%_195 = add i32 1, %_178
	%_196 = getelementptr i32, i32* %_190, i32 %_195
	store i32 %_189, i32* %_196
 

	%_197 = getelementptr i8, i8* %this, i32 8
	%_198 = bitcast i8* %_197 to i32** 
	%_199 = load i32, i32* %right
	%_200 = load i32, i32* %t
	%_201 = load i32*, i32** %_198
	%_202 = load i32, i32* %_201
	%_203 = icmp sge i32 %_199, 0
	%_204 = icmp slt i32 %_199, %_202
	%_205 = and i1 %_203, %_204
	br i1 %_205, label %oob_ok_24, label %oob_err_24
 
	oob_err_24: 
	call void @throw_oob()
	br label %oob_ok_24
 
	oob_ok_24: 
	%_206 = add i32 1, %_199
	%_207 = getelementptr i32, i32* %_201, i32 %_206
	store i32 %_200, i32* %_207
 

	%_211 = bitcast i8* %this to i8*** 
	%_212 = load i8**, i8*** %_211 
	%_213 = getelementptr i8*, i8** %_212, i32 1 
	%_214 = load i8*, i8** %_213 
	%_215 = bitcast i8* %_214 to i32 (i8* , i32, i32)* 
	%_216 = load i32, i32* %left
	%_217 = load i32, i32* %i
	%_218 = sub i32 %_217, 1

	%_219 = call i32 %_215( i8* %this, i32 %_216, i32 %_218) 

	store i32 %_219,i32* %nt

	%_223 = bitcast i8* %this to i8*** 
	%_224 = load i8**, i8*** %_223 
	%_225 = getelementptr i8*, i8** %_224, i32 1 
	%_226 = load i8*, i8** %_225 
	%_227 = bitcast i8* %_226 to i32 (i8* , i32, i32)* 
	%_228 = load i32, i32* %i
	%_229 = add i32 %_228, 1

	%_230 = load i32, i32* %right
	%_231 = call i32 %_227( i8* %this, i32 %_229, i32 %_230) 

	store i32 %_231,i32* %nt

	br label %if_end_0
	if_end_0: 

	ret i32 0
}
 
define i32 @QS.Print(i8* %this) {
	%j = alloca i32
	store i32 0,i32* %j

	br label %loop25
	loop25: 
	%_232 = load i32, i32* %j
	%_233 = getelementptr i8, i8* %this, i32 16
	%_234 = bitcast i8* %_233 to i32* 
	%_235 = load i32, i32* %_234
	%_236 = icmp slt i32 %_232, %_235

	br i1 %_236, label %loop26, label %loop27 
	loop26: 
	%_237 = getelementptr i8, i8* %this, i32 8
	%_238 = bitcast i8* %_237 to i32** 
	%_239 = load i32*, i32** %_238
	%_240 = load i32, i32* %j
	%_241 = load i32, i32* %_239
	%_242 = icmp sge i32 %_240, 0
	%_243 = icmp slt i32 %_240, %_241
	%_244 = and i1 %_242, %_243
	br i1 %_244, label %oob_ok_28, label %oob_err_28
 
	oob_err_28: 
	call void @throw_oob()
	br label %oob_ok_28
 
	oob_ok_28: 
	%_245 = add i32 1, %_240
	%_246 = getelementptr i32, i32* %_239, i32 %_245
	%_247 = load i32, i32* %_246

	call void (i32) @print_int(i32 %_247)

	%_248 = load i32, i32* %j
	%_249 = add i32 %_248, 1

	store i32 %_249,i32* %j

	br label %loop25
	loop27: 

	ret i32 0
}
 
define i32 @QS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%_250 = getelementptr i8, i8* %this, i32 16
	%_251 = bitcast i8* %_250 to i32* 
	%_252 = load i32, i32* %sz
	store i32 %_252,i32* %_251

	%_253 = getelementptr i8, i8* %this, i32 8
	%_254 = bitcast i8* %_253 to i32** 
	%_255 = load i32, i32* %sz
	%_256 = add i32 1, %_255
	%_257 = icmp sge i32 %_256, 1
	br i1 %_257, label %nsz_ok_29, label %nsz_err_29
 
	nsz_err_29: 
	call void @throw_nsz()
	br label %nsz_ok_29
 
	nsz_ok_29: 
	%_258 = call i8* @calloc(i32 %_256, i32 4) 
	%_259 = bitcast i8* %_258 to i32* 
	store i32 %_255, i32* %_259
 

	store i32* %_259,i32** %_254

	%_260 = getelementptr i8, i8* %this, i32 8
	%_261 = bitcast i8* %_260 to i32** 
	%_262 = load i32*, i32** %_261
	%_263 = load i32, i32* %_262
	%_264 = icmp sge i32 0, 0
	%_265 = icmp slt i32 0, %_263
	%_266 = and i1 %_264, %_265
	br i1 %_266, label %oob_ok_30, label %oob_err_30
 
	oob_err_30: 
	call void @throw_oob()
	br label %oob_ok_30
 
	oob_ok_30: 
	%_267 = add i32 1, 0
	%_268 = getelementptr i32, i32* %_262, i32 %_267
	store i32 20, i32* %_268
 

	%_269 = getelementptr i8, i8* %this, i32 8
	%_270 = bitcast i8* %_269 to i32** 
	%_271 = load i32*, i32** %_270
	%_272 = load i32, i32* %_271
	%_273 = icmp sge i32 1, 0
	%_274 = icmp slt i32 1, %_272
	%_275 = and i1 %_273, %_274
	br i1 %_275, label %oob_ok_31, label %oob_err_31
 
	oob_err_31: 
	call void @throw_oob()
	br label %oob_ok_31
 
	oob_ok_31: 
	%_276 = add i32 1, 1
	%_277 = getelementptr i32, i32* %_271, i32 %_276
	store i32 7, i32* %_277
 

	%_278 = getelementptr i8, i8* %this, i32 8
	%_279 = bitcast i8* %_278 to i32** 
	%_280 = load i32*, i32** %_279
	%_281 = load i32, i32* %_280
	%_282 = icmp sge i32 2, 0
	%_283 = icmp slt i32 2, %_281
	%_284 = and i1 %_282, %_283
	br i1 %_284, label %oob_ok_32, label %oob_err_32
 
	oob_err_32: 
	call void @throw_oob()
	br label %oob_ok_32
 
	oob_ok_32: 
	%_285 = add i32 1, 2
	%_286 = getelementptr i32, i32* %_280, i32 %_285
	store i32 12, i32* %_286
 

	%_287 = getelementptr i8, i8* %this, i32 8
	%_288 = bitcast i8* %_287 to i32** 
	%_289 = load i32*, i32** %_288
	%_290 = load i32, i32* %_289
	%_291 = icmp sge i32 3, 0
	%_292 = icmp slt i32 3, %_290
	%_293 = and i1 %_291, %_292
	br i1 %_293, label %oob_ok_33, label %oob_err_33
 
	oob_err_33: 
	call void @throw_oob()
	br label %oob_ok_33
 
	oob_ok_33: 
	%_294 = add i32 1, 3
	%_295 = getelementptr i32, i32* %_289, i32 %_294
	store i32 18, i32* %_295
 

	%_296 = getelementptr i8, i8* %this, i32 8
	%_297 = bitcast i8* %_296 to i32** 
	%_298 = load i32*, i32** %_297
	%_299 = load i32, i32* %_298
	%_300 = icmp sge i32 4, 0
	%_301 = icmp slt i32 4, %_299
	%_302 = and i1 %_300, %_301
	br i1 %_302, label %oob_ok_34, label %oob_err_34
 
	oob_err_34: 
	call void @throw_oob()
	br label %oob_ok_34
 
	oob_ok_34: 
	%_303 = add i32 1, 4
	%_304 = getelementptr i32, i32* %_298, i32 %_303
	store i32 2, i32* %_304
 

	%_305 = getelementptr i8, i8* %this, i32 8
	%_306 = bitcast i8* %_305 to i32** 
	%_307 = load i32*, i32** %_306
	%_308 = load i32, i32* %_307
	%_309 = icmp sge i32 5, 0
	%_310 = icmp slt i32 5, %_308
	%_311 = and i1 %_309, %_310
	br i1 %_311, label %oob_ok_35, label %oob_err_35
 
	oob_err_35: 
	call void @throw_oob()
	br label %oob_ok_35
 
	oob_ok_35: 
	%_312 = add i32 1, 5
	%_313 = getelementptr i32, i32* %_307, i32 %_312
	store i32 11, i32* %_313
 

	%_314 = getelementptr i8, i8* %this, i32 8
	%_315 = bitcast i8* %_314 to i32** 
	%_316 = load i32*, i32** %_315
	%_317 = load i32, i32* %_316
	%_318 = icmp sge i32 6, 0
	%_319 = icmp slt i32 6, %_317
	%_320 = and i1 %_318, %_319
	br i1 %_320, label %oob_ok_36, label %oob_err_36
 
	oob_err_36: 
	call void @throw_oob()
	br label %oob_ok_36
 
	oob_ok_36: 
	%_321 = add i32 1, 6
	%_322 = getelementptr i32, i32* %_316, i32 %_321
	store i32 6, i32* %_322
 

	%_323 = getelementptr i8, i8* %this, i32 8
	%_324 = bitcast i8* %_323 to i32** 
	%_325 = load i32*, i32** %_324
	%_326 = load i32, i32* %_325
	%_327 = icmp sge i32 7, 0
	%_328 = icmp slt i32 7, %_326
	%_329 = and i1 %_327, %_328
	br i1 %_329, label %oob_ok_37, label %oob_err_37
 
	oob_err_37: 
	call void @throw_oob()
	br label %oob_ok_37
 
	oob_ok_37: 
	%_330 = add i32 1, 7
	%_331 = getelementptr i32, i32* %_325, i32 %_330
	store i32 9, i32* %_331
 

	%_332 = getelementptr i8, i8* %this, i32 8
	%_333 = bitcast i8* %_332 to i32** 
	%_334 = load i32*, i32** %_333
	%_335 = load i32, i32* %_334
	%_336 = icmp sge i32 8, 0
	%_337 = icmp slt i32 8, %_335
	%_338 = and i1 %_336, %_337
	br i1 %_338, label %oob_ok_38, label %oob_err_38
 
	oob_err_38: 
	call void @throw_oob()
	br label %oob_ok_38
 
	oob_ok_38: 
	%_339 = add i32 1, 8
	%_340 = getelementptr i32, i32* %_334, i32 %_339
	store i32 19, i32* %_340
 

	%_341 = getelementptr i8, i8* %this, i32 8
	%_342 = bitcast i8* %_341 to i32** 
	%_343 = load i32*, i32** %_342
	%_344 = load i32, i32* %_343
	%_345 = icmp sge i32 9, 0
	%_346 = icmp slt i32 9, %_344
	%_347 = and i1 %_345, %_346
	br i1 %_347, label %oob_ok_39, label %oob_err_39
 
	oob_err_39: 
	call void @throw_oob()
	br label %oob_ok_39
 
	oob_ok_39: 
	%_348 = add i32 1, 9
	%_349 = getelementptr i32, i32* %_343, i32 %_348
	store i32 5, i32* %_349
 

	ret i32 0
}
 
