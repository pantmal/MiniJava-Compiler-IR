@.BinaryTree_vtable = global [0 x i8*] [] 
 
@.BT_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @BT.Start to i8*)
]
 
@.Tree_vtable = global [ 20 x i8*] [  
	i8* bitcast (i1 (i8*,i32)* @Tree.Init to i8*),
	i8* bitcast (i1 (i8*,i8*)* @Tree.SetRight to i8*),
	i8* bitcast (i1 (i8*,i8*)* @Tree.SetLeft to i8*),
	i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*),
	i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*),
	i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*),
	i8* bitcast (i1 (i8*,i32)* @Tree.SetKey to i8*),
	i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*),
	i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*),
	i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Left to i8*),
	i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Right to i8*),
	i8* bitcast (i1 (i8*,i32,i32)* @Tree.Compare to i8*),
	i8* bitcast (i1 (i8*,i32)* @Tree.Insert to i8*),
	i8* bitcast (i1 (i8*,i32)* @Tree.Delete to i8*),
	i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.Remove to i8*),
	i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveRight to i8*),
	i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveLeft to i8*),
	i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*),
	i8* bitcast (i1 (i8*)* @Tree.Print to i8*),
	i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	%_6 = bitcast i8* %_0 to i8*** 
	%_7 = load i8**, i8*** %_6 
	%_8 = getelementptr i8*, i8** %_7, i32 0 
	%_9 = load i8*, i8** %_8 
	%_10 = bitcast i8* %_9 to i32 (i8* )* 
	%_11 = call i32 %_10( i8* %_0) 

	call void (i32) @print_int(i32 %_11)

	ret i32 0
}
 
define i32 @BT.Start(i8* %this) {
	%root = alloca i8*
	%ntb = alloca i1
	%nti = alloca i32
	%_12 = call i8* @calloc(i32 1, i32 38)
	%_13 = bitcast i8* %_12 to i8*** 
	%_14 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0 
	store i8** %_14, i8*** %_13

	store i8* %_12,i8** %root

	%_15 = load i8*, i8** %root
	%_19 = bitcast i8* %_15 to i8*** 
	%_20 = load i8**, i8*** %_19 
	%_21 = getelementptr i8*, i8** %_20, i32 0 
	%_22 = load i8*, i8** %_21 
	%_23 = bitcast i8* %_22 to i1 (i8* , i32)* 
	%_24 = call i1 %_23( i8* %_15, i32 16) 

	store i1 %_24,i1* %ntb

	%_25 = load i8*, i8** %root
	%_29 = bitcast i8* %_25 to i8*** 
	%_30 = load i8**, i8*** %_29 
	%_31 = getelementptr i8*, i8** %_30, i32 18 
	%_32 = load i8*, i8** %_31 
	%_33 = bitcast i8* %_32 to i1 (i8* )* 
	%_34 = call i1 %_33( i8* %_25) 

	store i1 %_34,i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_35 = load i8*, i8** %root
	%_39 = bitcast i8* %_35 to i8*** 
	%_40 = load i8**, i8*** %_39 
	%_41 = getelementptr i8*, i8** %_40, i32 12 
	%_42 = load i8*, i8** %_41 
	%_43 = bitcast i8* %_42 to i1 (i8* , i32)* 
	%_44 = call i1 %_43( i8* %_35, i32 8) 

	store i1 %_44,i1* %ntb

	%_45 = load i8*, i8** %root
	%_49 = bitcast i8* %_45 to i8*** 
	%_50 = load i8**, i8*** %_49 
	%_51 = getelementptr i8*, i8** %_50, i32 18 
	%_52 = load i8*, i8** %_51 
	%_53 = bitcast i8* %_52 to i1 (i8* )* 
	%_54 = call i1 %_53( i8* %_45) 

	store i1 %_54,i1* %ntb

	%_55 = load i8*, i8** %root
	%_59 = bitcast i8* %_55 to i8*** 
	%_60 = load i8**, i8*** %_59 
	%_61 = getelementptr i8*, i8** %_60, i32 12 
	%_62 = load i8*, i8** %_61 
	%_63 = bitcast i8* %_62 to i1 (i8* , i32)* 
	%_64 = call i1 %_63( i8* %_55, i32 24) 

	store i1 %_64,i1* %ntb

	%_65 = load i8*, i8** %root
	%_69 = bitcast i8* %_65 to i8*** 
	%_70 = load i8**, i8*** %_69 
	%_71 = getelementptr i8*, i8** %_70, i32 12 
	%_72 = load i8*, i8** %_71 
	%_73 = bitcast i8* %_72 to i1 (i8* , i32)* 
	%_74 = call i1 %_73( i8* %_65, i32 4) 

	store i1 %_74,i1* %ntb

	%_75 = load i8*, i8** %root
	%_79 = bitcast i8* %_75 to i8*** 
	%_80 = load i8**, i8*** %_79 
	%_81 = getelementptr i8*, i8** %_80, i32 12 
	%_82 = load i8*, i8** %_81 
	%_83 = bitcast i8* %_82 to i1 (i8* , i32)* 
	%_84 = call i1 %_83( i8* %_75, i32 12) 

	store i1 %_84,i1* %ntb

	%_85 = load i8*, i8** %root
	%_89 = bitcast i8* %_85 to i8*** 
	%_90 = load i8**, i8*** %_89 
	%_91 = getelementptr i8*, i8** %_90, i32 12 
	%_92 = load i8*, i8** %_91 
	%_93 = bitcast i8* %_92 to i1 (i8* , i32)* 
	%_94 = call i1 %_93( i8* %_85, i32 20) 

	store i1 %_94,i1* %ntb

	%_95 = load i8*, i8** %root
	%_99 = bitcast i8* %_95 to i8*** 
	%_100 = load i8**, i8*** %_99 
	%_101 = getelementptr i8*, i8** %_100, i32 12 
	%_102 = load i8*, i8** %_101 
	%_103 = bitcast i8* %_102 to i1 (i8* , i32)* 
	%_104 = call i1 %_103( i8* %_95, i32 28) 

	store i1 %_104,i1* %ntb

	%_105 = load i8*, i8** %root
	%_109 = bitcast i8* %_105 to i8*** 
	%_110 = load i8**, i8*** %_109 
	%_111 = getelementptr i8*, i8** %_110, i32 12 
	%_112 = load i8*, i8** %_111 
	%_113 = bitcast i8* %_112 to i1 (i8* , i32)* 
	%_114 = call i1 %_113( i8* %_105, i32 14) 

	store i1 %_114,i1* %ntb

	%_115 = load i8*, i8** %root
	%_119 = bitcast i8* %_115 to i8*** 
	%_120 = load i8**, i8*** %_119 
	%_121 = getelementptr i8*, i8** %_120, i32 18 
	%_122 = load i8*, i8** %_121 
	%_123 = bitcast i8* %_122 to i1 (i8* )* 
	%_124 = call i1 %_123( i8* %_115) 

	store i1 %_124,i1* %ntb

	%_125 = load i8*, i8** %root
	%_129 = bitcast i8* %_125 to i8*** 
	%_130 = load i8**, i8*** %_129 
	%_131 = getelementptr i8*, i8** %_130, i32 17 
	%_132 = load i8*, i8** %_131 
	%_133 = bitcast i8* %_132 to i32 (i8* , i32)* 
	%_134 = call i32 %_133( i8* %_125, i32 24) 

	call void (i32) @print_int(i32 %_134)

	%_135 = load i8*, i8** %root
	%_139 = bitcast i8* %_135 to i8*** 
	%_140 = load i8**, i8*** %_139 
	%_141 = getelementptr i8*, i8** %_140, i32 17 
	%_142 = load i8*, i8** %_141 
	%_143 = bitcast i8* %_142 to i32 (i8* , i32)* 
	%_144 = call i32 %_143( i8* %_135, i32 12) 

	call void (i32) @print_int(i32 %_144)

	%_145 = load i8*, i8** %root
	%_149 = bitcast i8* %_145 to i8*** 
	%_150 = load i8**, i8*** %_149 
	%_151 = getelementptr i8*, i8** %_150, i32 17 
	%_152 = load i8*, i8** %_151 
	%_153 = bitcast i8* %_152 to i32 (i8* , i32)* 
	%_154 = call i32 %_153( i8* %_145, i32 16) 

	call void (i32) @print_int(i32 %_154)

	%_155 = load i8*, i8** %root
	%_159 = bitcast i8* %_155 to i8*** 
	%_160 = load i8**, i8*** %_159 
	%_161 = getelementptr i8*, i8** %_160, i32 17 
	%_162 = load i8*, i8** %_161 
	%_163 = bitcast i8* %_162 to i32 (i8* , i32)* 
	%_164 = call i32 %_163( i8* %_155, i32 50) 

	call void (i32) @print_int(i32 %_164)

	%_165 = load i8*, i8** %root
	%_169 = bitcast i8* %_165 to i8*** 
	%_170 = load i8**, i8*** %_169 
	%_171 = getelementptr i8*, i8** %_170, i32 17 
	%_172 = load i8*, i8** %_171 
	%_173 = bitcast i8* %_172 to i32 (i8* , i32)* 
	%_174 = call i32 %_173( i8* %_165, i32 12) 

	call void (i32) @print_int(i32 %_174)

	%_175 = load i8*, i8** %root
	%_179 = bitcast i8* %_175 to i8*** 
	%_180 = load i8**, i8*** %_179 
	%_181 = getelementptr i8*, i8** %_180, i32 13 
	%_182 = load i8*, i8** %_181 
	%_183 = bitcast i8* %_182 to i1 (i8* , i32)* 
	%_184 = call i1 %_183( i8* %_175, i32 12) 

	store i1 %_184,i1* %ntb

	%_185 = load i8*, i8** %root
	%_189 = bitcast i8* %_185 to i8*** 
	%_190 = load i8**, i8*** %_189 
	%_191 = getelementptr i8*, i8** %_190, i32 18 
	%_192 = load i8*, i8** %_191 
	%_193 = bitcast i8* %_192 to i1 (i8* )* 
	%_194 = call i1 %_193( i8* %_185) 

	store i1 %_194,i1* %ntb

	%_195 = load i8*, i8** %root
	%_199 = bitcast i8* %_195 to i8*** 
	%_200 = load i8**, i8*** %_199 
	%_201 = getelementptr i8*, i8** %_200, i32 17 
	%_202 = load i8*, i8** %_201 
	%_203 = bitcast i8* %_202 to i32 (i8* , i32)* 
	%_204 = call i32 %_203( i8* %_195, i32 12) 

	call void (i32) @print_int(i32 %_204)

	ret i32 0
}
 
