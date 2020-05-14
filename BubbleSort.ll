@.BubbleSort_vtable = global [0 x i8*] [] 
 
@.BBS_vtable = global [ 4 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*),
	i8* bitcast (i32 (i8*)* @BBS.Sort to i8*),
	i8* bitcast (i32 (i8*)* @BBS.Print to i8*),
	i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)
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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0 
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
 
define i32 @BBS.Start(i8* %this, i32 %.sz) {
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

	call void (i32) @print_int(i32 99999)

	%_34 = bitcast i8* %this to i8*** 
	%_35 = load i8**, i8*** %_34 
	%_36 = getelementptr i8*, i8** %_35, i32 1 
	%_37 = load i8*, i8** %_36 
	%_38 = bitcast i8* %_37 to i32 (i8* )* 
	%_39 = call i32 %_38( i8* %this) 

	store i32 %_39,i32* %aux01

	%_43 = bitcast i8* %this to i8*** 
	%_44 = load i8**, i8*** %_43 
	%_45 = getelementptr i8*, i8** %_44, i32 2 
	%_46 = load i8*, i8** %_45 
	%_47 = bitcast i8* %_46 to i32 (i8* )* 
	%_48 = call i32 %_47( i8* %this) 

	store i32 %_48,i32* %aux01

	ret i32 0
}
 
