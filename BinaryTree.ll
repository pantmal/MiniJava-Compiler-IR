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

	%_17 = call i8* @calloc(i32 1, i32 38)
	%_18 = bitcast i8* %_17 to i8*** 
	%_19 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0 
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
	%_76 = getelementptr i8*, i8** %_75, i32 18 
	%_77 = load i8*, i8** %_76 
	%_78 = bitcast i8* %_77 to i1 (i8* )* 
	%_79 = call i1 %_78( i8* %_70) 

	store i1 %_79,i1* %ntb

	%_85 = load i8*, i8** %root
	%_89 = bitcast i8* %_85 to i8*** 
	%_90 = load i8**, i8*** %_89 
	%_91 = getelementptr i8*, i8** %_90, i32 12 
	%_92 = load i8*, i8** %_91 
	%_93 = bitcast i8* %_92 to i1 (i8* , i32)* 
	%_94 = call i1 %_93( i8* %_85, i32 24) 

	store i1 %_94,i1* %ntb

	%_100 = load i8*, i8** %root
	%_104 = bitcast i8* %_100 to i8*** 
	%_105 = load i8**, i8*** %_104 
	%_106 = getelementptr i8*, i8** %_105, i32 12 
	%_107 = load i8*, i8** %_106 
	%_108 = bitcast i8* %_107 to i1 (i8* , i32)* 
	%_109 = call i1 %_108( i8* %_100, i32 4) 

	store i1 %_109,i1* %ntb

	%_115 = load i8*, i8** %root
	%_119 = bitcast i8* %_115 to i8*** 
	%_120 = load i8**, i8*** %_119 
	%_121 = getelementptr i8*, i8** %_120, i32 12 
	%_122 = load i8*, i8** %_121 
	%_123 = bitcast i8* %_122 to i1 (i8* , i32)* 
	%_124 = call i1 %_123( i8* %_115, i32 12) 

	store i1 %_124,i1* %ntb

	%_130 = load i8*, i8** %root
	%_134 = bitcast i8* %_130 to i8*** 
	%_135 = load i8**, i8*** %_134 
	%_136 = getelementptr i8*, i8** %_135, i32 12 
	%_137 = load i8*, i8** %_136 
	%_138 = bitcast i8* %_137 to i1 (i8* , i32)* 
	%_139 = call i1 %_138( i8* %_130, i32 20) 

	store i1 %_139,i1* %ntb

	%_145 = load i8*, i8** %root
	%_149 = bitcast i8* %_145 to i8*** 
	%_150 = load i8**, i8*** %_149 
	%_151 = getelementptr i8*, i8** %_150, i32 12 
	%_152 = load i8*, i8** %_151 
	%_153 = bitcast i8* %_152 to i1 (i8* , i32)* 
	%_154 = call i1 %_153( i8* %_145, i32 28) 

	store i1 %_154,i1* %ntb

	%_160 = load i8*, i8** %root
	%_164 = bitcast i8* %_160 to i8*** 
	%_165 = load i8**, i8*** %_164 
	%_166 = getelementptr i8*, i8** %_165, i32 12 
	%_167 = load i8*, i8** %_166 
	%_168 = bitcast i8* %_167 to i1 (i8* , i32)* 
	%_169 = call i1 %_168( i8* %_160, i32 14) 

	store i1 %_169,i1* %ntb

	%_175 = load i8*, i8** %root
	%_179 = bitcast i8* %_175 to i8*** 
	%_180 = load i8**, i8*** %_179 
	%_181 = getelementptr i8*, i8** %_180, i32 18 
	%_182 = load i8*, i8** %_181 
	%_183 = bitcast i8* %_182 to i1 (i8* )* 
	%_184 = call i1 %_183( i8* %_175) 

	store i1 %_184,i1* %ntb

	%_185 = load i8*, i8** %root
	%_189 = bitcast i8* %_185 to i8*** 
	%_190 = load i8**, i8*** %_189 
	%_191 = getelementptr i8*, i8** %_190, i32 17 
	%_192 = load i8*, i8** %_191 
	%_193 = bitcast i8* %_192 to i32 (i8* , i32)* 
	%_194 = call i32 %_193( i8* %_185, i32 24) 

	call void (i32) @print_int(i32 %_194)

	%_195 = load i8*, i8** %root
	%_199 = bitcast i8* %_195 to i8*** 
	%_200 = load i8**, i8*** %_199 
	%_201 = getelementptr i8*, i8** %_200, i32 17 
	%_202 = load i8*, i8** %_201 
	%_203 = bitcast i8* %_202 to i32 (i8* , i32)* 
	%_204 = call i32 %_203( i8* %_195, i32 12) 

	call void (i32) @print_int(i32 %_204)

	%_205 = load i8*, i8** %root
	%_209 = bitcast i8* %_205 to i8*** 
	%_210 = load i8**, i8*** %_209 
	%_211 = getelementptr i8*, i8** %_210, i32 17 
	%_212 = load i8*, i8** %_211 
	%_213 = bitcast i8* %_212 to i32 (i8* , i32)* 
	%_214 = call i32 %_213( i8* %_205, i32 16) 

	call void (i32) @print_int(i32 %_214)

	%_215 = load i8*, i8** %root
	%_219 = bitcast i8* %_215 to i8*** 
	%_220 = load i8**, i8*** %_219 
	%_221 = getelementptr i8*, i8** %_220, i32 17 
	%_222 = load i8*, i8** %_221 
	%_223 = bitcast i8* %_222 to i32 (i8* , i32)* 
	%_224 = call i32 %_223( i8* %_215, i32 50) 

	call void (i32) @print_int(i32 %_224)

	%_225 = load i8*, i8** %root
	%_229 = bitcast i8* %_225 to i8*** 
	%_230 = load i8**, i8*** %_229 
	%_231 = getelementptr i8*, i8** %_230, i32 17 
	%_232 = load i8*, i8** %_231 
	%_233 = bitcast i8* %_232 to i32 (i8* , i32)* 
	%_234 = call i32 %_233( i8* %_225, i32 12) 

	call void (i32) @print_int(i32 %_234)

	%_240 = load i8*, i8** %root
	%_244 = bitcast i8* %_240 to i8*** 
	%_245 = load i8**, i8*** %_244 
	%_246 = getelementptr i8*, i8** %_245, i32 13 
	%_247 = load i8*, i8** %_246 
	%_248 = bitcast i8* %_247 to i1 (i8* , i32)* 
	%_249 = call i1 %_248( i8* %_240, i32 12) 

	store i1 %_249,i1* %ntb

	%_255 = load i8*, i8** %root
	%_259 = bitcast i8* %_255 to i8*** 
	%_260 = load i8**, i8*** %_259 
	%_261 = getelementptr i8*, i8** %_260, i32 18 
	%_262 = load i8*, i8** %_261 
	%_263 = bitcast i8* %_262 to i1 (i8* )* 
	%_264 = call i1 %_263( i8* %_255) 

	store i1 %_264,i1* %ntb

	%_265 = load i8*, i8** %root
	%_269 = bitcast i8* %_265 to i8*** 
	%_270 = load i8**, i8*** %_269 
	%_271 = getelementptr i8*, i8** %_270, i32 17 
	%_272 = load i8*, i8** %_271 
	%_273 = bitcast i8* %_272 to i32 (i8* , i32)* 
	%_274 = call i32 %_273( i8* %_265, i32 12) 

	call void (i32) @print_int(i32 %_274)

	ret i32 0
}
 