define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_205 = getelementptr i8, i8* %this, i32 24
	%_206 = bitcast i8* %_205 to i32* 
	%_207 = load i32, i32* %v_key
	store i32 %_207,i32* %_206

	%_208 = getelementptr i8, i8* %this, i32 28
	%_209 = bitcast i8* %_208 to i1* 
	store i1 0,i1* %_209

	%_210 = getelementptr i8, i8* %this, i32 29
	%_211 = bitcast i8* %_210 to i1* 
	store i1 0,i1* %_211

	ret i1 1
}
 
define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_212 = getelementptr i8, i8* %this, i32 16
	%_213 = bitcast i8* %_212 to i8** 
	%_214 = load i8*, i8** %rn
	store i8* %_214,i8** %_213

	ret i1 1
}
 
define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_215 = getelementptr i8, i8* %this, i32 8
	%_216 = bitcast i8* %_215 to i8** 
	%_217 = load i8*, i8** %ln
	store i8* %_217,i8** %_216

	ret i1 1
}
 
define i8* @Tree.GetRight(i8* %this) {
	%_218 = getelementptr i8, i8* %this, i32 16
	%_219 = bitcast i8* %_218 to i8** 
	%_220 = load i8*, i8** %_219
	ret i8* %_220
}
 
define i8* @Tree.GetLeft(i8* %this) {
	%_221 = getelementptr i8, i8* %this, i32 8
	%_222 = bitcast i8* %_221 to i8** 
	%_223 = load i8*, i8** %_222
	ret i8* %_223
}
 
define i32 @Tree.GetKey(i8* %this) {
	%_224 = getelementptr i8, i8* %this, i32 24
	%_225 = bitcast i8* %_224 to i32* 
	%_226 = load i32, i32* %_225
	ret i32 %_226
}
 