define i32 @BBS.Sort(i8* %this) {
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32
	%_49 = getelementptr i8, i8* %this, i32 16
	%_50 = bitcast i8* %_49 to i32* 
	%_51 = load i32, i32* %_50
	%_52 = sub i32 %_51, 1

	store i32 %_52,i32* %i

	%_53 = sub i32 0, 1

	store i32 %_53,i32* %aux02

	br label %loop0
	loop0: 
	%_54 = load i32, i32* %aux02
	%_55 = load i32, i32* %i
	%_56 = icmp slt i32 %_54, %_55

	br i1 %_56, label %loop1, label %loop2 
	loop1: 
	store i32 1,i32* %j

	br label %loop3
	loop3: 
	%_57 = load i32, i32* %j
	%_58 = load i32, i32* %i
	%_59 = add i32 %_58, 1

	%_60 = icmp slt i32 %_57, %_59

	br i1 %_60, label %loop4, label %loop5 
	loop4: 
	%_61 = load i32, i32* %j
	%_62 = sub i32 %_61, 1

	store i32 %_62,i32* %aux07

	%_63 = getelementptr i8, i8* %this, i32 8
	%_64 = bitcast i8* %_63 to i32** 
	%_65 = load i32*, i32** %_64
	%_66 = load i32, i32* %aux07
	%_67 = load i32, i32* %_65
	%_68 = icmp sge i32 %_66, 0
	%_69 = icmp slt i32 %_66, %_67
	%_70 = and i1 %_68, %_69
	br i1 %_70, label %oob_ok_6, label %oob_err_6
 
	oob_err_6: 
	call void @throw_oob()
	br label %oob_ok_6
 
	oob_ok_6: 
	%_71 = add i32 1, %_66
	%_72 = getelementptr i32, i32* %_65, i32 %_71
	%_73 = load i32, i32* %_72

	store i32 %_73,i32* %aux04

	%_74 = getelementptr i8, i8* %this, i32 8
	%_75 = bitcast i8* %_74 to i32** 
	%_76 = load i32*, i32** %_75
	%_77 = load i32, i32* %j
	%_78 = load i32, i32* %_76
	%_79 = icmp sge i32 %_77, 0
	%_80 = icmp slt i32 %_77, %_78
	%_81 = and i1 %_79, %_80
	br i1 %_81, label %oob_ok_7, label %oob_err_7
 
	oob_err_7: 
	call void @throw_oob()
	br label %oob_ok_7
 
	oob_ok_7: 
	%_82 = add i32 1, %_77
	%_83 = getelementptr i32, i32* %_76, i32 %_82
	%_84 = load i32, i32* %_83

	store i32 %_84,i32* %aux05

	%_85 = load i32, i32* %aux05
	%_86 = load i32, i32* %aux04
	%_87 = icmp slt i32 %_85, %_86

	br i1 %_87, label %if_then_8, label %if_else_8 
	if_else_8: 
	store i32 0,i32* %nt

	br label %if_end_8
	if_then_8: 
	%_88 = load i32, i32* %j
	%_89 = sub i32 %_88, 1

	store i32 %_89,i32* %aux06

	%_90 = getelementptr i8, i8* %this, i32 8
	%_91 = bitcast i8* %_90 to i32** 
	%_92 = load i32*, i32** %_91
	%_93 = load i32, i32* %aux06
	%_94 = load i32, i32* %_92
	%_95 = icmp sge i32 %_93, 0
	%_96 = icmp slt i32 %_93, %_94
	%_97 = and i1 %_95, %_96
	br i1 %_97, label %oob_ok_9, label %oob_err_9
 
	oob_err_9: 
	call void @throw_oob()
	br label %oob_ok_9
 
	oob_ok_9: 
	%_98 = add i32 1, %_93
	%_99 = getelementptr i32, i32* %_92, i32 %_98
	%_100 = load i32, i32* %_99

	store i32 %_100,i32* %t

	%_101 = getelementptr i8, i8* %this, i32 8
	%_102 = bitcast i8* %_101 to i32** 
	%_103 = load i32, i32* %aux06
	%_104 = getelementptr i8, i8* %this, i32 8
	%_105 = bitcast i8* %_104 to i32** 
	%_106 = load i32*, i32** %_105
	%_107 = load i32, i32* %j
	%_108 = load i32, i32* %_106
	%_109 = icmp sge i32 %_107, 0
	%_110 = icmp slt i32 %_107, %_108
	%_111 = and i1 %_109, %_110
	br i1 %_111, label %oob_ok_10, label %oob_err_10
 
	oob_err_10: 
	call void @throw_oob()
	br label %oob_ok_10
 
	oob_ok_10: 
	%_112 = add i32 1, %_107
	%_113 = getelementptr i32, i32* %_106, i32 %_112
	%_114 = load i32, i32* %_113

	%_115 = load i32*, i32** %_102
	%_116 = load i32, i32* %_115
	%_117 = icmp sge i32 %_103, 0
	%_118 = icmp slt i32 %_103, %_116
	%_119 = and i1 %_117, %_118
	br i1 %_119, label %oob_ok_11, label %oob_err_11
 
	oob_err_11: 
	call void @throw_oob()
	br label %oob_ok_11
 
	oob_ok_11: 
	%_120 = add i32 1, %_103
	%_121 = getelementptr i32, i32* %_115, i32 %_120
	store i32 %_114, i32* %_121
 

	%_122 = getelementptr i8, i8* %this, i32 8
	%_123 = bitcast i8* %_122 to i32** 
	%_124 = load i32, i32* %j
	%_125 = load i32, i32* %t
	%_126 = load i32*, i32** %_123
	%_127 = load i32, i32* %_126
	%_128 = icmp sge i32 %_124, 0
	%_129 = icmp slt i32 %_124, %_127
	%_130 = and i1 %_128, %_129
	br i1 %_130, label %oob_ok_12, label %oob_err_12
 
	oob_err_12: 
	call void @throw_oob()
	br label %oob_ok_12
 
	oob_ok_12: 
	%_131 = add i32 1, %_124
	%_132 = getelementptr i32, i32* %_126, i32 %_131
	store i32 %_125, i32* %_132
 

	br label %if_end_8
	if_end_8: 

	%_133 = load i32, i32* %j
	%_134 = add i32 %_133, 1

	store i32 %_134,i32* %j

	br label %loop3
	loop5: 

	%_135 = load i32, i32* %i
	%_136 = sub i32 %_135, 1

	store i32 %_136,i32* %i

	br label %loop0
	loop2: 

	ret i32 0
}
 
