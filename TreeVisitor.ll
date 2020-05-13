@.TreeVisitor_vtable = global [0 x i8*] [] 
 
@.TV_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @TV.Start to i8*)
]
 
@.Tree_vtable = global [ 21 x i8*] [  
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
	i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*),
	i8* bitcast (i32 (i8*,i8*)* @Tree.accept to i8*)
]
 
@.Visitor_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i8*)* @Visitor.visit to i8*)
]
 
@.MyVisitor_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i8*)* @MyVisitor.visit to i8*)
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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.TV_vtable, i32 0, i32 0 
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
 
define i32 @TV.Start(i8* %this) {
	%root = alloca i8*

	%ntb = alloca i1

	%nti = alloca i32

	%v = alloca i8*

	%_17 = call i8* @calloc(i32 1, i32 38)
	%_18 = bitcast i8* %_17 to i8*** 
	%_19 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0 
	store i8** %_19, i8*** %_18

	store i8* %_17,i8** %root

	%_25 = load i8*, i8** %root
	%_29 = bitcast i8* %_25 to i8*** 
	%_30 = load i8**, i8*** %_29 
	%_31 = getelementptr i8*, i8** %_30, i32 0 
	%_32 = load i8*, i8** %_31 
	%_33 = bitcast i8* %_32 to i1 (i8* , i32)* 
	%_34 = call i1 %_33( i8* %_25, i32 16) 

	store i1 %_34,i1* %ntb

	%_40 = load i8*, i8** %root
	%_44 = bitcast i8* %_40 to i8*** 
	%_45 = load i8**, i8*** %_44 
	%_46 = getelementptr i8*, i8** %_45, i32 18 
	%_47 = load i8*, i8** %_46 
	%_48 = bitcast i8* %_47 to i1 (i8* )* 
	%_49 = call i1 %_48( i8* %_40) 

	store i1 %_49,i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_55 = load i8*, i8** %root
	%_59 = bitcast i8* %_55 to i8*** 
	%_60 = load i8**, i8*** %_59 
	%_61 = getelementptr i8*, i8** %_60, i32 12 
	%_62 = load i8*, i8** %_61 
	%_63 = bitcast i8* %_62 to i1 (i8* , i32)* 
	%_64 = call i1 %_63( i8* %_55, i32 8) 

	store i1 %_64,i1* %ntb

	%_70 = load i8*, i8** %root
	%_74 = bitcast i8* %_70 to i8*** 
	%_75 = load i8**, i8*** %_74 
	%_76 = getelementptr i8*, i8** %_75, i32 12 
	%_77 = load i8*, i8** %_76 
	%_78 = bitcast i8* %_77 to i1 (i8* , i32)* 
	%_79 = call i1 %_78( i8* %_70, i32 24) 

	store i1 %_79,i1* %ntb

	%_85 = load i8*, i8** %root
	%_89 = bitcast i8* %_85 to i8*** 
	%_90 = load i8**, i8*** %_89 
	%_91 = getelementptr i8*, i8** %_90, i32 12 
	%_92 = load i8*, i8** %_91 
	%_93 = bitcast i8* %_92 to i1 (i8* , i32)* 
	%_94 = call i1 %_93( i8* %_85, i32 4) 

	store i1 %_94,i1* %ntb

	%_100 = load i8*, i8** %root
	%_104 = bitcast i8* %_100 to i8*** 
	%_105 = load i8**, i8*** %_104 
	%_106 = getelementptr i8*, i8** %_105, i32 12 
	%_107 = load i8*, i8** %_106 
	%_108 = bitcast i8* %_107 to i1 (i8* , i32)* 
	%_109 = call i1 %_108( i8* %_100, i32 12) 

	store i1 %_109,i1* %ntb

	%_115 = load i8*, i8** %root
	%_119 = bitcast i8* %_115 to i8*** 
	%_120 = load i8**, i8*** %_119 
	%_121 = getelementptr i8*, i8** %_120, i32 12 
	%_122 = load i8*, i8** %_121 
	%_123 = bitcast i8* %_122 to i1 (i8* , i32)* 
	%_124 = call i1 %_123( i8* %_115, i32 20) 

	store i1 %_124,i1* %ntb

	%_130 = load i8*, i8** %root
	%_134 = bitcast i8* %_130 to i8*** 
	%_135 = load i8**, i8*** %_134 
	%_136 = getelementptr i8*, i8** %_135, i32 12 
	%_137 = load i8*, i8** %_136 
	%_138 = bitcast i8* %_137 to i1 (i8* , i32)* 
	%_139 = call i1 %_138( i8* %_130, i32 28) 

	store i1 %_139,i1* %ntb

	%_145 = load i8*, i8** %root
	%_149 = bitcast i8* %_145 to i8*** 
	%_150 = load i8**, i8*** %_149 
	%_151 = getelementptr i8*, i8** %_150, i32 12 
	%_152 = load i8*, i8** %_151 
	%_153 = bitcast i8* %_152 to i1 (i8* , i32)* 
	%_154 = call i1 %_153( i8* %_145, i32 14) 

	store i1 %_154,i1* %ntb

	%_160 = load i8*, i8** %root
	%_164 = bitcast i8* %_160 to i8*** 
	%_165 = load i8**, i8*** %_164 
	%_166 = getelementptr i8*, i8** %_165, i32 18 
	%_167 = load i8*, i8** %_166 
	%_168 = bitcast i8* %_167 to i1 (i8* )* 
	%_169 = call i1 %_168( i8* %_160) 

	store i1 %_169,i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_175 = call i8* @calloc(i32 1, i32 24)
	%_176 = bitcast i8* %_175 to i8*** 
	%_177 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0 
	store i8** %_177, i8*** %_176

	store i8* %_175,i8** %v

	call void (i32) @print_int(i32 50000000)

	%_183 = load i8*, i8** %root
	%_187 = bitcast i8* %_183 to i8*** 
	%_188 = load i8**, i8*** %_187 
	%_189 = getelementptr i8*, i8** %_188, i32 20 
	%_190 = load i8*, i8** %_189 
	%_191 = bitcast i8* %_190 to i32 (i8* , i8*)* 
	%_192 = load i8*, i8** %v
	%_193 = call i32 %_191( i8* %_183, i8* %_192) 

	store i32 %_193,i32* %nti

	call void (i32) @print_int(i32 100000000)

	%_194 = load i8*, i8** %root
	%_198 = bitcast i8* %_194 to i8*** 
	%_199 = load i8**, i8*** %_198 
	%_200 = getelementptr i8*, i8** %_199, i32 17 
	%_201 = load i8*, i8** %_200 
	%_202 = bitcast i8* %_201 to i32 (i8* , i32)* 
	%_203 = call i32 %_202( i8* %_194, i32 24) 

	call void (i32) @print_int(i32 %_203)

	%_204 = load i8*, i8** %root
	%_208 = bitcast i8* %_204 to i8*** 
	%_209 = load i8**, i8*** %_208 
	%_210 = getelementptr i8*, i8** %_209, i32 17 
	%_211 = load i8*, i8** %_210 
	%_212 = bitcast i8* %_211 to i32 (i8* , i32)* 
	%_213 = call i32 %_212( i8* %_204, i32 12) 

	call void (i32) @print_int(i32 %_213)

	%_214 = load i8*, i8** %root
	%_218 = bitcast i8* %_214 to i8*** 
	%_219 = load i8**, i8*** %_218 
	%_220 = getelementptr i8*, i8** %_219, i32 17 
	%_221 = load i8*, i8** %_220 
	%_222 = bitcast i8* %_221 to i32 (i8* , i32)* 
	%_223 = call i32 %_222( i8* %_214, i32 16) 

	call void (i32) @print_int(i32 %_223)

	%_224 = load i8*, i8** %root
	%_228 = bitcast i8* %_224 to i8*** 
	%_229 = load i8**, i8*** %_228 
	%_230 = getelementptr i8*, i8** %_229, i32 17 
	%_231 = load i8*, i8** %_230 
	%_232 = bitcast i8* %_231 to i32 (i8* , i32)* 
	%_233 = call i32 %_232( i8* %_224, i32 50) 

	call void (i32) @print_int(i32 %_233)

	%_234 = load i8*, i8** %root
	%_238 = bitcast i8* %_234 to i8*** 
	%_239 = load i8**, i8*** %_238 
	%_240 = getelementptr i8*, i8** %_239, i32 17 
	%_241 = load i8*, i8** %_240 
	%_242 = bitcast i8* %_241 to i32 (i8* , i32)* 
	%_243 = call i32 %_242( i8* %_234, i32 12) 

	call void (i32) @print_int(i32 %_243)

	%_249 = load i8*, i8** %root
	%_253 = bitcast i8* %_249 to i8*** 
	%_254 = load i8**, i8*** %_253 
	%_255 = getelementptr i8*, i8** %_254, i32 13 
	%_256 = load i8*, i8** %_255 
	%_257 = bitcast i8* %_256 to i1 (i8* , i32)* 
	%_258 = call i1 %_257( i8* %_249, i32 12) 

	store i1 %_258,i1* %ntb

	%_264 = load i8*, i8** %root
	%_268 = bitcast i8* %_264 to i8*** 
	%_269 = load i8**, i8*** %_268 
	%_270 = getelementptr i8*, i8** %_269, i32 18 
	%_271 = load i8*, i8** %_270 
	%_272 = bitcast i8* %_271 to i1 (i8* )* 
	%_273 = call i1 %_272( i8* %_264) 

	store i1 %_273,i1* %ntb

	%_274 = load i8*, i8** %root
	%_278 = bitcast i8* %_274 to i8*** 
	%_279 = load i8**, i8*** %_278 
	%_280 = getelementptr i8*, i8** %_279, i32 17 
	%_281 = load i8*, i8** %_280 
	%_282 = bitcast i8* %_281 to i32 (i8* , i32)* 
	%_283 = call i32 %_282( i8* %_274, i32 12) 

	call void (i32) @print_int(i32 %_283)

	ret i32 0
}
 