define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_227 = getelementptr i8, i8* %this, i32 24
	%_228 = bitcast i8* %_227 to i32* 
	%_229 = load i32, i32* %v_key
	store i32 %_229,i32* %_228

	ret i1 1
}
 
define i1 @Tree.GetHas_Right(i8* %this) {
	%_230 = getelementptr i8, i8* %this, i32 29
	%_231 = bitcast i8* %_230 to i1* 
	%_232 = load i1, i1* %_231
	ret i1 %_232
}
 
define i1 @Tree.GetHas_Left(i8* %this) {
	%_233 = getelementptr i8, i8* %this, i32 28
	%_234 = bitcast i8* %_233 to i1* 
	%_235 = load i1, i1* %_234
	ret i1 %_235
}
 
define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_236 = getelementptr i8, i8* %this, i32 28
	%_237 = bitcast i8* %_236 to i1* 
	%_238 = load i1, i1* %val
	store i1 %_238,i1* %_237

	ret i1 1
}
 
define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_239 = getelementptr i8, i8* %this, i32 29
	%_240 = bitcast i8* %_239 to i1* 
	%_241 = load i1, i1* %val
	store i1 %_241,i1* %_240

	ret i1 1
}
 
define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1
	%nti = alloca i32
	store i1 0,i1* %ntb

	%_242 = load i32, i32* %num2
	%_243 = add i32 %_242, 1

	store i32 %_243,i32* %nti

	%_244 = load i32, i32* %num1
	%_245 = load i32, i32* %num2
	%_246 = icmp slt i32 %_244, %_245

	br i1 %_246, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_247 = load i32, i32* %num1
	%_248 = load i32, i32* %nti
	%_249 = icmp slt i32 %_247, %_248

	%_250 = xor i1 1, %_249

	br i1 %_250, label %if_then_1, label %if_else_1 
	if_else_1: 
	store i1 1,i1* %ntb

	br label %if_end_1
	if_then_1: 
	store i1 0,i1* %ntb

	br label %if_end_1
	if_end_1: 

	br label %if_end_0
	if_then_0: 
	store i1 0,i1* %ntb

	br label %if_end_0
	if_end_0: 

	%_251 = load i1, i1* %ntb
	ret i1 %_251
}
 
define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca i8*
	%_252 = call i8* @calloc(i32 1, i32 38)
	%_253 = bitcast i8* %_252 to i8*** 
	%_254 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0 
	store i8** %_254, i8*** %_253

	store i8* %_252,i8** %new_node

	%_255 = load i8*, i8** %new_node
	%_259 = bitcast i8* %_255 to i8*** 
	%_260 = load i8**, i8*** %_259 
	%_261 = getelementptr i8*, i8** %_260, i32 0 
	%_262 = load i8*, i8** %_261 
	%_263 = bitcast i8* %_262 to i1 (i8* , i32)* 
	%_264 = load i32, i32* %v_key
	%_265 = call i1 %_263( i8* %_255, i32 %_264) 

	store i1 %_265,i1* %ntb

	store i8* %this,i8** %current_node

	store i1 1,i1* %cont

	br label %loop2
	loop2: 
	%_266 = load i1, i1* %cont
	br i1 %_266, label %loop3, label %loop4 
	loop3: 
	%_267 = load i8*, i8** %current_node
	%_271 = bitcast i8* %_267 to i8*** 
	%_272 = load i8**, i8*** %_271 
	%_273 = getelementptr i8*, i8** %_272, i32 5 
	%_274 = load i8*, i8** %_273 
	%_275 = bitcast i8* %_274 to i32 (i8* )* 
	%_276 = call i32 %_275( i8* %_267) 

	store i32 %_276,i32* %key_aux

	%_277 = load i32, i32* %v_key
	%_278 = load i32, i32* %key_aux
	%_279 = icmp slt i32 %_277, %_278

	br i1 %_279, label %if_then_5, label %if_else_5 
	if_else_5: 
	%_280 = load i8*, i8** %current_node
	%_284 = bitcast i8* %_280 to i8*** 
	%_285 = load i8**, i8*** %_284 
	%_286 = getelementptr i8*, i8** %_285, i32 7 
	%_287 = load i8*, i8** %_286 
	%_288 = bitcast i8* %_287 to i1 (i8* )* 
	%_289 = call i1 %_288( i8* %_280) 

	br i1 %_289, label %if_then_6, label %if_else_6 
	if_else_6: 
	store i1 0,i1* %cont

	%_290 = load i8*, i8** %current_node
	%_294 = bitcast i8* %_290 to i8*** 
	%_295 = load i8**, i8*** %_294 
	%_296 = getelementptr i8*, i8** %_295, i32 10 
	%_297 = load i8*, i8** %_296 
	%_298 = bitcast i8* %_297 to i1 (i8* , i1)* 
	%_299 = call i1 %_298( i8* %_290, i1 1) 

	store i1 %_299,i1* %ntb

	%_300 = load i8*, i8** %current_node
	%_304 = bitcast i8* %_300 to i8*** 
	%_305 = load i8**, i8*** %_304 
	%_306 = getelementptr i8*, i8** %_305, i32 1 
	%_307 = load i8*, i8** %_306 
	%_308 = bitcast i8* %_307 to i1 (i8* , i8*)* 
	%_309 = load i8*, i8** %new_node
	%_310 = call i1 %_308( i8* %_300, i8* %_309) 

	store i1 %_310,i1* %ntb

	br label %if_end_6
	if_then_6: 
	%_311 = load i8*, i8** %current_node
	%_315 = bitcast i8* %_311 to i8*** 
	%_316 = load i8**, i8*** %_315 
	%_317 = getelementptr i8*, i8** %_316, i32 3 
	%_318 = load i8*, i8** %_317 
	%_319 = bitcast i8* %_318 to i8* (i8* )* 
	%_320 = call i8* %_319( i8* %_311) 

	store i8* %_320,i8** %current_node

	br label %if_end_6
	if_end_6: 

	br label %if_end_5
	if_then_5: 
	%_321 = load i8*, i8** %current_node
	%_325 = bitcast i8* %_321 to i8*** 
	%_326 = load i8**, i8*** %_325 
	%_327 = getelementptr i8*, i8** %_326, i32 8 
	%_328 = load i8*, i8** %_327 
	%_329 = bitcast i8* %_328 to i1 (i8* )* 
	%_330 = call i1 %_329( i8* %_321) 

	br i1 %_330, label %if_then_7, label %if_else_7 
	if_else_7: 
	store i1 0,i1* %cont

	%_331 = load i8*, i8** %current_node
	%_335 = bitcast i8* %_331 to i8*** 
	%_336 = load i8**, i8*** %_335 
	%_337 = getelementptr i8*, i8** %_336, i32 9 
	%_338 = load i8*, i8** %_337 
	%_339 = bitcast i8* %_338 to i1 (i8* , i1)* 
	%_340 = call i1 %_339( i8* %_331, i1 1) 

	store i1 %_340,i1* %ntb

	%_341 = load i8*, i8** %current_node
	%_345 = bitcast i8* %_341 to i8*** 
	%_346 = load i8**, i8*** %_345 
	%_347 = getelementptr i8*, i8** %_346, i32 2 
	%_348 = load i8*, i8** %_347 
	%_349 = bitcast i8* %_348 to i1 (i8* , i8*)* 
	%_350 = load i8*, i8** %new_node
	%_351 = call i1 %_349( i8* %_341, i8* %_350) 

	store i1 %_351,i1* %ntb

	br label %if_end_7
	if_then_7: 
	%_352 = load i8*, i8** %current_node
	%_356 = bitcast i8* %_352 to i8*** 
	%_357 = load i8**, i8*** %_356 
	%_358 = getelementptr i8*, i8** %_357, i32 4 
	%_359 = load i8*, i8** %_358 
	%_360 = bitcast i8* %_359 to i8* (i8* )* 
	%_361 = call i8* %_360( i8* %_352) 

	store i8* %_361,i8** %current_node

	br label %if_end_7
	if_end_7: 

	br label %if_end_5
	if_end_5: 

	br label %loop2
	loop4: 

	ret i1 1
}
 