define i32 @BBS.Print(i8* %this) {
	%j = alloca i32
	store i32 0,i32* %j

	br label %loop13
	loop13: 
	%_137 = load i32, i32* %j
	%_138 = getelementptr i8, i8* %this, i32 16
	%_139 = bitcast i8* %_138 to i32* 
	%_140 = load i32, i32* %_139
	%_141 = icmp slt i32 %_137, %_140

	br i1 %_141, label %loop14, label %loop15 
	loop14: 
	%_142 = getelementptr i8, i8* %this, i32 8
	%_143 = bitcast i8* %_142 to i32** 
	%_144 = load i32*, i32** %_143
	%_145 = load i32, i32* %j
	%_146 = load i32, i32* %_144
	%_147 = icmp sge i32 %_145, 0
	%_148 = icmp slt i32 %_145, %_146
	%_149 = and i1 %_147, %_148
	br i1 %_149, label %oob_ok_16, label %oob_err_16
 
	oob_err_16: 
	call void @throw_oob()
	br label %oob_ok_16
 
	oob_ok_16: 
	%_150 = add i32 1, %_145
	%_151 = getelementptr i32, i32* %_144, i32 %_150
	%_152 = load i32, i32* %_151

	call void (i32) @print_int(i32 %_152)

	%_153 = load i32, i32* %j
	%_154 = add i32 %_153, 1

	store i32 %_154,i32* %j

	br label %loop13
	loop15: 

	ret i32 0
}
 