define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_284 = getelementptr i8, i8* %this, i32 24
	%_285 = bitcast i8* %_284 to i32* 
	%_291 = load i32, i32* %v_key
	store i32 %_291,i32* %_285

	%_292 = getelementptr i8, i8* %this, i32 28
	%_293 = bitcast i8* %_292 to i1* 
	store i1 0,i1* %_293

	%_299 = getelementptr i8, i8* %this, i32 29
	%_300 = bitcast i8* %_299 to i1* 
	store i1 0,i1* %_300

	ret i1 1
}
 
define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_306 = getelementptr i8, i8* %this, i32 16
	%_307 = bitcast i8* %_306 to i8** 
	%_313 = load i8*, i8** %rn
	store i8* %_313,i8** %_307

	ret i1 1
}
 
define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_314 = getelementptr i8, i8* %this, i32 8
	%_315 = bitcast i8* %_314 to i8** 
	%_321 = load i8*, i8** %ln
	store i8* %_321,i8** %_315

	ret i1 1
}
 
define i8* @Tree.GetRight(i8* %this) {
	%_322 = getelementptr i8, i8* %this, i32 16
	%_323 = bitcast i8* %_322 to i8** 
	%_324 = load i8*, i8** %_323
	ret i8* %_324
}
 
define i8* @Tree.GetLeft(i8* %this) {
	%_325 = getelementptr i8, i8* %this, i32 8
	%_326 = bitcast i8* %_325 to i8** 
	%_327 = load i8*, i8** %_326
	ret i8* %_327
}
 
define i32 @Tree.GetKey(i8* %this) {
	%_328 = getelementptr i8, i8* %this, i32 24
	%_329 = bitcast i8* %_328 to i32* 
	%_330 = load i32, i32* %_329
	ret i32 %_330
}
 
define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_331 = getelementptr i8, i8* %this, i32 24
	%_332 = bitcast i8* %_331 to i32* 
	%_338 = load i32, i32* %v_key
	store i32 %_338,i32* %_332

	ret i1 1
}
 
define i1 @Tree.GetHas_Right(i8* %this) {
	%_339 = getelementptr i8, i8* %this, i32 29
	%_340 = bitcast i8* %_339 to i1* 
	%_341 = load i1, i1* %_340
	ret i1 %_341
}
 
define i1 @Tree.GetHas_Left(i8* %this) {
	%_342 = getelementptr i8, i8* %this, i32 28
	%_343 = bitcast i8* %_342 to i1* 
	%_344 = load i1, i1* %_343
	ret i1 %_344
}
 
define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_345 = getelementptr i8, i8* %this, i32 28
	%_346 = bitcast i8* %_345 to i1* 
	%_352 = load i1, i1* %val
	store i1 %_352,i1* %_346

	ret i1 1
}
 
define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_353 = getelementptr i8, i8* %this, i32 29
	%_354 = bitcast i8* %_353 to i1* 
	%_360 = load i1, i1* %val
	store i1 %_360,i1* %_354

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

	%_371 = load i32, i32* %num2
	%_372 = add i32 %_371, 1

	store i32 %_372,i32* %nti

	%_373 = load i32, i32* %num1
	%_374 = load i32, i32* %num2
	%_375 = icmp slt i32 %_373, %_374

	br i1 %_375, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_376 = load i32, i32* %num1
	%_377 = load i32, i32* %nti
	%_378 = icmp slt i32 %_376, %_377

%_379 = xor i1 1, %_378

	br i1 %_379, label %if_then_1, label %if_else_1 
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

	%_395 = load i1, i1* %ntb
	ret i1 %_395
}
 