define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_275 = getelementptr i8, i8* %this, i32 24
	%_276 = bitcast i8* %_275 to i32* 
	%_282 = load i32, i32* %v_key
	store i32 %_282,i32* %_276

	%_283 = getelementptr i8, i8* %this, i32 28
	%_284 = bitcast i8* %_283 to i1* 
	store i1 0,i1* %_284

	%_290 = getelementptr i8, i8* %this, i32 29
	%_291 = bitcast i8* %_290 to i1* 
	store i1 0,i1* %_291

	ret i1 1
}
 
define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_297 = getelementptr i8, i8* %this, i32 16
	%_298 = bitcast i8* %_297 to i8** 
	%_304 = load i8*, i8** %rn
	store i8* %_304,i8** %_298

	ret i1 1
}
 
define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_305 = getelementptr i8, i8* %this, i32 8
	%_306 = bitcast i8* %_305 to i8** 
	%_312 = load i8*, i8** %ln
	store i8* %_312,i8** %_306

	ret i1 1
}
 
define i8* @Tree.GetRight(i8* %this) {
	%_313 = getelementptr i8, i8* %this, i32 16
	%_314 = bitcast i8* %_313 to i8** 
	%_315 = load i8*, i8** %_314
	ret i8* %_315
}
 
define i8* @Tree.GetLeft(i8* %this) {
	%_316 = getelementptr i8, i8* %this, i32 8
	%_317 = bitcast i8* %_316 to i8** 
	%_318 = load i8*, i8** %_317
	ret i8* %_318
}
 
define i32 @Tree.GetKey(i8* %this) {
	%_319 = getelementptr i8, i8* %this, i32 24
	%_320 = bitcast i8* %_319 to i32* 
	%_321 = load i32, i32* %_320
	ret i32 %_321
}
 
define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_322 = getelementptr i8, i8* %this, i32 24
	%_323 = bitcast i8* %_322 to i32* 
	%_329 = load i32, i32* %v_key
	store i32 %_329,i32* %_323

	ret i1 1
}
 
define i1 @Tree.GetHas_Right(i8* %this) {
	%_330 = getelementptr i8, i8* %this, i32 29
	%_331 = bitcast i8* %_330 to i1* 
	%_332 = load i1, i1* %_331
	ret i1 %_332
}
 
define i1 @Tree.GetHas_Left(i8* %this) {
	%_333 = getelementptr i8, i8* %this, i32 28
	%_334 = bitcast i8* %_333 to i1* 
	%_335 = load i1, i1* %_334
	ret i1 %_335
}
 
define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_336 = getelementptr i8, i8* %this, i32 28
	%_337 = bitcast i8* %_336 to i1* 
	%_343 = load i1, i1* %val
	store i1 %_343,i1* %_337

	ret i1 1
}
 
define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_344 = getelementptr i8, i8* %this, i32 29
	%_345 = bitcast i8* %_344 to i1* 
	%_351 = load i1, i1* %val
	store i1 %_351,i1* %_345

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

	%_362 = load i32, i32* %num2
	%_363 = add i32 %_362, 1

	store i32 %_363,i32* %nti

	%_364 = load i32, i32* %num1
	%_365 = load i32, i32* %num2
	%_366 = icmp slt i32 %_364, %_365

	br i1 %_366, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_367 = load i32, i32* %num1
	%_368 = load i32, i32* %nti
	%_369 = icmp slt i32 %_367, %_368

%_370 = xor i1 1, %_369

	br i1 %_370, label %if_then_1, label %if_else_1 
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

	%_386 = load i1, i1* %ntb
	ret i1 %_386
}
 