define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%_155 = getelementptr i8, i8* %this, i32 16
	%_156 = bitcast i8* %_155 to i32* 
	%_157 = load i32, i32* %sz
	store i32 %_157,i32* %_156

	%_158 = getelementptr i8, i8* %this, i32 8
	%_159 = bitcast i8* %_158 to i32** 
	%_160 = load i32, i32* %sz
	%_161 = add i32 1, %_160
	%_162 = icmp sge i32 %_161, 1
	br i1 %_162, label %nsz_ok_17, label %nsz_err_17
 
	nsz_err_17: 
	call void @throw_nsz()
	br label %nsz_ok_17
 
	nsz_ok_17: 
	%_163 = call i8* @calloc(i32 %_161, i32 4) 
	%_164 = bitcast i8* %_163 to i32* 
	store i32 %_160, i32* %_164
 

	store i32* %_164,i32** %_159

	%_165 = getelementptr i8, i8* %this, i32 8
	%_166 = bitcast i8* %_165 to i32** 
	%_167 = load i32*, i32** %_166
	%_168 = load i32, i32* %_167
	%_169 = icmp sge i32 0, 0
	%_170 = icmp slt i32 0, %_168
	%_171 = and i1 %_169, %_170
	br i1 %_171, label %oob_ok_18, label %oob_err_18
 
	oob_err_18: 
	call void @throw_oob()
	br label %oob_ok_18
 
	oob_ok_18: 
	%_172 = add i32 1, 0
	%_173 = getelementptr i32, i32* %_167, i32 %_172
	store i32 20, i32* %_173
 

	%_174 = getelementptr i8, i8* %this, i32 8
	%_175 = bitcast i8* %_174 to i32** 
	%_176 = load i32*, i32** %_175
	%_177 = load i32, i32* %_176
	%_178 = icmp sge i32 1, 0
	%_179 = icmp slt i32 1, %_177
	%_180 = and i1 %_178, %_179
	br i1 %_180, label %oob_ok_19, label %oob_err_19
 
	oob_err_19: 
	call void @throw_oob()
	br label %oob_ok_19
 
	oob_ok_19: 
	%_181 = add i32 1, 1
	%_182 = getelementptr i32, i32* %_176, i32 %_181
	store i32 7, i32* %_182
 

	%_183 = getelementptr i8, i8* %this, i32 8
	%_184 = bitcast i8* %_183 to i32** 
	%_185 = load i32*, i32** %_184
	%_186 = load i32, i32* %_185
	%_187 = icmp sge i32 2, 0
	%_188 = icmp slt i32 2, %_186
	%_189 = and i1 %_187, %_188
	br i1 %_189, label %oob_ok_20, label %oob_err_20
 
	oob_err_20: 
	call void @throw_oob()
	br label %oob_ok_20
 
	oob_ok_20: 
	%_190 = add i32 1, 2
	%_191 = getelementptr i32, i32* %_185, i32 %_190
	store i32 12, i32* %_191
 

	%_192 = getelementptr i8, i8* %this, i32 8
	%_193 = bitcast i8* %_192 to i32** 
	%_194 = load i32*, i32** %_193
	%_195 = load i32, i32* %_194
	%_196 = icmp sge i32 3, 0
	%_197 = icmp slt i32 3, %_195
	%_198 = and i1 %_196, %_197
	br i1 %_198, label %oob_ok_21, label %oob_err_21
 
	oob_err_21: 
	call void @throw_oob()
	br label %oob_ok_21
 
	oob_ok_21: 
	%_199 = add i32 1, 3
	%_200 = getelementptr i32, i32* %_194, i32 %_199
	store i32 18, i32* %_200
 

	%_201 = getelementptr i8, i8* %this, i32 8
	%_202 = bitcast i8* %_201 to i32** 
	%_203 = load i32*, i32** %_202
	%_204 = load i32, i32* %_203
	%_205 = icmp sge i32 4, 0
	%_206 = icmp slt i32 4, %_204
	%_207 = and i1 %_205, %_206
	br i1 %_207, label %oob_ok_22, label %oob_err_22
 
	oob_err_22: 
	call void @throw_oob()
	br label %oob_ok_22
 
	oob_ok_22: 
	%_208 = add i32 1, 4
	%_209 = getelementptr i32, i32* %_203, i32 %_208
	store i32 2, i32* %_209
 

	%_210 = getelementptr i8, i8* %this, i32 8
	%_211 = bitcast i8* %_210 to i32** 
	%_212 = load i32*, i32** %_211
	%_213 = load i32, i32* %_212
	%_214 = icmp sge i32 5, 0
	%_215 = icmp slt i32 5, %_213
	%_216 = and i1 %_214, %_215
	br i1 %_216, label %oob_ok_23, label %oob_err_23
 
	oob_err_23: 
	call void @throw_oob()
	br label %oob_ok_23
 
	oob_ok_23: 
	%_217 = add i32 1, 5
	%_218 = getelementptr i32, i32* %_212, i32 %_217
	store i32 11, i32* %_218
 

	%_219 = getelementptr i8, i8* %this, i32 8
	%_220 = bitcast i8* %_219 to i32** 
	%_221 = load i32*, i32** %_220
	%_222 = load i32, i32* %_221
	%_223 = icmp sge i32 6, 0
	%_224 = icmp slt i32 6, %_222
	%_225 = and i1 %_223, %_224
	br i1 %_225, label %oob_ok_24, label %oob_err_24
 
	oob_err_24: 
	call void @throw_oob()
	br label %oob_ok_24
 
	oob_ok_24: 
	%_226 = add i32 1, 6
	%_227 = getelementptr i32, i32* %_221, i32 %_226
	store i32 6, i32* %_227
 

	%_228 = getelementptr i8, i8* %this, i32 8
	%_229 = bitcast i8* %_228 to i32** 
	%_230 = load i32*, i32** %_229
	%_231 = load i32, i32* %_230
	%_232 = icmp sge i32 7, 0
	%_233 = icmp slt i32 7, %_231
	%_234 = and i1 %_232, %_233
	br i1 %_234, label %oob_ok_25, label %oob_err_25
 
	oob_err_25: 
	call void @throw_oob()
	br label %oob_ok_25
 
	oob_ok_25: 
	%_235 = add i32 1, 7
	%_236 = getelementptr i32, i32* %_230, i32 %_235
	store i32 9, i32* %_236
 

	%_237 = getelementptr i8, i8* %this, i32 8
	%_238 = bitcast i8* %_237 to i32** 
	%_239 = load i32*, i32** %_238
	%_240 = load i32, i32* %_239
	%_241 = icmp sge i32 8, 0
	%_242 = icmp slt i32 8, %_240
	%_243 = and i1 %_241, %_242
	br i1 %_243, label %oob_ok_26, label %oob_err_26
 
	oob_err_26: 
	call void @throw_oob()
	br label %oob_ok_26
 
	oob_ok_26: 
	%_244 = add i32 1, 8
	%_245 = getelementptr i32, i32* %_239, i32 %_244
	store i32 19, i32* %_245
 

	%_246 = getelementptr i8, i8* %this, i32 8
	%_247 = bitcast i8* %_246 to i32** 
	%_248 = load i32*, i32** %_247
	%_249 = load i32, i32* %_248
	%_250 = icmp sge i32 9, 0
	%_251 = icmp slt i32 9, %_249
	%_252 = and i1 %_250, %_251
	br i1 %_252, label %oob_ok_27, label %oob_err_27
 
	oob_err_27: 
	call void @throw_oob()
	br label %oob_ok_27
 
	oob_ok_27: 
	%_253 = add i32 1, 9
	%_254 = getelementptr i32, i32* %_248, i32 %_253
	store i32 5, i32* %_254
 

	ret i32 0
}
 