define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*

	%ntb = alloca i1

	%current_node = alloca i8*

	%cont = alloca i1

	%key_aux = alloca i32

	%_401 = call i8* @calloc(i32 1, i32 38)
	%_402 = bitcast i8* %_401 to i8*** 
	%_403 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0 
	store i8** %_403, i8*** %_402

	store i8* %_401,i8** %new_node

	%_409 = load i8*, i8** %new_node
	%_413 = bitcast i8* %_409 to i8*** 
	%_414 = load i8**, i8*** %_413 
	%_415 = getelementptr i8*, i8** %_414, i32 0 
	%_416 = load i8*, i8** %_415 
	%_417 = bitcast i8* %_416 to i1 (i8* , i32)* 
	%_418 = load i32, i32* %v_key
	%_419 = call i1 %_417( i8* %_409, i32 %_418) 

	store i1 %_419,i1* %ntb

	store i8* %this,i8** %current_node

	store i1 1,i1* %cont

	br label %loop2
	loop2: 
	%_430 = load i1, i1* %cont
	br i1 %_430, label %loop3, label %loop4 
	loop3: 
	%_436 = load i8*, i8** %current_node
	%_440 = bitcast i8* %_436 to i8*** 
	%_441 = load i8**, i8*** %_440 
	%_442 = getelementptr i8*, i8** %_441, i32 5 
	%_443 = load i8*, i8** %_442 
	%_444 = bitcast i8* %_443 to i32 (i8* )* 
	%_445 = call i32 %_444( i8* %_436) 

	store i32 %_445,i32* %key_aux

	%_446 = load i32, i32* %v_key
	%_447 = load i32, i32* %key_aux
	%_448 = icmp slt i32 %_446, %_447

	br i1 %_448, label %if_then_5, label %if_else_5 
	if_else_5: 
	%_449 = load i8*, i8** %current_node
	%_453 = bitcast i8* %_449 to i8*** 
	%_454 = load i8**, i8*** %_453 
	%_455 = getelementptr i8*, i8** %_454, i32 7 
	%_456 = load i8*, i8** %_455 
	%_457 = bitcast i8* %_456 to i1 (i8* )* 
	%_458 = call i1 %_457( i8* %_449) 

	br i1 %_458, label %if_then_6, label %if_else_6 
	if_else_6: 
	store i1 0,i1* %cont

	%_469 = load i8*, i8** %current_node
	%_473 = bitcast i8* %_469 to i8*** 
	%_474 = load i8**, i8*** %_473 
	%_475 = getelementptr i8*, i8** %_474, i32 10 
	%_476 = load i8*, i8** %_475 
	%_477 = bitcast i8* %_476 to i1 (i8* , i1)* 
	%_478 = call i1 %_477( i8* %_469, i1 1) 

	store i1 %_478,i1* %ntb

	%_484 = load i8*, i8** %current_node
	%_488 = bitcast i8* %_484 to i8*** 
	%_489 = load i8**, i8*** %_488 
	%_490 = getelementptr i8*, i8** %_489, i32 1 
	%_491 = load i8*, i8** %_490 
	%_492 = bitcast i8* %_491 to i1 (i8* , i8*)* 
	%_493 = load i8*, i8** %new_node
	%_494 = call i1 %_492( i8* %_484, i8* %_493) 

	store i1 %_494,i1* %ntb

	br label %if_end_6
	if_then_6: 
	%_500 = load i8*, i8** %current_node
	%_504 = bitcast i8* %_500 to i8*** 
	%_505 = load i8**, i8*** %_504 
	%_506 = getelementptr i8*, i8** %_505, i32 3 
	%_507 = load i8*, i8** %_506 
	%_508 = bitcast i8* %_507 to i8* (i8* )* 
	%_509 = call i8* %_508( i8* %_500) 

	store i8* %_509,i8** %current_node

	br label %if_end_6
	if_end_6: 

	br label %if_end_5
	if_then_5: 
	%_510 = load i8*, i8** %current_node
	%_514 = bitcast i8* %_510 to i8*** 
	%_515 = load i8**, i8*** %_514 
	%_516 = getelementptr i8*, i8** %_515, i32 8 
	%_517 = load i8*, i8** %_516 
	%_518 = bitcast i8* %_517 to i1 (i8* )* 
	%_519 = call i1 %_518( i8* %_510) 

	br i1 %_519, label %if_then_7, label %if_else_7 
	if_else_7: 
	store i1 0,i1* %cont

	%_530 = load i8*, i8** %current_node
	%_534 = bitcast i8* %_530 to i8*** 
	%_535 = load i8**, i8*** %_534 
	%_536 = getelementptr i8*, i8** %_535, i32 9 
	%_537 = load i8*, i8** %_536 
	%_538 = bitcast i8* %_537 to i1 (i8* , i1)* 
	%_539 = call i1 %_538( i8* %_530, i1 1) 

	store i1 %_539,i1* %ntb

	%_545 = load i8*, i8** %current_node
	%_549 = bitcast i8* %_545 to i8*** 
	%_550 = load i8**, i8*** %_549 
	%_551 = getelementptr i8*, i8** %_550, i32 2 
	%_552 = load i8*, i8** %_551 
	%_553 = bitcast i8* %_552 to i1 (i8* , i8*)* 
	%_554 = load i8*, i8** %new_node
	%_555 = call i1 %_553( i8* %_545, i8* %_554) 

	store i1 %_555,i1* %ntb

	br label %if_end_7
	if_then_7: 
	%_561 = load i8*, i8** %current_node
	%_565 = bitcast i8* %_561 to i8*** 
	%_566 = load i8**, i8*** %_565 
	%_567 = getelementptr i8*, i8** %_566, i32 4 
	%_568 = load i8*, i8** %_567 
	%_569 = bitcast i8* %_568 to i8* (i8* )* 
	%_570 = call i8* %_569( i8* %_561) 

	store i8* %_570,i8** %current_node

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

	%ntb = alloca i1

	%is_root = alloca i1

	%key_aux = alloca i32

	store i8* %this,i8** %current_node

	store i8* %this,i8** %parent_node

	store i1 1,i1* %cont

	store i1 0,i1* %found

	store i1 1,i1* %is_root

	br label %loop8
	loop8: 
	%_596 = load i1, i1* %cont
	br i1 %_596, label %loop9, label %loop10 
	loop9: 
	%_602 = load i8*, i8** %current_node
	%_606 = bitcast i8* %_602 to i8*** 
	%_607 = load i8**, i8*** %_606 
	%_608 = getelementptr i8*, i8** %_607, i32 5 
	%_609 = load i8*, i8** %_608 
	%_610 = bitcast i8* %_609 to i32 (i8* )* 
	%_611 = call i32 %_610( i8* %_602) 

	store i32 %_611,i32* %key_aux

	%_612 = load i32, i32* %v_key
	%_613 = load i32, i32* %key_aux
	%_614 = icmp slt i32 %_612, %_613

	br i1 %_614, label %if_then_11, label %if_else_11 
	if_else_11: 
	%_615 = load i32, i32* %key_aux
	%_616 = load i32, i32* %v_key
	%_617 = icmp slt i32 %_615, %_616

	br i1 %_617, label %if_then_12, label %if_else_12 
	if_else_12: 
	%_618 = load i1, i1* %is_root
	br i1 %_618, label %if_then_13, label %if_else_13 
	if_else_13: 
	%_627 = bitcast i8* %this to i8*** 
	%_628 = load i8**, i8*** %_627 
	%_629 = getelementptr i8*, i8** %_628, i32 14 
	%_630 = load i8*, i8** %_629 
	%_631 = bitcast i8* %_630 to i1 (i8* , i8*, i8*)* 
	%_632 = load i8*, i8** %parent_node
	%_633 = load i8*, i8** %current_node
	%_634 = call i1 %_631( i8* %this, i8* %_632, i8* %_633) 

	store i1 %_634,i1* %ntb

	br label %if_end_13
	if_then_13: 
	%_635 = load i8*, i8** %current_node
	%_639 = bitcast i8* %_635 to i8*** 
	%_640 = load i8**, i8*** %_639 
	%_641 = getelementptr i8*, i8** %_640, i32 7 
	%_642 = load i8*, i8** %_641 
	%_643 = bitcast i8* %_642 to i1 (i8* )* 
	%_644 = call i1 %_643( i8* %_635) 