define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*
	%parent_node = alloca i8*
	%cont = alloca i1
	%found = alloca i1
	%is_root = alloca i1
	%key_aux = alloca i32
	%ntb = alloca i1
	store i8* %this,i8** %current_node

	store i8* %this,i8** %parent_node

	store i1 1,i1* %cont

	store i1 0,i1* %found

	store i1 1,i1* %is_root

	br label %loop8
	loop8: 
	%_362 = load i1, i1* %cont
	br i1 %_362, label %loop9, label %loop10 
	loop9: 
	%_363 = load i8*, i8** %current_node
	%_367 = bitcast i8* %_363 to i8*** 
	%_368 = load i8**, i8*** %_367 
	%_369 = getelementptr i8*, i8** %_368, i32 5 
	%_370 = load i8*, i8** %_369 
	%_371 = bitcast i8* %_370 to i32 (i8* )* 
	%_372 = call i32 %_371( i8* %_363) 

	store i32 %_372,i32* %key_aux

	%_373 = load i32, i32* %v_key
	%_374 = load i32, i32* %key_aux
	%_375 = icmp slt i32 %_373, %_374

	br i1 %_375, label %if_then_11, label %if_else_11 
	if_else_11: 
	%_376 = load i32, i32* %key_aux
	%_377 = load i32, i32* %v_key
	%_378 = icmp slt i32 %_376, %_377

	br i1 %_378, label %if_then_12, label %if_else_12 
	if_else_12: 
	%_379 = load i1, i1* %is_root
	br i1 %_379, label %if_then_13, label %if_else_13 
	if_else_13: 
	%_383 = bitcast i8* %this to i8*** 
	%_384 = load i8**, i8*** %_383 
	%_385 = getelementptr i8*, i8** %_384, i32 14 
	%_386 = load i8*, i8** %_385 
	%_387 = bitcast i8* %_386 to i1 (i8* , i8*, i8*)* 
	%_388 = load i8*, i8** %parent_node
	%_389 = load i8*, i8** %current_node
	%_390 = call i1 %_387( i8* %this, i8* %_388, i8* %_389) 

	store i1 %_390,i1* %ntb

	br label %if_end_13
	if_then_13: 
	%_391 = load i8*, i8** %current_node
	%_395 = bitcast i8* %_391 to i8*** 
	%_396 = load i8**, i8*** %_395 
	%_397 = getelementptr i8*, i8** %_396, i32 7 
	%_398 = load i8*, i8** %_397 
	%_399 = bitcast i8* %_398 to i1 (i8* )* 
	%_400 = call i1 %_399( i8* %_391) 

	%_401 = xor i1 1, %_400

	br i1 %_401, label %and_clause16, label %and_clause15 
	and_clause15: 
	br label %and_clause17
	and_clause16: 
	%_402 = load i8*, i8** %current_node
	%_406 = bitcast i8* %_402 to i8*** 
	%_407 = load i8**, i8*** %_406 
	%_408 = getelementptr i8*, i8** %_407, i32 8 
	%_409 = load i8*, i8** %_408 
	%_410 = bitcast i8* %_409 to i1 (i8* )* 
	%_411 = call i1 %_410( i8* %_402) 

	%_412 = xor i1 1, %_411

	br label %and_clause17
	and_clause17: 
	br label %and_clause18
	and_clause18: 
	%_413 = phi i1 [ 0, %and_clause15 ], [ %_412, %and_clause17] 

	br i1 %_413, label %if_then_14, label %if_else_14 
	if_else_14: 
	%_417 = bitcast i8* %this to i8*** 
	%_418 = load i8**, i8*** %_417 
	%_419 = getelementptr i8*, i8** %_418, i32 14 
	%_420 = load i8*, i8** %_419 
	%_421 = bitcast i8* %_420 to i1 (i8* , i8*, i8*)* 
	%_422 = load i8*, i8** %parent_node
	%_423 = load i8*, i8** %current_node
	%_424 = call i1 %_421( i8* %this, i8* %_422, i8* %_423) 

	store i1 %_424,i1* %ntb

	br label %if_end_14
	if_then_14: 
	store i1 1,i1* %ntb

	br label %if_end_14
	if_end_14: 

	br label %if_end_13
	if_end_13: 

	store i1 1,i1* %found

	store i1 0,i1* %cont

	br label %if_end_12
	if_then_12: 
	%_425 = load i8*, i8** %current_node
	%_429 = bitcast i8* %_425 to i8*** 
	%_430 = load i8**, i8*** %_429 
	%_431 = getelementptr i8*, i8** %_430, i32 7 
	%_432 = load i8*, i8** %_431 
	%_433 = bitcast i8* %_432 to i1 (i8* )* 
	%_434 = call i1 %_433( i8* %_425) 

	br i1 %_434, label %if_then_19, label %if_else_19 
	if_else_19: 
	store i1 0,i1* %cont

	br label %if_end_19
	if_then_19: 
	%_435 = load i8*, i8** %current_node
	store i8* %_435,i8** %parent_node

	%_436 = load i8*, i8** %current_node
	%_440 = bitcast i8* %_436 to i8*** 
	%_441 = load i8**, i8*** %_440 
	%_442 = getelementptr i8*, i8** %_441, i32 3 
	%_443 = load i8*, i8** %_442 
	%_444 = bitcast i8* %_443 to i8* (i8* )* 
	%_445 = call i8* %_444( i8* %_436) 

	store i8* %_445,i8** %current_node

	br label %if_end_19
	if_end_19: 

	br label %if_end_12
	if_end_12: 

	br label %if_end_11
	if_then_11: 
	%_446 = load i8*, i8** %current_node
	%_450 = bitcast i8* %_446 to i8*** 
	%_451 = load i8**, i8*** %_450 
	%_452 = getelementptr i8*, i8** %_451, i32 8 
	%_453 = load i8*, i8** %_452 
	%_454 = bitcast i8* %_453 to i1 (i8* )* 
	%_455 = call i1 %_454( i8* %_446) 

	br i1 %_455, label %if_then_20, label %if_else_20 
	if_else_20: 
	store i1 0,i1* %cont

	br label %if_end_20
	if_then_20: 
	%_456 = load i8*, i8** %current_node
	store i8* %_456,i8** %parent_node

	%_457 = load i8*, i8** %current_node
	%_461 = bitcast i8* %_457 to i8*** 
	%_462 = load i8**, i8*** %_461 
	%_463 = getelementptr i8*, i8** %_462, i32 4 
	%_464 = load i8*, i8** %_463 
	%_465 = bitcast i8* %_464 to i8* (i8* )* 
	%_466 = call i8* %_465( i8* %_457) 

	store i8* %_466,i8** %current_node

	br label %if_end_20
	if_end_20: 

	br label %if_end_11
	if_end_11: 

	store i1 0,i1* %is_root

	br label %loop8
	loop10: 

	%_467 = load i1, i1* %found
	ret i1 %_467
}
 