define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*

	%ntb = alloca i1

	%cont = alloca i1

	%key_aux = alloca i32

	%current_node = alloca i8*

	%_392 = call i8* @calloc(i32 1, i32 38)
	%_393 = bitcast i8* %_392 to i8*** 
	%_394 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0 
	store i8** %_394, i8*** %_393

	store i8* %_392,i8** %new_node

	%_400 = load i8*, i8** %new_node
	%_404 = bitcast i8* %_400 to i8*** 
	%_405 = load i8**, i8*** %_404 
	%_406 = getelementptr i8*, i8** %_405, i32 0 
	%_407 = load i8*, i8** %_406 
	%_408 = bitcast i8* %_407 to i1 (i8* , i32)* 
	%_409 = load i32, i32* %v_key
	%_410 = call i1 %_408( i8* %_400, i32 %_409) 

	store i1 %_410,i1* %ntb

	store i8* %this,i8** %current_node

	store i1 1,i1* %cont

	br label %loop2
	loop2: 
	%_421 = load i1, i1* %cont
	br i1 %_421, label %loop3, label %loop4 
	loop3: 
	%_427 = load i8*, i8** %current_node
	%_431 = bitcast i8* %_427 to i8*** 
	%_432 = load i8**, i8*** %_431 
	%_433 = getelementptr i8*, i8** %_432, i32 5 
	%_434 = load i8*, i8** %_433 
	%_435 = bitcast i8* %_434 to i32 (i8* )* 
	%_436 = call i32 %_435( i8* %_427) 

	store i32 %_436,i32* %key_aux

	%_437 = load i32, i32* %v_key
	%_438 = load i32, i32* %key_aux
	%_439 = icmp slt i32 %_437, %_438

	br i1 %_439, label %if_then_5, label %if_else_5 
	if_else_5: 
	%_440 = load i8*, i8** %current_node
	%_444 = bitcast i8* %_440 to i8*** 
	%_445 = load i8**, i8*** %_444 
	%_446 = getelementptr i8*, i8** %_445, i32 7 
	%_447 = load i8*, i8** %_446 
	%_448 = bitcast i8* %_447 to i1 (i8* )* 
	%_449 = call i1 %_448( i8* %_440) 

	br i1 %_449, label %if_then_6, label %if_else_6 
	if_else_6: 
	store i1 0,i1* %cont

	%_460 = load i8*, i8** %current_node
	%_464 = bitcast i8* %_460 to i8*** 
	%_465 = load i8**, i8*** %_464 
	%_466 = getelementptr i8*, i8** %_465, i32 10 
	%_467 = load i8*, i8** %_466 
	%_468 = bitcast i8* %_467 to i1 (i8* , i1)* 
	%_469 = call i1 %_468( i8* %_460, i1 1) 

	store i1 %_469,i1* %ntb

	%_475 = load i8*, i8** %current_node
	%_479 = bitcast i8* %_475 to i8*** 
	%_480 = load i8**, i8*** %_479 
	%_481 = getelementptr i8*, i8** %_480, i32 1 
	%_482 = load i8*, i8** %_481 
	%_483 = bitcast i8* %_482 to i1 (i8* , i8*)* 
	%_484 = load i8*, i8** %new_node
	%_485 = call i1 %_483( i8* %_475, i8* %_484) 

	store i1 %_485,i1* %ntb

	br label %if_end_6
	if_then_6: 
	%_491 = load i8*, i8** %current_node
	%_495 = bitcast i8* %_491 to i8*** 
	%_496 = load i8**, i8*** %_495 
	%_497 = getelementptr i8*, i8** %_496, i32 3 
	%_498 = load i8*, i8** %_497 
	%_499 = bitcast i8* %_498 to i8* (i8* )* 
	%_500 = call i8* %_499( i8* %_491) 

	store i8* %_500,i8** %current_node

	br label %if_end_6
	if_end_6: 

	br label %if_end_5
	if_then_5: 
	%_501 = load i8*, i8** %current_node
	%_505 = bitcast i8* %_501 to i8*** 
	%_506 = load i8**, i8*** %_505 
	%_507 = getelementptr i8*, i8** %_506, i32 8 
	%_508 = load i8*, i8** %_507 
	%_509 = bitcast i8* %_508 to i1 (i8* )* 
	%_510 = call i1 %_509( i8* %_501) 

	br i1 %_510, label %if_then_7, label %if_else_7 
	if_else_7: 
	store i1 0,i1* %cont

	%_521 = load i8*, i8** %current_node
	%_525 = bitcast i8* %_521 to i8*** 
	%_526 = load i8**, i8*** %_525 
	%_527 = getelementptr i8*, i8** %_526, i32 9 
	%_528 = load i8*, i8** %_527 
	%_529 = bitcast i8* %_528 to i1 (i8* , i1)* 
	%_530 = call i1 %_529( i8* %_521, i1 1) 

	store i1 %_530,i1* %ntb

	%_536 = load i8*, i8** %current_node
	%_540 = bitcast i8* %_536 to i8*** 
	%_541 = load i8**, i8*** %_540 
	%_542 = getelementptr i8*, i8** %_541, i32 2 
	%_543 = load i8*, i8** %_542 
	%_544 = bitcast i8* %_543 to i1 (i8* , i8*)* 
	%_545 = load i8*, i8** %new_node
	%_546 = call i1 %_544( i8* %_536, i8* %_545) 

	store i1 %_546,i1* %ntb

	br label %if_end_7
	if_then_7: 
	%_552 = load i8*, i8** %current_node
	%_556 = bitcast i8* %_552 to i8*** 
	%_557 = load i8**, i8*** %_556 
	%_558 = getelementptr i8*, i8** %_557, i32 4 
	%_559 = load i8*, i8** %_558 
	%_560 = bitcast i8* %_559 to i8* (i8* )* 
	%_561 = call i8* %_560( i8* %_552) 

	store i8* %_561,i8** %current_node

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
	%_587 = load i1, i1* %cont
	br i1 %_587, label %loop9, label %loop10 
	loop9: 
	%_593 = load i8*, i8** %current_node
	%_597 = bitcast i8* %_593 to i8*** 
	%_598 = load i8**, i8*** %_597 
	%_599 = getelementptr i8*, i8** %_598, i32 5 
	%_600 = load i8*, i8** %_599 
	%_601 = bitcast i8* %_600 to i32 (i8* )* 
	%_602 = call i32 %_601( i8* %_593) 

	store i32 %_602,i32* %key_aux

	%_603 = load i32, i32* %v_key
	%_604 = load i32, i32* %key_aux
	%_605 = icmp slt i32 %_603, %_604

	br i1 %_605, label %if_then_11, label %if_else_11 
	if_else_11: 
	%_606 = load i32, i32* %key_aux
	%_607 = load i32, i32* %v_key
	%_608 = icmp slt i32 %_606, %_607

	br i1 %_608, label %if_then_12, label %if_else_12 
	if_else_12: 
	%_609 = load i1, i1* %is_root
	br i1 %_609, label %if_then_13, label %if_else_13 
	if_else_13: 
	%_618 = bitcast i8* %this to i8*** 
	%_619 = load i8**, i8*** %_618 
	%_620 = getelementptr i8*, i8** %_619, i32 14 
	%_621 = load i8*, i8** %_620 
	%_622 = bitcast i8* %_621 to i1 (i8* , i8*, i8*)* 
	%_623 = load i8*, i8** %parent_node
	%_624 = load i8*, i8** %current_node
	%_625 = call i1 %_622( i8* %this, i8* %_623, i8* %_624) 

	store i1 %_625,i1* %ntb

	br label %if_end_13
	if_then_13: 
	%_626 = load i8*, i8** %current_node
	%_630 = bitcast i8* %_626 to i8*** 
	%_631 = load i8**, i8*** %_630 
	%_632 = getelementptr i8*, i8** %_631, i32 7 
	%_633 = load i8*, i8** %_632 
	%_634 = bitcast i8* %_633 to i1 (i8* )* 
	%_635 = call i1 %_634( i8* %_626) 