%_645 = xor i1 1, %_644

	br i1 %_645, label %and_clause16, label %and_clause15 
	and_clause15: 
	br label %and_clause17
	and_clause16: 
	%_646 = load i8*, i8** %current_node
	%_650 = bitcast i8* %_646 to i8*** 
	%_651 = load i8**, i8*** %_650 
	%_652 = getelementptr i8*, i8** %_651, i32 8 
	%_653 = load i8*, i8** %_652 
	%_654 = bitcast i8* %_653 to i1 (i8* )* 
	%_655 = call i1 %_654( i8* %_646) 

%_656 = xor i1 1, %_655

	br label %and_clause17
	and_clause17: 
	br label %and_clause18
	and_clause18: 
	%_657 = phi i1 [ 0, %and_clause15 ], [ %_656, %and_clause17] 

	br i1 %_657, label %if_then_14, label %if_else_14 
	if_else_14: 
	%_666 = bitcast i8* %this to i8*** 
	%_667 = load i8**, i8*** %_666 
	%_668 = getelementptr i8*, i8** %_667, i32 14 
	%_669 = load i8*, i8** %_668 
	%_670 = bitcast i8* %_669 to i1 (i8* , i8*, i8*)* 
	%_671 = load i8*, i8** %parent_node
	%_672 = load i8*, i8** %current_node
	%_673 = call i1 %_670( i8* %this, i8* %_671, i8* %_672) 

	store i1 %_673,i1* %ntb

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
	%_689 = load i8*, i8** %current_node
	%_693 = bitcast i8* %_689 to i8*** 
	%_694 = load i8**, i8*** %_693 
	%_695 = getelementptr i8*, i8** %_694, i32 7 
	%_696 = load i8*, i8** %_695 
	%_697 = bitcast i8* %_696 to i1 (i8* )* 
	%_698 = call i1 %_697( i8* %_689) 

	br i1 %_698, label %if_then_19, label %if_else_19 
	if_else_19: 
	store i1 0,i1* %cont

	br label %if_end_19
	if_then_19: 
	%_709 = load i8*, i8** %current_node
	store i8* %_709,i8** %parent_node

	%_715 = load i8*, i8** %current_node
	%_719 = bitcast i8* %_715 to i8*** 
	%_720 = load i8**, i8*** %_719 
	%_721 = getelementptr i8*, i8** %_720, i32 3 
	%_722 = load i8*, i8** %_721 
	%_723 = bitcast i8* %_722 to i8* (i8* )* 
	%_724 = call i8* %_723( i8* %_715) 

	store i8* %_724,i8** %current_node

	br label %if_end_19
	if_end_19: 

	br label %if_end_12
	if_end_12: 

	br label %if_end_11
	if_then_11: 
	%_725 = load i8*, i8** %current_node
	%_729 = bitcast i8* %_725 to i8*** 
	%_730 = load i8**, i8*** %_729 
	%_731 = getelementptr i8*, i8** %_730, i32 8 
	%_732 = load i8*, i8** %_731 
	%_733 = bitcast i8* %_732 to i1 (i8* )* 
	%_734 = call i1 %_733( i8* %_725) 

	br i1 %_734, label %if_then_20, label %if_else_20 
	if_else_20: 
	store i1 0,i1* %cont

	br label %if_end_20
	if_then_20: 
	%_745 = load i8*, i8** %current_node
	store i8* %_745,i8** %parent_node

	%_751 = load i8*, i8** %current_node
	%_755 = bitcast i8* %_751 to i8*** 
	%_756 = load i8**, i8*** %_755 
	%_757 = getelementptr i8*, i8** %_756, i32 4 
	%_758 = load i8*, i8** %_757 
	%_759 = bitcast i8* %_758 to i8* (i8* )* 
	%_760 = call i8* %_759( i8* %_751) 

	store i8* %_760,i8** %current_node

	br label %if_end_20
	if_end_20: 

	br label %if_end_11
	if_end_11: 

	store i1 0,i1* %is_root

	br label %loop8
	loop10: 

	%_766 = load i1, i1* %found
	ret i1 %_766
}
 