define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
	%_468 = load i8*, i8** %c_node
	%_472 = bitcast i8* %_468 to i8*** 
	%_473 = load i8**, i8*** %_472 
	%_474 = getelementptr i8*, i8** %_473, i32 8 
	%_475 = load i8*, i8** %_474 
	%_476 = bitcast i8* %_475 to i1 (i8* )* 
	%_477 = call i1 %_476( i8* %_468) 

	br i1 %_477, label %if_then_21, label %if_else_21 
	if_else_21: 
	%_478 = load i8*, i8** %c_node
	%_482 = bitcast i8* %_478 to i8*** 
	%_483 = load i8**, i8*** %_482 
	%_484 = getelementptr i8*, i8** %_483, i32 7 
	%_485 = load i8*, i8** %_484 
	%_486 = bitcast i8* %_485 to i1 (i8* )* 
	%_487 = call i1 %_486( i8* %_478) 

	br i1 %_487, label %if_then_22, label %if_else_22 
	if_else_22: 
	%_488 = load i8*, i8** %c_node
	%_492 = bitcast i8* %_488 to i8*** 
	%_493 = load i8**, i8*** %_492 
	%_494 = getelementptr i8*, i8** %_493, i32 5 
	%_495 = load i8*, i8** %_494 
	%_496 = bitcast i8* %_495 to i32 (i8* )* 
	%_497 = call i32 %_496( i8* %_488) 

	store i32 %_497,i32* %auxkey1

	%_498 = load i8*, i8** %p_node
	%_502 = bitcast i8* %_498 to i8*** 
	%_503 = load i8**, i8*** %_502 
	%_504 = getelementptr i8*, i8** %_503, i32 4 
	%_505 = load i8*, i8** %_504 
	%_506 = bitcast i8* %_505 to i8* (i8* )* 
	%_507 = call i8* %_506( i8* %_498) 

	%_508 = load i8*, i8** %p_node
	%_512 = bitcast i8* %_508 to i8*** 
	%_513 = load i8**, i8*** %_512 
	%_514 = getelementptr i8*, i8** %_513, i32 4 
	%_515 = load i8*, i8** %_514 
	%_516 = bitcast i8* %_515 to i8* (i8* )* 
	%_517 = call i8* %_516( i8* %_508) 

	%_521 = bitcast i8* %_517 to i8*** 
	%_522 = load i8**, i8*** %_521 
	%_523 = getelementptr i8*, i8** %_522, i32 5 
	%_524 = load i8*, i8** %_523 
	%_525 = bitcast i8* %_524 to i32 (i8* )* 
	%_526 = call i32 %_525( i8* %_517) 

	store i32 %_526,i32* %auxkey2

	%_530 = bitcast i8* %this to i8*** 
	%_531 = load i8**, i8*** %_530 
	%_532 = getelementptr i8*, i8** %_531, i32 11 
	%_533 = load i8*, i8** %_532 
	%_534 = bitcast i8* %_533 to i1 (i8* , i32, i32)* 
	%_535 = load i32, i32* %auxkey1
	%_536 = load i32, i32* %auxkey2
	%_537 = call i1 %_534( i8* %this, i32 %_535, i32 %_536) 

	br i1 %_537, label %if_then_23, label %if_else_23 
	if_else_23: 
	%_538 = load i8*, i8** %p_node
	%_542 = bitcast i8* %_538 to i8*** 
	%_543 = load i8**, i8*** %_542 
	%_544 = getelementptr i8*, i8** %_543, i32 1 
	%_545 = load i8*, i8** %_544 
	%_546 = bitcast i8* %_545 to i1 (i8* , i8*)* 
	%_547 = getelementptr i8, i8* %this, i32 30
	%_548 = bitcast i8* %_547 to i8** 
	%_549 = load i8*, i8** %_548
	%_550 = call i1 %_546( i8* %_538, i8* %_549) 

	store i1 %_550,i1* %ntb

	%_551 = load i8*, i8** %p_node
	%_555 = bitcast i8* %_551 to i8*** 
	%_556 = load i8**, i8*** %_555 
	%_557 = getelementptr i8*, i8** %_556, i32 10 
	%_558 = load i8*, i8** %_557 
	%_559 = bitcast i8* %_558 to i1 (i8* , i1)* 
	%_560 = call i1 %_559( i8* %_551, i1 0) 

	store i1 %_560,i1* %ntb

	br label %if_end_23
	if_then_23: 
	%_561 = load i8*, i8** %p_node
	%_565 = bitcast i8* %_561 to i8*** 
	%_566 = load i8**, i8*** %_565 
	%_567 = getelementptr i8*, i8** %_566, i32 2 
	%_568 = load i8*, i8** %_567 
	%_569 = bitcast i8* %_568 to i1 (i8* , i8*)* 
	%_570 = getelementptr i8, i8* %this, i32 30
	%_571 = bitcast i8* %_570 to i8** 
	%_572 = load i8*, i8** %_571
	%_573 = call i1 %_569( i8* %_561, i8* %_572) 

	store i1 %_573,i1* %ntb

	%_574 = load i8*, i8** %p_node
	%_578 = bitcast i8* %_574 to i8*** 
	%_579 = load i8**, i8*** %_578 
	%_580 = getelementptr i8*, i8** %_579, i32 9 
	%_581 = load i8*, i8** %_580 
	%_582 = bitcast i8* %_581 to i1 (i8* , i1)* 
	%_583 = call i1 %_582( i8* %_574, i1 0) 

	store i1 %_583,i1* %ntb

	br label %if_end_23
	if_end_23: 

	br label %if_end_22
	if_then_22: 
	%_587 = bitcast i8* %this to i8*** 
	%_588 = load i8**, i8*** %_587 
	%_589 = getelementptr i8*, i8** %_588, i32 15 
	%_590 = load i8*, i8** %_589 
	%_591 = bitcast i8* %_590 to i1 (i8* , i8*, i8*)* 
	%_592 = load i8*, i8** %p_node
	%_593 = load i8*, i8** %c_node
	%_594 = call i1 %_591( i8* %this, i8* %_592, i8* %_593) 

	store i1 %_594,i1* %ntb

	br label %if_end_22
	if_end_22: 

	br label %if_end_21
	if_then_21: 
	%_598 = bitcast i8* %this to i8*** 
	%_599 = load i8**, i8*** %_598 
	%_600 = getelementptr i8*, i8** %_599, i32 16 
	%_601 = load i8*, i8** %_600 
	%_602 = bitcast i8* %_601 to i1 (i8* , i8*, i8*)* 
	%_603 = load i8*, i8** %p_node
	%_604 = load i8*, i8** %c_node
	%_605 = call i1 %_602( i8* %this, i8* %_603, i8* %_604) 

	store i1 %_605,i1* %ntb

	br label %if_end_21
	if_end_21: 

	ret i1 1
}
 