%_636 = xor i1 1, %_635

	br i1 %_636, label %and_clause16, label %and_clause15 
	and_clause15: 
	br label %and_clause17
	and_clause16: 
	%_637 = load i8*, i8** %current_node
	%_641 = bitcast i8* %_637 to i8*** 
	%_642 = load i8**, i8*** %_641 
	%_643 = getelementptr i8*, i8** %_642, i32 8 
	%_644 = load i8*, i8** %_643 
	%_645 = bitcast i8* %_644 to i1 (i8* )* 
	%_646 = call i1 %_645( i8* %_637) 

%_647 = xor i1 1, %_646

	br label %and_clause17
	and_clause17: 
	br label %and_clause18
	and_clause18: 
	%_648 = phi i1 [ 0, %and_clause15 ], [ %_647, %and_clause17] 

	br i1 %_648, label %if_then_14, label %if_else_14 
	if_else_14: 
	%_657 = bitcast i8* %this to i8*** 
	%_658 = load i8**, i8*** %_657 
	%_659 = getelementptr i8*, i8** %_658, i32 14 
	%_660 = load i8*, i8** %_659 
	%_661 = bitcast i8* %_660 to i1 (i8* , i8*, i8*)* 
	%_662 = load i8*, i8** %parent_node
	%_663 = load i8*, i8** %current_node
	%_664 = call i1 %_661( i8* %this, i8* %_662, i8* %_663) 

	store i1 %_664,i1* %ntb

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
	%_680 = load i8*, i8** %current_node
	%_684 = bitcast i8* %_680 to i8*** 
	%_685 = load i8**, i8*** %_684 
	%_686 = getelementptr i8*, i8** %_685, i32 7 
	%_687 = load i8*, i8** %_686 
	%_688 = bitcast i8* %_687 to i1 (i8* )* 
	%_689 = call i1 %_688( i8* %_680) 

	br i1 %_689, label %if_then_19, label %if_else_19 
	if_else_19: 
	store i1 0,i1* %cont

	br label %if_end_19
	if_then_19: 
	%_700 = load i8*, i8** %current_node
	store i8* %_700,i8** %parent_node

	%_706 = load i8*, i8** %current_node
	%_710 = bitcast i8* %_706 to i8*** 
	%_711 = load i8**, i8*** %_710 
	%_712 = getelementptr i8*, i8** %_711, i32 3 
	%_713 = load i8*, i8** %_712 
	%_714 = bitcast i8* %_713 to i8* (i8* )* 
	%_715 = call i8* %_714( i8* %_706) 

	store i8* %_715,i8** %current_node

	br label %if_end_19
	if_end_19: 

	br label %if_end_12
	if_end_12: 

	br label %if_end_11
	if_then_11: 
	%_716 = load i8*, i8** %current_node
	%_720 = bitcast i8* %_716 to i8*** 
	%_721 = load i8**, i8*** %_720 
	%_722 = getelementptr i8*, i8** %_721, i32 8 
	%_723 = load i8*, i8** %_722 
	%_724 = bitcast i8* %_723 to i1 (i8* )* 
	%_725 = call i1 %_724( i8* %_716) 

	br i1 %_725, label %if_then_20, label %if_else_20 
	if_else_20: 
	store i1 0,i1* %cont

	br label %if_end_20
	if_then_20: 
	%_736 = load i8*, i8** %current_node
	store i8* %_736,i8** %parent_node

	%_742 = load i8*, i8** %current_node
	%_746 = bitcast i8* %_742 to i8*** 
	%_747 = load i8**, i8*** %_746 
	%_748 = getelementptr i8*, i8** %_747, i32 4 
	%_749 = load i8*, i8** %_748 
	%_750 = bitcast i8* %_749 to i8* (i8* )* 
	%_751 = call i8* %_750( i8* %_742) 

	store i8* %_751,i8** %current_node

	br label %if_end_20
	if_end_20: 

	br label %if_end_11
	if_end_11: 

	store i1 0,i1* %is_root

	br label %loop8
	loop10: 

	%_757 = load i1, i1* %found
	ret i1 %_757
}
 