define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1

	%auxkey1 = alloca i32

	%auxkey2 = alloca i32

	%_767 = load i8*, i8** %c_node
	%_771 = bitcast i8* %_767 to i8*** 
	%_772 = load i8**, i8*** %_771 
	%_773 = getelementptr i8*, i8** %_772, i32 8 
	%_774 = load i8*, i8** %_773 
	%_775 = bitcast i8* %_774 to i1 (i8* )* 
	%_776 = call i1 %_775( i8* %_767) 

	br i1 %_776, label %if_then_21, label %if_else_21 
	if_else_21: 
	%_777 = load i8*, i8** %c_node
	%_781 = bitcast i8* %_777 to i8*** 
	%_782 = load i8**, i8*** %_781 
	%_783 = getelementptr i8*, i8** %_782, i32 7 
	%_784 = load i8*, i8** %_783 
	%_785 = bitcast i8* %_784 to i1 (i8* )* 
	%_786 = call i1 %_785( i8* %_777) 

	br i1 %_786, label %if_then_22, label %if_else_22 
	if_else_22: 
	%_792 = load i8*, i8** %c_node
	%_796 = bitcast i8* %_792 to i8*** 
	%_797 = load i8**, i8*** %_796 
	%_798 = getelementptr i8*, i8** %_797, i32 5 
	%_799 = load i8*, i8** %_798 
	%_800 = bitcast i8* %_799 to i32 (i8* )* 
	%_801 = call i32 %_800( i8* %_792) 

	store i32 %_801,i32* %auxkey1

	%_807 = load i8*, i8** %p_node
	%_811 = bitcast i8* %_807 to i8*** 
	%_812 = load i8**, i8*** %_811 
	%_813 = getelementptr i8*, i8** %_812, i32 4 
	%_814 = load i8*, i8** %_813 
	%_815 = bitcast i8* %_814 to i8* (i8* )* 
	%_816 = call i8* %_815( i8* %_807) 

	%_817 = load i8*, i8** %p_node
	%_821 = bitcast i8* %_817 to i8*** 
	%_822 = load i8**, i8*** %_821 
	%_823 = getelementptr i8*, i8** %_822, i32 4 
	%_824 = load i8*, i8** %_823 
	%_825 = bitcast i8* %_824 to i8* (i8* )* 
	%_826 = call i8* %_825( i8* %_817) 

	%_830 = bitcast i8* %_826 to i8*** 
	%_831 = load i8**, i8*** %_830 
	%_832 = getelementptr i8*, i8** %_831, i32 5 
	%_833 = load i8*, i8** %_832 
	%_834 = bitcast i8* %_833 to i32 (i8* )* 
	%_835 = call i32 %_834( i8* %_826) 

	store i32 %_835,i32* %auxkey2

	%_839 = bitcast i8* %this to i8*** 
	%_840 = load i8**, i8*** %_839 
	%_841 = getelementptr i8*, i8** %_840, i32 11 
	%_842 = load i8*, i8** %_841 
	%_843 = bitcast i8* %_842 to i1 (i8* , i32, i32)* 
	%_844 = load i32, i32* %auxkey1
	%_845 = load i32, i32* %auxkey2
	%_846 = call i1 %_843( i8* %this, i32 %_844, i32 %_845) 

	br i1 %_846, label %if_then_23, label %if_else_23 
	if_else_23: 
	%_852 = load i8*, i8** %p_node
	%_856 = bitcast i8* %_852 to i8*** 
	%_857 = load i8**, i8*** %_856 
	%_858 = getelementptr i8*, i8** %_857, i32 1 
	%_859 = load i8*, i8** %_858 
	%_860 = bitcast i8* %_859 to i1 (i8* , i8*)* 
	%_861 = getelementptr i8, i8* %this, i32 30
	%_862 = bitcast i8* %_861 to i8** 
	%_863 = load i8*, i8** %_862
	%_864 = call i1 %_860( i8* %_852, i8* %_863) 

	store i1 %_864,i1* %ntb

	%_870 = load i8*, i8** %p_node
	%_874 = bitcast i8* %_870 to i8*** 
	%_875 = load i8**, i8*** %_874 
	%_876 = getelementptr i8*, i8** %_875, i32 10 
	%_877 = load i8*, i8** %_876 
	%_878 = bitcast i8* %_877 to i1 (i8* , i1)* 
	%_879 = call i1 %_878( i8* %_870, i1 0) 

	store i1 %_879,i1* %ntb

	br label %if_end_23
	if_then_23: 
	%_885 = load i8*, i8** %p_node
	%_889 = bitcast i8* %_885 to i8*** 
	%_890 = load i8**, i8*** %_889 
	%_891 = getelementptr i8*, i8** %_890, i32 2 
	%_892 = load i8*, i8** %_891 
	%_893 = bitcast i8* %_892 to i1 (i8* , i8*)* 
	%_894 = getelementptr i8, i8* %this, i32 30
	%_895 = bitcast i8* %_894 to i8** 
	%_896 = load i8*, i8** %_895
	%_897 = call i1 %_893( i8* %_885, i8* %_896) 

	store i1 %_897,i1* %ntb

	%_903 = load i8*, i8** %p_node
	%_907 = bitcast i8* %_903 to i8*** 
	%_908 = load i8**, i8*** %_907 
	%_909 = getelementptr i8*, i8** %_908, i32 9 
	%_910 = load i8*, i8** %_909 
	%_911 = bitcast i8* %_910 to i1 (i8* , i1)* 
	%_912 = call i1 %_911( i8* %_903, i1 0) 

	store i1 %_912,i1* %ntb

	br label %if_end_23
	if_end_23: 

	br label %if_end_22
	if_then_22: 
	%_921 = bitcast i8* %this to i8*** 
	%_922 = load i8**, i8*** %_921 
	%_923 = getelementptr i8*, i8** %_922, i32 15 
	%_924 = load i8*, i8** %_923 
	%_925 = bitcast i8* %_924 to i1 (i8* , i8*, i8*)* 
	%_926 = load i8*, i8** %p_node
	%_927 = load i8*, i8** %c_node
	%_928 = call i1 %_925( i8* %this, i8* %_926, i8* %_927) 

	store i1 %_928,i1* %ntb

	br label %if_end_22
	if_end_22: 

	br label %if_end_21
	if_then_21: 
	%_937 = bitcast i8* %this to i8*** 
	%_938 = load i8**, i8*** %_937 
	%_939 = getelementptr i8*, i8** %_938, i32 16 
	%_940 = load i8*, i8** %_939 
	%_941 = bitcast i8* %_940 to i1 (i8* , i8*, i8*)* 
	%_942 = load i8*, i8** %p_node
	%_943 = load i8*, i8** %c_node
	%_944 = call i1 %_941( i8* %this, i8* %_942, i8* %_943) 

	store i1 %_944,i1* %ntb

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
	%_945 = load i8*, i8** %c_node
	%_949 = bitcast i8* %_945 to i8*** 
	%_950 = load i8**, i8*** %_949 
	%_951 = getelementptr i8*, i8** %_950, i32 7 
	%_952 = load i8*, i8** %_951 
	%_953 = bitcast i8* %_952 to i1 (i8* )* 
	%_954 = call i1 %_953( i8* %_945) 

	br i1 %_954, label %loop25, label %loop26 
	loop25: 
	%_960 = load i8*, i8** %c_node
	%_964 = bitcast i8* %_960 to i8*** 
	%_965 = load i8**, i8*** %_964 
	%_966 = getelementptr i8*, i8** %_965, i32 6 
	%_967 = load i8*, i8** %_966 
	%_968 = bitcast i8* %_967 to i1 (i8* , i32)* 
	%_969 = load i8*, i8** %c_node
	%_973 = bitcast i8* %_969 to i8*** 
	%_974 = load i8**, i8*** %_973 
	%_975 = getelementptr i8*, i8** %_974, i32 3 
	%_976 = load i8*, i8** %_975 
	%_977 = bitcast i8* %_976 to i8* (i8* )* 
	%_978 = call i8* %_977( i8* %_969) 

	%_979 = load i8*, i8** %c_node
	%_983 = bitcast i8* %_979 to i8*** 
	%_984 = load i8**, i8*** %_983 
	%_985 = getelementptr i8*, i8** %_984, i32 3 
	%_986 = load i8*, i8** %_985 
	%_987 = bitcast i8* %_986 to i8* (i8* )* 
	%_988 = call i8* %_987( i8* %_979) 

	%_992 = bitcast i8* %_988 to i8*** 
	%_993 = load i8**, i8*** %_992 
	%_994 = getelementptr i8*, i8** %_993, i32 5 
	%_995 = load i8*, i8** %_994 
	%_996 = bitcast i8* %_995 to i32 (i8* )* 
	%_997 = call i32 %_996( i8* %_988) 

	%_998 = call i1 %_968( i8* %_960, i32 %_997) 

	store i1 %_998,i1* %ntb

	%_1004 = load i8*, i8** %c_node
	store i8* %_1004,i8** %p_node

	%_1010 = load i8*, i8** %c_node
	%_1014 = bitcast i8* %_1010 to i8*** 
	%_1015 = load i8**, i8*** %_1014 
	%_1016 = getelementptr i8*, i8** %_1015, i32 3 
	%_1017 = load i8*, i8** %_1016 
	%_1018 = bitcast i8* %_1017 to i8* (i8* )* 
	%_1019 = call i8* %_1018( i8* %_1010) 

	store i8* %_1019,i8** %c_node

	br label %loop24
	loop26: 

	%_1025 = load i8*, i8** %p_node
	%_1029 = bitcast i8* %_1025 to i8*** 
	%_1030 = load i8**, i8*** %_1029 
	%_1031 = getelementptr i8*, i8** %_1030, i32 1 
	%_1032 = load i8*, i8** %_1031 
	%_1033 = bitcast i8* %_1032 to i1 (i8* , i8*)* 
	%_1034 = getelementptr i8, i8* %this, i32 30
	%_1035 = bitcast i8* %_1034 to i8** 
	%_1036 = load i8*, i8** %_1035
	%_1037 = call i1 %_1033( i8* %_1025, i8* %_1036) 

	store i1 %_1037,i1* %ntb

	%_1043 = load i8*, i8** %p_node
	%_1047 = bitcast i8* %_1043 to i8*** 
	%_1048 = load i8**, i8*** %_1047 
	%_1049 = getelementptr i8*, i8** %_1048, i32 10 
	%_1050 = load i8*, i8** %_1049 
	%_1051 = bitcast i8* %_1050 to i1 (i8* , i1)* 
	%_1052 = call i1 %_1051( i8* %_1043, i1 0) 

	store i1 %_1052,i1* %ntb

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
	%_1053 = load i8*, i8** %c_node
	%_1057 = bitcast i8* %_1053 to i8*** 
	%_1058 = load i8**, i8*** %_1057 
	%_1059 = getelementptr i8*, i8** %_1058, i32 8 
	%_1060 = load i8*, i8** %_1059 
	%_1061 = bitcast i8* %_1060 to i1 (i8* )* 
	%_1062 = call i1 %_1061( i8* %_1053) 

	br i1 %_1062, label %loop28, label %loop29 
	loop28: 
	%_1068 = load i8*, i8** %c_node
	%_1072 = bitcast i8* %_1068 to i8*** 
	%_1073 = load i8**, i8*** %_1072 
	%_1074 = getelementptr i8*, i8** %_1073, i32 6 
	%_1075 = load i8*, i8** %_1074 
	%_1076 = bitcast i8* %_1075 to i1 (i8* , i32)* 
	%_1077 = load i8*, i8** %c_node
	%_1081 = bitcast i8* %_1077 to i8*** 
	%_1082 = load i8**, i8*** %_1081 
	%_1083 = getelementptr i8*, i8** %_1082, i32 4 
	%_1084 = load i8*, i8** %_1083 
	%_1085 = bitcast i8* %_1084 to i8* (i8* )* 
	%_1086 = call i8* %_1085( i8* %_1077) 

	%_1087 = load i8*, i8** %c_node
	%_1091 = bitcast i8* %_1087 to i8*** 
	%_1092 = load i8**, i8*** %_1091 
	%_1093 = getelementptr i8*, i8** %_1092, i32 4 
	%_1094 = load i8*, i8** %_1093 
	%_1095 = bitcast i8* %_1094 to i8* (i8* )* 
	%_1096 = call i8* %_1095( i8* %_1087) 

	%_1100 = bitcast i8* %_1096 to i8*** 
	%_1101 = load i8**, i8*** %_1100 
	%_1102 = getelementptr i8*, i8** %_1101, i32 5 
	%_1103 = load i8*, i8** %_1102 
	%_1104 = bitcast i8* %_1103 to i32 (i8* )* 
	%_1105 = call i32 %_1104( i8* %_1096) 

	%_1106 = call i1 %_1076( i8* %_1068, i32 %_1105) 

	store i1 %_1106,i1* %ntb

	%_1112 = load i8*, i8** %c_node
	store i8* %_1112,i8** %p_node

	%_1118 = load i8*, i8** %c_node
	%_1122 = bitcast i8* %_1118 to i8*** 
	%_1123 = load i8**, i8*** %_1122 
	%_1124 = getelementptr i8*, i8** %_1123, i32 4 
	%_1125 = load i8*, i8** %_1124 
	%_1126 = bitcast i8* %_1125 to i8* (i8* )* 
	%_1127 = call i8* %_1126( i8* %_1118) 

	store i8* %_1127,i8** %c_node

	br label %loop27
	loop29: 

	%_1133 = load i8*, i8** %p_node
	%_1137 = bitcast i8* %_1133 to i8*** 
	%_1138 = load i8**, i8*** %_1137 
	%_1139 = getelementptr i8*, i8** %_1138, i32 2 
	%_1140 = load i8*, i8** %_1139 
	%_1141 = bitcast i8* %_1140 to i1 (i8* , i8*)* 
	%_1142 = getelementptr i8, i8* %this, i32 30
	%_1143 = bitcast i8* %_1142 to i8** 
	%_1144 = load i8*, i8** %_1143
	%_1145 = call i1 %_1141( i8* %_1133, i8* %_1144) 

	store i1 %_1145,i1* %ntb

	%_1151 = load i8*, i8** %p_node
	%_1155 = bitcast i8* %_1151 to i8*** 
	%_1156 = load i8**, i8*** %_1155 
	%_1157 = getelementptr i8*, i8** %_1156, i32 9 
	%_1158 = load i8*, i8** %_1157 
	%_1159 = bitcast i8* %_1158 to i1 (i8* , i1)* 
	%_1160 = call i1 %_1159( i8* %_1151, i1 0) 

	store i1 %_1160,i1* %ntb

	ret i1 1
}
 