define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	br label %loop24
	loop24: 
	%_606 = load i8*, i8** %c_node
	%_610 = bitcast i8* %_606 to i8*** 
	%_611 = load i8**, i8*** %_610 
	%_612 = getelementptr i8*, i8** %_611, i32 7 
	%_613 = load i8*, i8** %_612 
	%_614 = bitcast i8* %_613 to i1 (i8* )* 
	%_615 = call i1 %_614( i8* %_606) 

	br i1 %_615, label %loop25, label %loop26 
	loop25: 
	%_616 = load i8*, i8** %c_node
	%_620 = bitcast i8* %_616 to i8*** 
	%_621 = load i8**, i8*** %_620 
	%_622 = getelementptr i8*, i8** %_621, i32 6 
	%_623 = load i8*, i8** %_622 
	%_624 = bitcast i8* %_623 to i1 (i8* , i32)* 
	%_625 = load i8*, i8** %c_node
	%_629 = bitcast i8* %_625 to i8*** 
	%_630 = load i8**, i8*** %_629 
	%_631 = getelementptr i8*, i8** %_630, i32 3 
	%_632 = load i8*, i8** %_631 
	%_633 = bitcast i8* %_632 to i8* (i8* )* 
	%_634 = call i8* %_633( i8* %_625) 

	%_635 = load i8*, i8** %c_node
	%_639 = bitcast i8* %_635 to i8*** 
	%_640 = load i8**, i8*** %_639 
	%_641 = getelementptr i8*, i8** %_640, i32 3 
	%_642 = load i8*, i8** %_641 
	%_643 = bitcast i8* %_642 to i8* (i8* )* 
	%_644 = call i8* %_643( i8* %_635) 

	%_648 = bitcast i8* %_644 to i8*** 
	%_649 = load i8**, i8*** %_648 
	%_650 = getelementptr i8*, i8** %_649, i32 5 
	%_651 = load i8*, i8** %_650 
	%_652 = bitcast i8* %_651 to i32 (i8* )* 
	%_653 = call i32 %_652( i8* %_644) 

	%_654 = call i1 %_624( i8* %_616, i32 %_653) 

	store i1 %_654,i1* %ntb

	%_655 = load i8*, i8** %c_node
	store i8* %_655,i8** %p_node

	%_656 = load i8*, i8** %c_node
	%_660 = bitcast i8* %_656 to i8*** 
	%_661 = load i8**, i8*** %_660 
	%_662 = getelementptr i8*, i8** %_661, i32 3 
	%_663 = load i8*, i8** %_662 
	%_664 = bitcast i8* %_663 to i8* (i8* )* 
	%_665 = call i8* %_664( i8* %_656) 

	store i8* %_665,i8** %c_node

	br label %loop24
	loop26: 

	%_666 = load i8*, i8** %p_node
	%_670 = bitcast i8* %_666 to i8*** 
	%_671 = load i8**, i8*** %_670 
	%_672 = getelementptr i8*, i8** %_671, i32 1 
	%_673 = load i8*, i8** %_672 
	%_674 = bitcast i8* %_673 to i1 (i8* , i8*)* 
	%_675 = getelementptr i8, i8* %this, i32 30
	%_676 = bitcast i8* %_675 to i8** 
	%_677 = load i8*, i8** %_676
	%_678 = call i1 %_674( i8* %_666, i8* %_677) 

	store i1 %_678,i1* %ntb

	%_679 = load i8*, i8** %p_node
	%_683 = bitcast i8* %_679 to i8*** 
	%_684 = load i8**, i8*** %_683 
	%_685 = getelementptr i8*, i8** %_684, i32 10 
	%_686 = load i8*, i8** %_685 
	%_687 = bitcast i8* %_686 to i1 (i8* , i1)* 
	%_688 = call i1 %_687( i8* %_679, i1 0) 

	store i1 %_688,i1* %ntb

	ret i1 1
}
 