define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1

	%auxkey1 = alloca i32

	%auxkey2 = alloca i32

	%_758 = load i8*, i8** %c_node
	%_762 = bitcast i8* %_758 to i8*** 
	%_763 = load i8**, i8*** %_762 
	%_764 = getelementptr i8*, i8** %_763, i32 8 
	%_765 = load i8*, i8** %_764 
	%_766 = bitcast i8* %_765 to i1 (i8* )* 
	%_767 = call i1 %_766( i8* %_758) 

	br i1 %_767, label %if_then_21, label %if_else_21 
	if_else_21: 
	%_768 = load i8*, i8** %c_node
	%_772 = bitcast i8* %_768 to i8*** 
	%_773 = load i8**, i8*** %_772 
	%_774 = getelementptr i8*, i8** %_773, i32 7 
	%_775 = load i8*, i8** %_774 
	%_776 = bitcast i8* %_775 to i1 (i8* )* 
	%_777 = call i1 %_776( i8* %_768) 

	br i1 %_777, label %if_then_22, label %if_else_22 
	if_else_22: 
	%_783 = load i8*, i8** %c_node
	%_787 = bitcast i8* %_783 to i8*** 
	%_788 = load i8**, i8*** %_787 
	%_789 = getelementptr i8*, i8** %_788, i32 5 
	%_790 = load i8*, i8** %_789 
	%_791 = bitcast i8* %_790 to i32 (i8* )* 
	%_792 = call i32 %_791( i8* %_783) 

	store i32 %_792,i32* %auxkey1

	%_798 = load i8*, i8** %p_node
	%_802 = bitcast i8* %_798 to i8*** 
	%_803 = load i8**, i8*** %_802 
	%_804 = getelementptr i8*, i8** %_803, i32 4 
	%_805 = load i8*, i8** %_804 
	%_806 = bitcast i8* %_805 to i8* (i8* )* 
	%_807 = call i8* %_806( i8* %_798) 

	%_808 = load i8*, i8** %p_node
	%_812 = bitcast i8* %_808 to i8*** 
	%_813 = load i8**, i8*** %_812 
	%_814 = getelementptr i8*, i8** %_813, i32 4 
	%_815 = load i8*, i8** %_814 
	%_816 = bitcast i8* %_815 to i8* (i8* )* 
	%_817 = call i8* %_816( i8* %_808) 

	%_821 = bitcast i8* %_817 to i8*** 
	%_822 = load i8**, i8*** %_821 
	%_823 = getelementptr i8*, i8** %_822, i32 5 
	%_824 = load i8*, i8** %_823 
	%_825 = bitcast i8* %_824 to i32 (i8* )* 
	%_826 = call i32 %_825( i8* %_817) 

	store i32 %_826,i32* %auxkey2

	%_830 = bitcast i8* %this to i8*** 
	%_831 = load i8**, i8*** %_830 
	%_832 = getelementptr i8*, i8** %_831, i32 11 
	%_833 = load i8*, i8** %_832 
	%_834 = bitcast i8* %_833 to i1 (i8* , i32, i32)* 
	%_835 = load i32, i32* %auxkey1
	%_836 = load i32, i32* %auxkey2
	%_837 = call i1 %_834( i8* %this, i32 %_835, i32 %_836) 

	br i1 %_837, label %if_then_23, label %if_else_23 
	if_else_23: 
	%_843 = load i8*, i8** %p_node
	%_847 = bitcast i8* %_843 to i8*** 
	%_848 = load i8**, i8*** %_847 
	%_849 = getelementptr i8*, i8** %_848, i32 1 
	%_850 = load i8*, i8** %_849 
	%_851 = bitcast i8* %_850 to i1 (i8* , i8*)* 
	%_852 = getelementptr i8, i8* %this, i32 30
	%_853 = bitcast i8* %_852 to i8** 
	%_854 = load i8*, i8** %_853
	%_855 = call i1 %_851( i8* %_843, i8* %_854) 

	store i1 %_855,i1* %ntb

	%_861 = load i8*, i8** %p_node
	%_865 = bitcast i8* %_861 to i8*** 
	%_866 = load i8**, i8*** %_865 
	%_867 = getelementptr i8*, i8** %_866, i32 10 
	%_868 = load i8*, i8** %_867 
	%_869 = bitcast i8* %_868 to i1 (i8* , i1)* 
	%_870 = call i1 %_869( i8* %_861, i1 0) 

	store i1 %_870,i1* %ntb

	br label %if_end_23
	if_then_23: 
	%_876 = load i8*, i8** %p_node
	%_880 = bitcast i8* %_876 to i8*** 
	%_881 = load i8**, i8*** %_880 
	%_882 = getelementptr i8*, i8** %_881, i32 2 
	%_883 = load i8*, i8** %_882 
	%_884 = bitcast i8* %_883 to i1 (i8* , i8*)* 
	%_885 = getelementptr i8, i8* %this, i32 30
	%_886 = bitcast i8* %_885 to i8** 
	%_887 = load i8*, i8** %_886
	%_888 = call i1 %_884( i8* %_876, i8* %_887) 

	store i1 %_888,i1* %ntb

	%_894 = load i8*, i8** %p_node
	%_898 = bitcast i8* %_894 to i8*** 
	%_899 = load i8**, i8*** %_898 
	%_900 = getelementptr i8*, i8** %_899, i32 9 
	%_901 = load i8*, i8** %_900 
	%_902 = bitcast i8* %_901 to i1 (i8* , i1)* 
	%_903 = call i1 %_902( i8* %_894, i1 0) 

	store i1 %_903,i1* %ntb

	br label %if_end_23
	if_end_23: 

	br label %if_end_22
	if_then_22: 
	%_912 = bitcast i8* %this to i8*** 
	%_913 = load i8**, i8*** %_912 
	%_914 = getelementptr i8*, i8** %_913, i32 15 
	%_915 = load i8*, i8** %_914 
	%_916 = bitcast i8* %_915 to i1 (i8* , i8*, i8*)* 
	%_917 = load i8*, i8** %p_node
	%_918 = load i8*, i8** %c_node
	%_919 = call i1 %_916( i8* %this, i8* %_917, i8* %_918) 

	store i1 %_919,i1* %ntb

	br label %if_end_22
	if_end_22: 

	br label %if_end_21
	if_then_21: 
	%_928 = bitcast i8* %this to i8*** 
	%_929 = load i8**, i8*** %_928 
	%_930 = getelementptr i8*, i8** %_929, i32 16 
	%_931 = load i8*, i8** %_930 
	%_932 = bitcast i8* %_931 to i1 (i8* , i8*, i8*)* 
	%_933 = load i8*, i8** %p_node
	%_934 = load i8*, i8** %c_node
	%_935 = call i1 %_932( i8* %this, i8* %_933, i8* %_934) 

	store i1 %_935,i1* %ntb

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
	%_936 = load i8*, i8** %c_node
	%_940 = bitcast i8* %_936 to i8*** 
	%_941 = load i8**, i8*** %_940 
	%_942 = getelementptr i8*, i8** %_941, i32 7 
	%_943 = load i8*, i8** %_942 
	%_944 = bitcast i8* %_943 to i1 (i8* )* 
	%_945 = call i1 %_944( i8* %_936) 

	br i1 %_945, label %loop25, label %loop26 
	loop25: 
	%_951 = load i8*, i8** %c_node
	%_955 = bitcast i8* %_951 to i8*** 
	%_956 = load i8**, i8*** %_955 
	%_957 = getelementptr i8*, i8** %_956, i32 6 
	%_958 = load i8*, i8** %_957 
	%_959 = bitcast i8* %_958 to i1 (i8* , i32)* 
	%_960 = load i8*, i8** %c_node
	%_964 = bitcast i8* %_960 to i8*** 
	%_965 = load i8**, i8*** %_964 
	%_966 = getelementptr i8*, i8** %_965, i32 3 
	%_967 = load i8*, i8** %_966 
	%_968 = bitcast i8* %_967 to i8* (i8* )* 
	%_969 = call i8* %_968( i8* %_960) 

	%_970 = load i8*, i8** %c_node
	%_974 = bitcast i8* %_970 to i8*** 
	%_975 = load i8**, i8*** %_974 
	%_976 = getelementptr i8*, i8** %_975, i32 3 
	%_977 = load i8*, i8** %_976 
	%_978 = bitcast i8* %_977 to i8* (i8* )* 
	%_979 = call i8* %_978( i8* %_970) 

	%_983 = bitcast i8* %_979 to i8*** 
	%_984 = load i8**, i8*** %_983 
	%_985 = getelementptr i8*, i8** %_984, i32 5 
	%_986 = load i8*, i8** %_985 
	%_987 = bitcast i8* %_986 to i32 (i8* )* 
	%_988 = call i32 %_987( i8* %_979) 

	%_989 = call i1 %_959( i8* %_951, i32 %_988) 

	store i1 %_989,i1* %ntb

	%_995 = load i8*, i8** %c_node
	store i8* %_995,i8** %p_node

	%_1001 = load i8*, i8** %c_node
	%_1005 = bitcast i8* %_1001 to i8*** 
	%_1006 = load i8**, i8*** %_1005 
	%_1007 = getelementptr i8*, i8** %_1006, i32 3 
	%_1008 = load i8*, i8** %_1007 
	%_1009 = bitcast i8* %_1008 to i8* (i8* )* 
	%_1010 = call i8* %_1009( i8* %_1001) 

	store i8* %_1010,i8** %c_node

	br label %loop24
	loop26: 

	%_1016 = load i8*, i8** %p_node
	%_1020 = bitcast i8* %_1016 to i8*** 
	%_1021 = load i8**, i8*** %_1020 
	%_1022 = getelementptr i8*, i8** %_1021, i32 1 
	%_1023 = load i8*, i8** %_1022 
	%_1024 = bitcast i8* %_1023 to i1 (i8* , i8*)* 
	%_1025 = getelementptr i8, i8* %this, i32 30
	%_1026 = bitcast i8* %_1025 to i8** 
	%_1027 = load i8*, i8** %_1026
	%_1028 = call i1 %_1024( i8* %_1016, i8* %_1027) 

	store i1 %_1028,i1* %ntb

	%_1034 = load i8*, i8** %p_node
	%_1038 = bitcast i8* %_1034 to i8*** 
	%_1039 = load i8**, i8*** %_1038 
	%_1040 = getelementptr i8*, i8** %_1039, i32 10 
	%_1041 = load i8*, i8** %_1040 
	%_1042 = bitcast i8* %_1041 to i1 (i8* , i1)* 
	%_1043 = call i1 %_1042( i8* %_1034, i1 0) 

	store i1 %_1043,i1* %ntb

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
	%_1044 = load i8*, i8** %c_node
	%_1048 = bitcast i8* %_1044 to i8*** 
	%_1049 = load i8**, i8*** %_1048 
	%_1050 = getelementptr i8*, i8** %_1049, i32 8 
	%_1051 = load i8*, i8** %_1050 
	%_1052 = bitcast i8* %_1051 to i1 (i8* )* 
	%_1053 = call i1 %_1052( i8* %_1044) 

	br i1 %_1053, label %loop28, label %loop29 
	loop28: 
	%_1059 = load i8*, i8** %c_node
	%_1063 = bitcast i8* %_1059 to i8*** 
	%_1064 = load i8**, i8*** %_1063 
	%_1065 = getelementptr i8*, i8** %_1064, i32 6 
	%_1066 = load i8*, i8** %_1065 
	%_1067 = bitcast i8* %_1066 to i1 (i8* , i32)* 
	%_1068 = load i8*, i8** %c_node
	%_1072 = bitcast i8* %_1068 to i8*** 
	%_1073 = load i8**, i8*** %_1072 
	%_1074 = getelementptr i8*, i8** %_1073, i32 4 
	%_1075 = load i8*, i8** %_1074 
	%_1076 = bitcast i8* %_1075 to i8* (i8* )* 
	%_1077 = call i8* %_1076( i8* %_1068) 

	%_1078 = load i8*, i8** %c_node
	%_1082 = bitcast i8* %_1078 to i8*** 
	%_1083 = load i8**, i8*** %_1082 
	%_1084 = getelementptr i8*, i8** %_1083, i32 4 
	%_1085 = load i8*, i8** %_1084 
	%_1086 = bitcast i8* %_1085 to i8* (i8* )* 
	%_1087 = call i8* %_1086( i8* %_1078) 

	%_1091 = bitcast i8* %_1087 to i8*** 
	%_1092 = load i8**, i8*** %_1091 
	%_1093 = getelementptr i8*, i8** %_1092, i32 5 
	%_1094 = load i8*, i8** %_1093 
	%_1095 = bitcast i8* %_1094 to i32 (i8* )* 
	%_1096 = call i32 %_1095( i8* %_1087) 

	%_1097 = call i1 %_1067( i8* %_1059, i32 %_1096) 

	store i1 %_1097,i1* %ntb

	%_1103 = load i8*, i8** %c_node
	store i8* %_1103,i8** %p_node

	%_1109 = load i8*, i8** %c_node
	%_1113 = bitcast i8* %_1109 to i8*** 
	%_1114 = load i8**, i8*** %_1113 
	%_1115 = getelementptr i8*, i8** %_1114, i32 4 
	%_1116 = load i8*, i8** %_1115 
	%_1117 = bitcast i8* %_1116 to i8* (i8* )* 
	%_1118 = call i8* %_1117( i8* %_1109) 

	store i8* %_1118,i8** %c_node

	br label %loop27
	loop29: 

	%_1124 = load i8*, i8** %p_node
	%_1128 = bitcast i8* %_1124 to i8*** 
	%_1129 = load i8**, i8*** %_1128 
	%_1130 = getelementptr i8*, i8** %_1129, i32 2 
	%_1131 = load i8*, i8** %_1130 
	%_1132 = bitcast i8* %_1131 to i1 (i8* , i8*)* 
	%_1133 = getelementptr i8, i8* %this, i32 30
	%_1134 = bitcast i8* %_1133 to i8** 
	%_1135 = load i8*, i8** %_1134
	%_1136 = call i1 %_1132( i8* %_1124, i8* %_1135) 

	store i1 %_1136,i1* %ntb

	%_1142 = load i8*, i8** %p_node
	%_1146 = bitcast i8* %_1142 to i8*** 
	%_1147 = load i8**, i8*** %_1146 
	%_1148 = getelementptr i8*, i8** %_1147, i32 9 
	%_1149 = load i8*, i8** %_1148 
	%_1150 = bitcast i8* %_1149 to i1 (i8* , i1)* 
	%_1151 = call i1 %_1150( i8* %_1142, i1 0) 

	store i1 %_1151,i1* %ntb

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
	%_1167 = load i1, i1* %cont
	br i1 %_1167, label %loop31, label %loop32 
	loop31: 
	%_1173 = load i8*, i8** %current_node
	%_1177 = bitcast i8* %_1173 to i8*** 
	%_1178 = load i8**, i8*** %_1177 
	%_1179 = getelementptr i8*, i8** %_1178, i32 5 
	%_1180 = load i8*, i8** %_1179 
	%_1181 = bitcast i8* %_1180 to i32 (i8* )* 
	%_1182 = call i32 %_1181( i8* %_1173) 

	store i32 %_1182,i32* %key_aux

	%_1183 = load i32, i32* %v_key
	%_1184 = load i32, i32* %key_aux
	%_1185 = icmp slt i32 %_1183, %_1184

	br i1 %_1185, label %if_then_33, label %if_else_33 
	if_else_33: 
	%_1186 = load i32, i32* %key_aux
	%_1187 = load i32, i32* %v_key
	%_1188 = icmp slt i32 %_1186, %_1187

	br i1 %_1188, label %if_then_34, label %if_else_34 
	if_else_34: 
	store i32 1,i32* %ifound

	store i1 0,i1* %cont

	br label %if_end_34
	if_then_34: 
	%_1199 = load i8*, i8** %current_node
	%_1203 = bitcast i8* %_1199 to i8*** 
	%_1204 = load i8**, i8*** %_1203 
	%_1205 = getelementptr i8*, i8** %_1204, i32 7 
	%_1206 = load i8*, i8** %_1205 
	%_1207 = bitcast i8* %_1206 to i1 (i8* )* 
	%_1208 = call i1 %_1207( i8* %_1199) 

	br i1 %_1208, label %if_then_35, label %if_else_35 
	if_else_35: 
	store i1 0,i1* %cont

	br label %if_end_35
	if_then_35: 
	%_1219 = load i8*, i8** %current_node
	%_1223 = bitcast i8* %_1219 to i8*** 
	%_1224 = load i8**, i8*** %_1223 
	%_1225 = getelementptr i8*, i8** %_1224, i32 3 
	%_1226 = load i8*, i8** %_1225 
	%_1227 = bitcast i8* %_1226 to i8* (i8* )* 
	%_1228 = call i8* %_1227( i8* %_1219) 

	store i8* %_1228,i8** %current_node

	br label %if_end_35
	if_end_35: 

	br label %if_end_34
	if_end_34: 

	br label %if_end_33
	if_then_33: 
	%_1229 = load i8*, i8** %current_node
	%_1233 = bitcast i8* %_1229 to i8*** 
	%_1234 = load i8**, i8*** %_1233 
	%_1235 = getelementptr i8*, i8** %_1234, i32 8 
	%_1236 = load i8*, i8** %_1235 
	%_1237 = bitcast i8* %_1236 to i1 (i8* )* 
	%_1238 = call i1 %_1237( i8* %_1229) 

	br i1 %_1238, label %if_then_36, label %if_else_36 
	if_else_36: 
	store i1 0,i1* %cont

	br label %if_end_36
	if_then_36: 
	%_1249 = load i8*, i8** %current_node
	%_1253 = bitcast i8* %_1249 to i8*** 
	%_1254 = load i8**, i8*** %_1253 
	%_1255 = getelementptr i8*, i8** %_1254, i32 4 
	%_1256 = load i8*, i8** %_1255 
	%_1257 = bitcast i8* %_1256 to i8* (i8* )* 
	%_1258 = call i8* %_1257( i8* %_1249) 

	store i8* %_1258,i8** %current_node

	br label %if_end_36
	if_end_36: 

	br label %if_end_33
	if_end_33: 

	br label %loop30
	loop32: 

	%_1259 = load i32, i32* %ifound
	ret i32 %_1259
}
 