define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*

	%ifound = alloca i32

	%cont = alloca i1

	%key_aux = alloca i32

	store i8* %this,i8** %current_node

	store i1 1,i1* %cont

	store i32 0,i32* %ifound

	br label %loop30
	loop30: 
	%_1176 = load i1, i1* %cont
	br i1 %_1176, label %loop31, label %loop32 
	loop31: 
	%_1182 = load i8*, i8** %current_node
	%_1186 = bitcast i8* %_1182 to i8*** 
	%_1187 = load i8**, i8*** %_1186 
	%_1188 = getelementptr i8*, i8** %_1187, i32 5 
	%_1189 = load i8*, i8** %_1188 
	%_1190 = bitcast i8* %_1189 to i32 (i8* )* 
	%_1191 = call i32 %_1190( i8* %_1182) 

	store i32 %_1191,i32* %key_aux

	%_1192 = load i32, i32* %v_key
	%_1193 = load i32, i32* %key_aux
	%_1194 = icmp slt i32 %_1192, %_1193

	br i1 %_1194, label %if_then_33, label %if_else_33 
	if_else_33: 
	%_1195 = load i32, i32* %key_aux
	%_1196 = load i32, i32* %v_key
	%_1197 = icmp slt i32 %_1195, %_1196

	br i1 %_1197, label %if_then_34, label %if_else_34 
	if_else_34: 
	store i32 1,i32* %ifound

	store i1 0,i1* %cont

	br label %if_end_34
	if_then_34: 
	%_1208 = load i8*, i8** %current_node
	%_1212 = bitcast i8* %_1208 to i8*** 
	%_1213 = load i8**, i8*** %_1212 
	%_1214 = getelementptr i8*, i8** %_1213, i32 7 
	%_1215 = load i8*, i8** %_1214 
	%_1216 = bitcast i8* %_1215 to i1 (i8* )* 
	%_1217 = call i1 %_1216( i8* %_1208) 

	br i1 %_1217, label %if_then_35, label %if_else_35 
	if_else_35: 
	store i1 0,i1* %cont

	br label %if_end_35
	if_then_35: 
	%_1228 = load i8*, i8** %current_node
	%_1232 = bitcast i8* %_1228 to i8*** 
	%_1233 = load i8**, i8*** %_1232 
	%_1234 = getelementptr i8*, i8** %_1233, i32 3 
	%_1235 = load i8*, i8** %_1234 
	%_1236 = bitcast i8* %_1235 to i8* (i8* )* 
	%_1237 = call i8* %_1236( i8* %_1228) 

	store i8* %_1237,i8** %current_node

	br label %if_end_35
	if_end_35: 

	br label %if_end_34
	if_end_34: 

	br label %if_end_33
	if_then_33: 
	%_1238 = load i8*, i8** %current_node
	%_1242 = bitcast i8* %_1238 to i8*** 
	%_1243 = load i8**, i8*** %_1242 
	%_1244 = getelementptr i8*, i8** %_1243, i32 8 
	%_1245 = load i8*, i8** %_1244 
	%_1246 = bitcast i8* %_1245 to i1 (i8* )* 
	%_1247 = call i1 %_1246( i8* %_1238) 

	br i1 %_1247, label %if_then_36, label %if_else_36 
	if_else_36: 
	store i1 0,i1* %cont

	br label %if_end_36
	if_then_36: 
	%_1258 = load i8*, i8** %current_node
	%_1262 = bitcast i8* %_1258 to i8*** 
	%_1263 = load i8**, i8*** %_1262 
	%_1264 = getelementptr i8*, i8** %_1263, i32 4 
	%_1265 = load i8*, i8** %_1264 
	%_1266 = bitcast i8* %_1265 to i8* (i8* )* 
	%_1267 = call i8* %_1266( i8* %_1258) 

	store i8* %_1267,i8** %current_node

	br label %if_end_36
	if_end_36: 

	br label %if_end_33
	if_end_33: 

	br label %loop30
	loop32: 

	%_1268 = load i32, i32* %ifound
	ret i32 %_1268
}
 