define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	br label %loop27
	loop27: 
	%_689 = load i8*, i8** %c_node
	%_693 = bitcast i8* %_689 to i8*** 
	%_694 = load i8**, i8*** %_693 
	%_695 = getelementptr i8*, i8** %_694, i32 8 
	%_696 = load i8*, i8** %_695 
	%_697 = bitcast i8* %_696 to i1 (i8* )* 
	%_698 = call i1 %_697( i8* %_689) 

	br i1 %_698, label %loop28, label %loop29 
	loop28: 
	%_699 = load i8*, i8** %c_node
	%_703 = bitcast i8* %_699 to i8*** 
	%_704 = load i8**, i8*** %_703 
	%_705 = getelementptr i8*, i8** %_704, i32 6 
	%_706 = load i8*, i8** %_705 
	%_707 = bitcast i8* %_706 to i1 (i8* , i32)* 
	%_708 = load i8*, i8** %c_node
	%_712 = bitcast i8* %_708 to i8*** 
	%_713 = load i8**, i8*** %_712 
	%_714 = getelementptr i8*, i8** %_713, i32 4 
	%_715 = load i8*, i8** %_714 
	%_716 = bitcast i8* %_715 to i8* (i8* )* 
	%_717 = call i8* %_716( i8* %_708) 

	%_718 = load i8*, i8** %c_node
	%_722 = bitcast i8* %_718 to i8*** 
	%_723 = load i8**, i8*** %_722 
	%_724 = getelementptr i8*, i8** %_723, i32 4 
	%_725 = load i8*, i8** %_724 
	%_726 = bitcast i8* %_725 to i8* (i8* )* 
	%_727 = call i8* %_726( i8* %_718) 

	%_731 = bitcast i8* %_727 to i8*** 
	%_732 = load i8**, i8*** %_731 
	%_733 = getelementptr i8*, i8** %_732, i32 5 
	%_734 = load i8*, i8** %_733 
	%_735 = bitcast i8* %_734 to i32 (i8* )* 
	%_736 = call i32 %_735( i8* %_727) 

	%_737 = call i1 %_707( i8* %_699, i32 %_736) 

	store i1 %_737,i1* %ntb

	%_738 = load i8*, i8** %c_node
	store i8* %_738,i8** %p_node

	%_739 = load i8*, i8** %c_node
	%_743 = bitcast i8* %_739 to i8*** 
	%_744 = load i8**, i8*** %_743 
	%_745 = getelementptr i8*, i8** %_744, i32 4 
	%_746 = load i8*, i8** %_745 
	%_747 = bitcast i8* %_746 to i8* (i8* )* 
	%_748 = call i8* %_747( i8* %_739) 

	store i8* %_748,i8** %c_node

	br label %loop27
	loop29: 

	%_749 = load i8*, i8** %p_node
	%_753 = bitcast i8* %_749 to i8*** 
	%_754 = load i8**, i8*** %_753 
	%_755 = getelementptr i8*, i8** %_754, i32 2 
	%_756 = load i8*, i8** %_755 
	%_757 = bitcast i8* %_756 to i1 (i8* , i8*)* 
	%_758 = getelementptr i8, i8* %this, i32 30
	%_759 = bitcast i8* %_758 to i8** 
	%_760 = load i8*, i8** %_759
	%_761 = call i1 %_757( i8* %_749, i8* %_760) 

	store i1 %_761,i1* %ntb

	%_762 = load i8*, i8** %p_node
	%_766 = bitcast i8* %_762 to i8*** 
	%_767 = load i8**, i8*** %_766 
	%_768 = getelementptr i8*, i8** %_767, i32 9 
	%_769 = load i8*, i8** %_768 
	%_770 = bitcast i8* %_769 to i1 (i8* , i1)* 
	%_771 = call i1 %_770( i8* %_762, i1 0) 

	store i1 %_771,i1* %ntb

	ret i1 1
}
 