define i1 @Tree.Print(i8* %this) {
	%current_node = alloca i8*

	%ntb = alloca i1

	store i8* %this,i8** %current_node

	%_1273 = bitcast i8* %this to i8*** 
	%_1274 = load i8**, i8*** %_1273 
	%_1275 = getelementptr i8*, i8** %_1274, i32 19 
	%_1276 = load i8*, i8** %_1275 
	%_1277 = bitcast i8* %_1276 to i1 (i8* , i8*)* 
	%_1278 = load i8*, i8** %current_node
	%_1279 = call i1 %_1277( i8* %this, i8* %_1278) 

	store i1 %_1279,i1* %ntb

	ret i1 1
}
 
define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1

	%_1280 = load i8*, i8** %node
	%_1284 = bitcast i8* %_1280 to i8*** 
	%_1285 = load i8**, i8*** %_1284 
	%_1286 = getelementptr i8*, i8** %_1285, i32 8 
	%_1287 = load i8*, i8** %_1286 
	%_1288 = bitcast i8* %_1287 to i1 (i8* )* 
	%_1289 = call i1 %_1288( i8* %_1280) 

	br i1 %_1289, label %if_then_37, label %if_else_37 
	if_else_37: 
	store i1 1,i1* %ntb

	br label %if_end_37
	if_then_37: 
	%_1303 = bitcast i8* %this to i8*** 
	%_1304 = load i8**, i8*** %_1303 
	%_1305 = getelementptr i8*, i8** %_1304, i32 19 
	%_1306 = load i8*, i8** %_1305 
	%_1307 = bitcast i8* %_1306 to i1 (i8* , i8*)* 
	%_1308 = load i8*, i8** %node
	%_1312 = bitcast i8* %_1308 to i8*** 
	%_1313 = load i8**, i8*** %_1312 
	%_1314 = getelementptr i8*, i8** %_1313, i32 4 
	%_1315 = load i8*, i8** %_1314 
	%_1316 = bitcast i8* %_1315 to i8* (i8* )* 
	%_1317 = call i8* %_1316( i8* %_1308) 

	%_1318 = call i1 %_1307( i8* %this, i8* %_1317) 

	store i1 %_1318,i1* %ntb

	br label %if_end_37
	if_end_37: 

	%_1319 = load i8*, i8** %node
	%_1323 = bitcast i8* %_1319 to i8*** 
	%_1324 = load i8**, i8*** %_1323 
	%_1325 = getelementptr i8*, i8** %_1324, i32 5 
	%_1326 = load i8*, i8** %_1325 
	%_1327 = bitcast i8* %_1326 to i32 (i8* )* 
	%_1328 = call i32 %_1327( i8* %_1319) 

	call void (i32) @print_int(i32 %_1328)

	%_1329 = load i8*, i8** %node
	%_1333 = bitcast i8* %_1329 to i8*** 
	%_1334 = load i8**, i8*** %_1333 
	%_1335 = getelementptr i8*, i8** %_1334, i32 7 
	%_1336 = load i8*, i8** %_1335 
	%_1337 = bitcast i8* %_1336 to i1 (i8* )* 
	%_1338 = call i1 %_1337( i8* %_1329) 

	br i1 %_1338, label %if_then_38, label %if_else_38 
	if_else_38: 
	store i1 1,i1* %ntb

	br label %if_end_38
	if_then_38: 
	%_1352 = bitcast i8* %this to i8*** 
	%_1353 = load i8**, i8*** %_1352 
	%_1354 = getelementptr i8*, i8** %_1353, i32 19 
	%_1355 = load i8*, i8** %_1354 
	%_1356 = bitcast i8* %_1355 to i1 (i8* , i8*)* 
	%_1357 = load i8*, i8** %node
	%_1361 = bitcast i8* %_1357 to i8*** 
	%_1362 = load i8**, i8*** %_1361 
	%_1363 = getelementptr i8*, i8** %_1362, i32 3 
	%_1364 = load i8*, i8** %_1363 
	%_1365 = bitcast i8* %_1364 to i8* (i8* )* 
	%_1366 = call i8* %_1365( i8* %_1357) 

	%_1367 = call i1 %_1356( i8* %this, i8* %_1366) 

	store i1 %_1367,i1* %ntb

	br label %if_end_38
	if_end_38: 

	ret i1 1
}
 