define i1 @Tree.Print(i8* %this) {
	%ntb = alloca i1

	%current_node = alloca i8*

	store i8* %this,i8** %current_node

	%_1282 = bitcast i8* %this to i8*** 
	%_1283 = load i8**, i8*** %_1282 
	%_1284 = getelementptr i8*, i8** %_1283, i32 19 
	%_1285 = load i8*, i8** %_1284 
	%_1286 = bitcast i8* %_1285 to i1 (i8* , i8*)* 
	%_1287 = load i8*, i8** %current_node
	%_1288 = call i1 %_1286( i8* %this, i8* %_1287) 

	store i1 %_1288,i1* %ntb

	ret i1 1
}
 
define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1

	%_1289 = load i8*, i8** %node
	%_1293 = bitcast i8* %_1289 to i8*** 
	%_1294 = load i8**, i8*** %_1293 
	%_1295 = getelementptr i8*, i8** %_1294, i32 8 
	%_1296 = load i8*, i8** %_1295 
	%_1297 = bitcast i8* %_1296 to i1 (i8* )* 
	%_1298 = call i1 %_1297( i8* %_1289) 

	br i1 %_1298, label %if_then_37, label %if_else_37 
	if_else_37: 
	store i1 1,i1* %ntb

	br label %if_end_37
	if_then_37: 
	%_1312 = bitcast i8* %this to i8*** 
	%_1313 = load i8**, i8*** %_1312 
	%_1314 = getelementptr i8*, i8** %_1313, i32 19 
	%_1315 = load i8*, i8** %_1314 
	%_1316 = bitcast i8* %_1315 to i1 (i8* , i8*)* 
	%_1317 = load i8*, i8** %node
	%_1321 = bitcast i8* %_1317 to i8*** 
	%_1322 = load i8**, i8*** %_1321 
	%_1323 = getelementptr i8*, i8** %_1322, i32 4 
	%_1324 = load i8*, i8** %_1323 
	%_1325 = bitcast i8* %_1324 to i8* (i8* )* 
	%_1326 = call i8* %_1325( i8* %_1317) 

	%_1327 = call i1 %_1316( i8* %this, i8* %_1326) 

	store i1 %_1327,i1* %ntb

	br label %if_end_37
	if_end_37: 

	%_1328 = load i8*, i8** %node
	%_1332 = bitcast i8* %_1328 to i8*** 
	%_1333 = load i8**, i8*** %_1332 
	%_1334 = getelementptr i8*, i8** %_1333, i32 5 
	%_1335 = load i8*, i8** %_1334 
	%_1336 = bitcast i8* %_1335 to i32 (i8* )* 
	%_1337 = call i32 %_1336( i8* %_1328) 

	call void (i32) @print_int(i32 %_1337)

	%_1338 = load i8*, i8** %node
	%_1342 = bitcast i8* %_1338 to i8*** 
	%_1343 = load i8**, i8*** %_1342 
	%_1344 = getelementptr i8*, i8** %_1343, i32 7 
	%_1345 = load i8*, i8** %_1344 
	%_1346 = bitcast i8* %_1345 to i1 (i8* )* 
	%_1347 = call i1 %_1346( i8* %_1338) 

	br i1 %_1347, label %if_then_38, label %if_else_38 
	if_else_38: 
	store i1 1,i1* %ntb

	br label %if_end_38
	if_then_38: 
	%_1361 = bitcast i8* %this to i8*** 
	%_1362 = load i8**, i8*** %_1361 
	%_1363 = getelementptr i8*, i8** %_1362, i32 19 
	%_1364 = load i8*, i8** %_1363 
	%_1365 = bitcast i8* %_1364 to i1 (i8* , i8*)* 
	%_1366 = load i8*, i8** %node
	%_1370 = bitcast i8* %_1366 to i8*** 
	%_1371 = load i8**, i8*** %_1370 
	%_1372 = getelementptr i8*, i8** %_1371, i32 3 
	%_1373 = load i8*, i8** %_1372 
	%_1374 = bitcast i8* %_1373 to i8* (i8* )* 
	%_1375 = call i8* %_1374( i8* %_1366) 

	%_1376 = call i1 %_1365( i8* %this, i8* %_1375) 

	store i1 %_1376,i1* %ntb

	br label %if_end_38
	if_end_38: 

	ret i1 1
}
 
define i32 @Tree.accept(i8* %this, i8* %.v) {
	%v = alloca i8*
	store i8* %.v, i8** %v
	%nti = alloca i32

	call void (i32) @print_int(i32 333)

	%_1382 = load i8*, i8** %v
	%_1386 = bitcast i8* %_1382 to i8*** 
	%_1387 = load i8**, i8*** %_1386 
	%_1388 = getelementptr i8*, i8** %_1387, i32 0 
	%_1389 = load i8*, i8** %_1388 
	%_1390 = bitcast i8* %_1389 to i32 (i8* , i8*)* 
	%_1391 = call i32 %_1390( i8* %_1382, i8* %this) 

	store i32 %_1391,i32* %nti

	ret i32 0
}
 