define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%cont = alloca i1
	%ifound = alloca i32
	%current_node = alloca i8*
	%key_aux = alloca i32
	store i8* %this,i8** %current_node

	store i1 1,i1* %cont

	store i32 0,i32* %ifound

	br label %loop30
	loop30: 
	%_772 = load i1, i1* %cont
	br i1 %_772, label %loop31, label %loop32 
	loop31: 
	%_773 = load i8*, i8** %current_node
	%_777 = bitcast i8* %_773 to i8*** 
	%_778 = load i8**, i8*** %_777 
	%_779 = getelementptr i8*, i8** %_778, i32 5 
	%_780 = load i8*, i8** %_779 
	%_781 = bitcast i8* %_780 to i32 (i8* )* 
	%_782 = call i32 %_781( i8* %_773) 

	store i32 %_782,i32* %key_aux

	%_783 = load i32, i32* %v_key
	%_784 = load i32, i32* %key_aux
	%_785 = icmp slt i32 %_783, %_784

	br i1 %_785, label %if_then_33, label %if_else_33 
	if_else_33: 
	%_786 = load i32, i32* %key_aux
	%_787 = load i32, i32* %v_key
	%_788 = icmp slt i32 %_786, %_787

	br i1 %_788, label %if_then_34, label %if_else_34 
	if_else_34: 
	store i32 1,i32* %ifound

	store i1 0,i1* %cont

	br label %if_end_34
	if_then_34: 
	%_789 = load i8*, i8** %current_node
	%_793 = bitcast i8* %_789 to i8*** 
	%_794 = load i8**, i8*** %_793 
	%_795 = getelementptr i8*, i8** %_794, i32 7 
	%_796 = load i8*, i8** %_795 
	%_797 = bitcast i8* %_796 to i1 (i8* )* 
	%_798 = call i1 %_797( i8* %_789) 

	br i1 %_798, label %if_then_35, label %if_else_35 
	if_else_35: 
	store i1 0,i1* %cont

	br label %if_end_35
	if_then_35: 
	%_799 = load i8*, i8** %current_node
	%_803 = bitcast i8* %_799 to i8*** 
	%_804 = load i8**, i8*** %_803 
	%_805 = getelementptr i8*, i8** %_804, i32 3 
	%_806 = load i8*, i8** %_805 
	%_807 = bitcast i8* %_806 to i8* (i8* )* 
	%_808 = call i8* %_807( i8* %_799) 

	store i8* %_808,i8** %current_node

	br label %if_end_35
	if_end_35: 

	br label %if_end_34
	if_end_34: 

	br label %if_end_33
	if_then_33: 
	%_809 = load i8*, i8** %current_node
	%_813 = bitcast i8* %_809 to i8*** 
	%_814 = load i8**, i8*** %_813 
	%_815 = getelementptr i8*, i8** %_814, i32 8 
	%_816 = load i8*, i8** %_815 
	%_817 = bitcast i8* %_816 to i1 (i8* )* 
	%_818 = call i1 %_817( i8* %_809) 

	br i1 %_818, label %if_then_36, label %if_else_36 
	if_else_36: 
	store i1 0,i1* %cont

	br label %if_end_36
	if_then_36: 
	%_819 = load i8*, i8** %current_node
	%_823 = bitcast i8* %_819 to i8*** 
	%_824 = load i8**, i8*** %_823 
	%_825 = getelementptr i8*, i8** %_824, i32 4 
	%_826 = load i8*, i8** %_825 
	%_827 = bitcast i8* %_826 to i8* (i8* )* 
	%_828 = call i8* %_827( i8* %_819) 

	store i8* %_828,i8** %current_node

	br label %if_end_36
	if_end_36: 

	br label %if_end_33
	if_end_33: 

	br label %loop30
	loop32: 

	%_829 = load i32, i32* %ifound
	ret i32 %_829
}
 
define i1 @Tree.Print(i8* %this) {
	%current_node = alloca i8*
	%ntb = alloca i1
	store i8* %this,i8** %current_node

	%_833 = bitcast i8* %this to i8*** 
	%_834 = load i8**, i8*** %_833 
	%_835 = getelementptr i8*, i8** %_834, i32 19 
	%_836 = load i8*, i8** %_835 
	%_837 = bitcast i8* %_836 to i1 (i8* , i8*)* 
	%_838 = load i8*, i8** %current_node
	%_839 = call i1 %_837( i8* %this, i8* %_838) 

	store i1 %_839,i1* %ntb

	ret i1 1
}
 
define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1
	%_840 = load i8*, i8** %node
	%_844 = bitcast i8* %_840 to i8*** 
	%_845 = load i8**, i8*** %_844 
	%_846 = getelementptr i8*, i8** %_845, i32 8 
	%_847 = load i8*, i8** %_846 
	%_848 = bitcast i8* %_847 to i1 (i8* )* 
	%_849 = call i1 %_848( i8* %_840) 

	br i1 %_849, label %if_then_37, label %if_else_37 
	if_else_37: 
	store i1 1,i1* %ntb

	br label %if_end_37
	if_then_37: 
	%_853 = bitcast i8* %this to i8*** 
	%_854 = load i8**, i8*** %_853 
	%_855 = getelementptr i8*, i8** %_854, i32 19 
	%_856 = load i8*, i8** %_855 
	%_857 = bitcast i8* %_856 to i1 (i8* , i8*)* 
	%_858 = load i8*, i8** %node
	%_862 = bitcast i8* %_858 to i8*** 
	%_863 = load i8**, i8*** %_862 
	%_864 = getelementptr i8*, i8** %_863, i32 4 
	%_865 = load i8*, i8** %_864 
	%_866 = bitcast i8* %_865 to i8* (i8* )* 
	%_867 = call i8* %_866( i8* %_858) 

	%_868 = call i1 %_857( i8* %this, i8* %_867) 

	store i1 %_868,i1* %ntb

	br label %if_end_37
	if_end_37: 

	%_869 = load i8*, i8** %node
	%_873 = bitcast i8* %_869 to i8*** 
	%_874 = load i8**, i8*** %_873 
	%_875 = getelementptr i8*, i8** %_874, i32 5 
	%_876 = load i8*, i8** %_875 
	%_877 = bitcast i8* %_876 to i32 (i8* )* 
	%_878 = call i32 %_877( i8* %_869) 

	call void (i32) @print_int(i32 %_878)

	%_879 = load i8*, i8** %node
	%_883 = bitcast i8* %_879 to i8*** 
	%_884 = load i8**, i8*** %_883 
	%_885 = getelementptr i8*, i8** %_884, i32 7 
	%_886 = load i8*, i8** %_885 
	%_887 = bitcast i8* %_886 to i1 (i8* )* 
	%_888 = call i1 %_887( i8* %_879) 

	br i1 %_888, label %if_then_38, label %if_else_38 
	if_else_38: 
	store i1 1,i1* %ntb

	br label %if_end_38
	if_then_38: 
	%_892 = bitcast i8* %this to i8*** 
	%_893 = load i8**, i8*** %_892 
	%_894 = getelementptr i8*, i8** %_893, i32 19 
	%_895 = load i8*, i8** %_894 
	%_896 = bitcast i8* %_895 to i1 (i8* , i8*)* 
	%_897 = load i8*, i8** %node
	%_901 = bitcast i8* %_897 to i8*** 
	%_902 = load i8**, i8*** %_901 
	%_903 = getelementptr i8*, i8** %_902, i32 3 
	%_904 = load i8*, i8** %_903 
	%_905 = bitcast i8* %_904 to i8* (i8* )* 
	%_906 = call i8* %_905( i8* %_897) 

	%_907 = call i1 %_896( i8* %this, i8* %_906) 

	store i1 %_907,i1* %ntb

	br label %if_end_38
	if_end_38: 

	ret i1 1
}
 