define i32 @Visitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32

	%_1392 = load i8*, i8** %n
	%_1396 = bitcast i8* %_1392 to i8*** 
	%_1397 = load i8**, i8*** %_1396 
	%_1398 = getelementptr i8*, i8** %_1397, i32 7 
	%_1399 = load i8*, i8** %_1398 
	%_1400 = bitcast i8* %_1399 to i1 (i8* )* 
	%_1401 = call i1 %_1400( i8* %_1392) 

	br i1 %_1401, label %if_then_39, label %if_else_39 
	if_else_39: 
	store i32 0,i32* %nti

	br label %if_end_39
	if_then_39: 
	%_1407 = getelementptr i8, i8* %this, i32 16
	%_1408 = bitcast i8* %_1407 to i8** 
	%_1414 = load i8*, i8** %n
	%_1418 = bitcast i8* %_1414 to i8*** 
	%_1419 = load i8**, i8*** %_1418 
	%_1420 = getelementptr i8*, i8** %_1419, i32 3 
	%_1421 = load i8*, i8** %_1420 
	%_1422 = bitcast i8* %_1421 to i8* (i8* )* 
	%_1423 = call i8* %_1422( i8* %_1414) 

	store i8* %_1423,i8** %_1408

	%_1429 = getelementptr i8, i8* %this, i32 16
	%_1430 = bitcast i8* %_1429 to i8** 
	%_1431 = load i8*, i8** %_1430
	%_1435 = bitcast i8* %_1431 to i8*** 
	%_1436 = load i8**, i8*** %_1435 
	%_1437 = getelementptr i8*, i8** %_1436, i32 20 
	%_1438 = load i8*, i8** %_1437 
	%_1439 = bitcast i8* %_1438 to i32 (i8* , i8*)* 
	%_1440 = call i32 %_1439( i8* %_1431, i8* %this) 

	store i32 %_1440,i32* %nti

	br label %if_end_39
	if_end_39: 

	%_1441 = load i8*, i8** %n
	%_1445 = bitcast i8* %_1441 to i8*** 
	%_1446 = load i8**, i8*** %_1445 
	%_1447 = getelementptr i8*, i8** %_1446, i32 8 
	%_1448 = load i8*, i8** %_1447 
	%_1449 = bitcast i8* %_1448 to i1 (i8* )* 
	%_1450 = call i1 %_1449( i8* %_1441) 

	br i1 %_1450, label %if_then_40, label %if_else_40 
	if_else_40: 
	store i32 0,i32* %nti

	br label %if_end_40
	if_then_40: 
	%_1456 = getelementptr i8, i8* %this, i32 8
	%_1457 = bitcast i8* %_1456 to i8** 
	%_1463 = load i8*, i8** %n
	%_1467 = bitcast i8* %_1463 to i8*** 
	%_1468 = load i8**, i8*** %_1467 
	%_1469 = getelementptr i8*, i8** %_1468, i32 4 
	%_1470 = load i8*, i8** %_1469 
	%_1471 = bitcast i8* %_1470 to i8* (i8* )* 
	%_1472 = call i8* %_1471( i8* %_1463) 

	store i8* %_1472,i8** %_1457

	%_1478 = getelementptr i8, i8* %this, i32 8
	%_1479 = bitcast i8* %_1478 to i8** 
	%_1480 = load i8*, i8** %_1479
	%_1484 = bitcast i8* %_1480 to i8*** 
	%_1485 = load i8**, i8*** %_1484 
	%_1486 = getelementptr i8*, i8** %_1485, i32 20 
	%_1487 = load i8*, i8** %_1486 
	%_1488 = bitcast i8* %_1487 to i32 (i8* , i8*)* 
	%_1489 = call i32 %_1488( i8* %_1480, i8* %this) 

	store i32 %_1489,i32* %nti

	br label %if_end_40
	if_end_40: 

	ret i32 0
}
 
define i32 @MyVisitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32

	%_1490 = load i8*, i8** %n
	%_1494 = bitcast i8* %_1490 to i8*** 
	%_1495 = load i8**, i8*** %_1494 
	%_1496 = getelementptr i8*, i8** %_1495, i32 7 
	%_1497 = load i8*, i8** %_1496 
	%_1498 = bitcast i8* %_1497 to i1 (i8* )* 
	%_1499 = call i1 %_1498( i8* %_1490) 

	br i1 %_1499, label %if_then_41, label %if_else_41 
	if_else_41: 
	store i32 0,i32* %nti

	br label %if_end_41
	if_then_41: 
	%_1505 = getelementptr i8, i8* %this, i32 16
	%_1506 = bitcast i8* %_1505 to i8** 
	%_1510 = load i8*, i8** %n
	%_1514 = bitcast i8* %_1510 to i8*** 
	%_1515 = load i8**, i8*** %_1514 
	%_1516 = getelementptr i8*, i8** %_1515, i32 3 
	%_1517 = load i8*, i8** %_1516 
	%_1518 = bitcast i8* %_1517 to i8* (i8* )* 
	%_1519 = call i8* %_1518( i8* %_1510) 

	store i8* %_1519,i8** %_1506

	%_1525 = getelementptr i8, i8* %this, i32 16
	%_1526 = bitcast i8* %_1525 to i8** 
	%_1527 = load i8*, i8** %_1526
	%_1528 = bitcast i8* %_1527 to i8*** 
	%_1529 = load i8**, i8*** %_1528 
	%_1530 = getelementptr i8*, i8** %_1529, i32 20 
	%_1531 = load i8*, i8** %_1530 
	%_1532 = bitcast i8* %_1531 to i32 (i8* , i8*)* 
	%_1533 = call i32 %_1532( i8* %_1527, i8* %this) 

	store i32 %_1533,i32* %nti

	br label %if_end_41
	if_end_41: 

	%_1534 = load i8*, i8** %n
	%_1538 = bitcast i8* %_1534 to i8*** 
	%_1539 = load i8**, i8*** %_1538 
	%_1540 = getelementptr i8*, i8** %_1539, i32 5 
	%_1541 = load i8*, i8** %_1540 
	%_1542 = bitcast i8* %_1541 to i32 (i8* )* 
	%_1543 = call i32 %_1542( i8* %_1534) 

	call void (i32) @print_int(i32 %_1543)

	%_1544 = load i8*, i8** %n
	%_1548 = bitcast i8* %_1544 to i8*** 
	%_1549 = load i8**, i8*** %_1548 
	%_1550 = getelementptr i8*, i8** %_1549, i32 8 
	%_1551 = load i8*, i8** %_1550 
	%_1552 = bitcast i8* %_1551 to i1 (i8* )* 
	%_1553 = call i1 %_1552( i8* %_1544) 

	br i1 %_1553, label %if_then_42, label %if_else_42 
	if_else_42: 
	store i32 0,i32* %nti

	br label %if_end_42
	if_then_42: 
	%_1559 = getelementptr i8, i8* %this, i32 8
	%_1560 = bitcast i8* %_1559 to i8** 
	%_1564 = load i8*, i8** %n
	%_1568 = bitcast i8* %_1564 to i8*** 
	%_1569 = load i8**, i8*** %_1568 
	%_1570 = getelementptr i8*, i8** %_1569, i32 4 
	%_1571 = load i8*, i8** %_1570 
	%_1572 = bitcast i8* %_1571 to i8* (i8* )* 
	%_1573 = call i8* %_1572( i8* %_1564) 

	store i8* %_1573,i8** %_1560

	%_1579 = getelementptr i8, i8* %this, i32 8
	%_1580 = bitcast i8* %_1579 to i8** 
	%_1581 = load i8*, i8** %_1580
	%_1582 = bitcast i8* %_1581 to i8*** 
	%_1583 = load i8**, i8*** %_1582 
	%_1584 = getelementptr i8*, i8** %_1583, i32 20 
	%_1585 = load i8*, i8** %_1584 
	%_1586 = bitcast i8* %_1585 to i32 (i8* , i8*)* 
	%_1587 = call i32 %_1586( i8* %_1581, i8* %this) 

	store i32 %_1587,i32* %nti

	br label %if_end_42
	if_end_42: 

	ret i32 0
}
 
