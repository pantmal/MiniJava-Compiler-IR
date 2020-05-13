@.LinkedList_vtable = global [0 x i8*] [] 
 
@.Element_vtable = global [ 6 x i8*] [  
	i8* bitcast (i1 (i8*,i32,i32,i1)* @Element.Init to i8*),
	i8* bitcast (i32 (i8*)* @Element.GetAge to i8*),
	i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*),
	i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*),
	i8* bitcast (i1 (i8*,i8*)* @Element.Equal to i8*),
	i8* bitcast (i1 (i8*,i32,i32)* @Element.Compare to i8*)
]
 
@.List_vtable = global [ 10 x i8*] [  
	i8* bitcast (i1 (i8*)* @List.Init to i8*),
	i8* bitcast (i1 (i8*,i8*,i8*,i1)* @List.InitNew to i8*),
	i8* bitcast (i8* (i8*,i8*)* @List.Insert to i8*),
	i8* bitcast (i1 (i8*,i8*)* @List.SetNext to i8*),
	i8* bitcast (i8* (i8*,i8*)* @List.Delete to i8*),
	i8* bitcast (i32 (i8*,i8*)* @List.Search to i8*),
	i8* bitcast (i1 (i8*)* @List.GetEnd to i8*),
	i8* bitcast (i8* (i8*)* @List.GetElem to i8*),
	i8* bitcast (i8* (i8*)* @List.GetNext to i8*),
	i8* bitcast (i1 (i8*)* @List.Print to i8*)
]
 
@.LL_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @LL.Start to i8*)
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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0 
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
 
define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
	%v_Age = alloca i32
	store i32 %.v_Age, i32* %v_Age
	%v_Salary = alloca i32
	store i32 %.v_Salary, i32* %v_Salary
	%v_Married = alloca i1
	store i1 %.v_Married, i1* %v_Married
	%_12 = getelementptr i8, i8* %this, i32 8
	%_13 = bitcast i8* %_12 to i32* 
	%_19 = load i32, i32* %v_Age
	store i32 %_19,i32* %_13

	%_20 = getelementptr i8, i8* %this, i32 12
	%_21 = bitcast i8* %_20 to i32* 
	%_27 = load i32, i32* %v_Salary
	store i32 %_27,i32* %_21

	%_28 = getelementptr i8, i8* %this, i32 16
	%_29 = bitcast i8* %_28 to i1* 
	%_35 = load i1, i1* %v_Married
	store i1 %_35,i1* %_29

	ret i1 1
}
 
define i32 @Element.GetAge(i8* %this) {
	%_36 = getelementptr i8, i8* %this, i32 8
	%_37 = bitcast i8* %_36 to i32* 
	%_38 = load i32, i32* %_37
	ret i32 %_38
}
 
define i32 @Element.GetSalary(i8* %this) {
	%_39 = getelementptr i8, i8* %this, i32 12
	%_40 = bitcast i8* %_39 to i32* 
	%_41 = load i32, i32* %_40
	ret i32 %_41
}
 
define i1 @Element.GetMarried(i8* %this) {
	%_42 = getelementptr i8, i8* %this, i32 16
	%_43 = bitcast i8* %_42 to i1* 
	%_44 = load i1, i1* %_43
	ret i1 %_44
}
 
define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1

	%aux01 = alloca i32

	%aux02 = alloca i32

	%nt = alloca i32

	store i1 1,i1* %ret_val

	%_55 = load i8*, i8** %other
	%_59 = bitcast i8* %_55 to i8*** 
	%_60 = load i8**, i8*** %_59 
	%_61 = getelementptr i8*, i8** %_60, i32 1 
	%_62 = load i8*, i8** %_61 
	%_63 = bitcast i8* %_62 to i32 (i8* )* 
	%_64 = call i32 %_63( i8* %_55) 

	store i32 %_64,i32* %aux01

	%_68 = bitcast i8* %this to i8*** 
	%_69 = load i8**, i8*** %_68 
	%_70 = getelementptr i8*, i8** %_69, i32 5 
	%_71 = load i8*, i8** %_70 
	%_72 = bitcast i8* %_71 to i1 (i8* , i32, i32)* 
	%_73 = load i32, i32* %aux01
	%_74 = getelementptr i8, i8* %this, i32 8
	%_75 = bitcast i8* %_74 to i32* 
	%_76 = load i32, i32* %_75
	%_77 = call i1 %_72( i8* %this, i32 %_73, i32 %_76) 

%_78 = xor i1 1, %_77

	br i1 %_78, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_84 = load i8*, i8** %other
	%_88 = bitcast i8* %_84 to i8*** 
	%_89 = load i8**, i8*** %_88 
	%_90 = getelementptr i8*, i8** %_89, i32 2 
	%_91 = load i8*, i8** %_90 
	%_92 = bitcast i8* %_91 to i32 (i8* )* 
	%_93 = call i32 %_92( i8* %_84) 

	store i32 %_93,i32* %aux02

	%_97 = bitcast i8* %this to i8*** 
	%_98 = load i8**, i8*** %_97 
	%_99 = getelementptr i8*, i8** %_98, i32 5 
	%_100 = load i8*, i8** %_99 
	%_101 = bitcast i8* %_100 to i1 (i8* , i32, i32)* 
	%_102 = load i32, i32* %aux02
	%_103 = getelementptr i8, i8* %this, i32 12
	%_104 = bitcast i8* %_103 to i32* 
	%_105 = load i32, i32* %_104
	%_106 = call i1 %_101( i8* %this, i32 %_102, i32 %_105) 

%_107 = xor i1 1, %_106

	br i1 %_107, label %if_then_1, label %if_else_1 
	if_else_1: 
	%_108 = getelementptr i8, i8* %this, i32 16
	%_109 = bitcast i8* %_108 to i1* 
	%_110 = load i1, i1* %_109
	br i1 %_110, label %if_then_2, label %if_else_2 
	if_else_2: 
	%_111 = load i8*, i8** %other
	%_115 = bitcast i8* %_111 to i8*** 
	%_116 = load i8**, i8*** %_115 
	%_117 = getelementptr i8*, i8** %_116, i32 3 
	%_118 = load i8*, i8** %_117 
	%_119 = bitcast i8* %_118 to i1 (i8* )* 
	%_120 = call i1 %_119( i8* %_111) 

	br i1 %_120, label %if_then_3, label %if_else_3 
	if_else_3: 
	store i32 0,i32* %nt

	br label %if_end_3
	if_then_3: 
	store i1 0,i1* %ret_val

	br label %if_end_3
	if_end_3: 

	br label %if_end_2
	if_then_2: 
	%_131 = load i8*, i8** %other
	%_135 = bitcast i8* %_131 to i8*** 
	%_136 = load i8**, i8*** %_135 
	%_137 = getelementptr i8*, i8** %_136, i32 3 
	%_138 = load i8*, i8** %_137 
	%_139 = bitcast i8* %_138 to i1 (i8* )* 
	%_140 = call i1 %_139( i8* %_131) 

%_141 = xor i1 1, %_140

	br i1 %_141, label %if_then_4, label %if_else_4 
	if_else_4: 
	store i32 0,i32* %nt

	br label %if_end_4
	if_then_4: 
	store i1 0,i1* %ret_val

	br label %if_end_4
	if_end_4: 

	br label %if_end_2
	if_end_2: 

	br label %if_end_1
	if_then_1: 
	store i1 0,i1* %ret_val

	br label %if_end_1
	if_end_1: 

	br label %if_end_0
	if_then_0: 
	store i1 0,i1* %ret_val

	br label %if_end_0
	if_end_0: 

	%_162 = load i1, i1* %ret_val
	ret i1 %_162
}
 
define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1

	%aux02 = alloca i32

	store i1 0,i1* %retval

	%_173 = load i32, i32* %num2
	%_174 = add i32 %_173, 1

	store i32 %_174,i32* %aux02

	%_175 = load i32, i32* %num1
	%_176 = load i32, i32* %num2
	%_177 = icmp slt i32 %_175, %_176

	br i1 %_177, label %if_then_5, label %if_else_5 
	if_else_5: 
	%_178 = load i32, i32* %num1
	%_179 = load i32, i32* %aux02
	%_180 = icmp slt i32 %_178, %_179

%_181 = xor i1 1, %_180

	br i1 %_181, label %if_then_6, label %if_else_6 
	if_else_6: 
	store i1 1,i1* %retval

	br label %if_end_6
	if_then_6: 
	store i1 0,i1* %retval

	br label %if_end_6
	if_end_6: 

	br label %if_end_5
	if_then_5: 
	store i1 0,i1* %retval

	br label %if_end_5
	if_end_5: 

	%_197 = load i1, i1* %retval
	ret i1 %_197
}
 
define i1 @List.Init(i8* %this) {
	%_198 = getelementptr i8, i8* %this, i32 24
	%_199 = bitcast i8* %_198 to i1* 
	store i1 1,i1* %_199

	ret i1 1
}
 
define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end
	%_205 = getelementptr i8, i8* %this, i32 24
	%_206 = bitcast i8* %_205 to i1* 
	%_212 = load i1, i1* %v_end
	store i1 %_212,i1* %_206

	%_213 = getelementptr i8, i8* %this, i32 8
	%_214 = bitcast i8* %_213 to i8** 
	%_220 = load i8*, i8** %v_elem
	store i8* %_220,i8** %_214

	%_221 = getelementptr i8, i8* %this, i32 16
	%_222 = bitcast i8* %_221 to i8** 
	%_228 = load i8*, i8** %v_next
	store i8* %_228,i8** %_222

	ret i1 1
}
 
define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1

	%aux03 = alloca i8*

	%aux02 = alloca i8*

	store i8* %this,i8** %aux03

	%_239 = call i8* @calloc(i32 1, i32 25)
	%_240 = bitcast i8* %_239 to i8*** 
	%_241 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0 
	store i8** %_241, i8*** %_240

	store i8* %_239,i8** %aux02

	%_247 = load i8*, i8** %aux02
	%_251 = bitcast i8* %_247 to i8*** 
	%_252 = load i8**, i8*** %_251 
	%_253 = getelementptr i8*, i8** %_252, i32 1 
	%_254 = load i8*, i8** %_253 
	%_255 = bitcast i8* %_254 to i1 (i8* , i8*, i8*, i1)* 
	%_256 = load i8*, i8** %new_elem
	%_257 = load i8*, i8** %aux03
	%_258 = call i1 %_255( i8* %_247, i8* %_256, i8* %_257, i1 0) 

	store i1 %_258,i1* %ret_val

	%_259 = load i8*, i8** %aux02
	ret i8* %_259
}
 
define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%_260 = getelementptr i8, i8* %this, i32 16
	%_261 = bitcast i8* %_260 to i8** 
	%_267 = load i8*, i8** %v_next
	store i8* %_267,i8** %_261

	ret i1 1
}
 
define i8* @List.Delete(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%my_head = alloca i8*

	%ret_val = alloca i1

	%aux05 = alloca i1

	%aux01 = alloca i8*

	%prev = alloca i8*

	%var_end = alloca i1

	%var_elem = alloca i8*

	%aux04 = alloca i32

	%nt = alloca i32

	store i8* %this,i8** %my_head

	store i1 0,i1* %ret_val

	%_283 = sub i32 0, 1

	store i32 %_283,i32* %aux04

	store i8* %this,i8** %aux01

	store i8* %this,i8** %prev

	%_299 = getelementptr i8, i8* %this, i32 24
	%_300 = bitcast i8* %_299 to i1* 
	%_301 = load i1, i1* %_300
	store i1 %_301,i1* %var_end

	%_307 = getelementptr i8, i8* %this, i32 8
	%_308 = bitcast i8* %_307 to i8** 
	%_309 = load i8*, i8** %_308
	store i8* %_309,i8** %var_elem

	br label %loop7
	loop7: 
	%_310 = load i1, i1* %var_end
%_311 = xor i1 1, %_310

	br i1 %_311, label %and_clause11, label %and_clause10 
	and_clause10: 
	br label %and_clause12
	and_clause11: 
	%_312 = load i1, i1* %ret_val
%_313 = xor i1 1, %_312

	br label %and_clause12
	and_clause12: 
	br label %and_clause13
	and_clause13: 
	%_314 = phi i1 [ 0, %and_clause10 ], [ %_313, %and_clause12] 

	br i1 %_314, label %loop8, label %loop9 
	loop8: 
	%_315 = load i8*, i8** %e
	%_319 = bitcast i8* %_315 to i8*** 
	%_320 = load i8**, i8*** %_319 
	%_321 = getelementptr i8*, i8** %_320, i32 4 
	%_322 = load i8*, i8** %_321 
	%_323 = bitcast i8* %_322 to i1 (i8* , i8*)* 
	%_324 = load i8*, i8** %var_elem
	%_325 = call i1 %_323( i8* %_315, i8* %_324) 

	br i1 %_325, label %if_then_14, label %if_else_14 
	if_else_14: 
	store i32 0,i32* %nt

	br label %if_end_14
	if_then_14: 
	store i1 1,i1* %ret_val

	%_336 = load i32, i32* %aux04
	%_337 = icmp slt i32 %_336, 0

	br i1 %_337, label %if_then_15, label %if_else_15 
	if_else_15: 
	%_338 = sub i32 0, 555

	call void (i32) @print_int(i32 %_338)

	%_344 = load i8*, i8** %prev
	%_348 = bitcast i8* %_344 to i8*** 
	%_349 = load i8**, i8*** %_348 
	%_350 = getelementptr i8*, i8** %_349, i32 3 
	%_351 = load i8*, i8** %_350 
	%_352 = bitcast i8* %_351 to i1 (i8* , i8*)* 
	%_353 = load i8*, i8** %aux01
	%_357 = bitcast i8* %_353 to i8*** 
	%_358 = load i8**, i8*** %_357 
	%_359 = getelementptr i8*, i8** %_358, i32 8 
	%_360 = load i8*, i8** %_359 
	%_361 = bitcast i8* %_360 to i8* (i8* )* 
	%_362 = call i8* %_361( i8* %_353) 

	%_363 = call i1 %_352( i8* %_344, i8* %_362) 

	store i1 %_363,i1* %aux05

	%_364 = sub i32 0, 555

	call void (i32) @print_int(i32 %_364)

	br label %if_end_15
	if_then_15: 
	%_370 = load i8*, i8** %aux01
	%_374 = bitcast i8* %_370 to i8*** 
	%_375 = load i8**, i8*** %_374 
	%_376 = getelementptr i8*, i8** %_375, i32 8 
	%_377 = load i8*, i8** %_376 
	%_378 = bitcast i8* %_377 to i8* (i8* )* 
	%_379 = call i8* %_378( i8* %_370) 

	store i8* %_379,i8** %my_head

	br label %if_end_15
	if_end_15: 

	br label %if_end_14
	if_end_14: 

	%_380 = load i1, i1* %ret_val
%_381 = xor i1 1, %_380

	br i1 %_381, label %if_then_16, label %if_else_16 
	if_else_16: 
	store i32 0,i32* %nt

	br label %if_end_16
	if_then_16: 
	%_392 = load i8*, i8** %aux01
	store i8* %_392,i8** %prev

	%_398 = load i8*, i8** %aux01
	%_402 = bitcast i8* %_398 to i8*** 
	%_403 = load i8**, i8*** %_402 
	%_404 = getelementptr i8*, i8** %_403, i32 8 
	%_405 = load i8*, i8** %_404 
	%_406 = bitcast i8* %_405 to i8* (i8* )* 
	%_407 = call i8* %_406( i8* %_398) 

	store i8* %_407,i8** %aux01

	%_413 = load i8*, i8** %aux01
	%_417 = bitcast i8* %_413 to i8*** 
	%_418 = load i8**, i8*** %_417 
	%_419 = getelementptr i8*, i8** %_418, i32 6 
	%_420 = load i8*, i8** %_419 
	%_421 = bitcast i8* %_420 to i1 (i8* )* 
	%_422 = call i1 %_421( i8* %_413) 

	store i1 %_422,i1* %var_end

	%_428 = load i8*, i8** %aux01
	%_432 = bitcast i8* %_428 to i8*** 
	%_433 = load i8**, i8*** %_432 
	%_434 = getelementptr i8*, i8** %_433, i32 7 
	%_435 = load i8*, i8** %_434 
	%_436 = bitcast i8* %_435 to i8* (i8* )* 
	%_437 = call i8* %_436( i8* %_428) 

	store i8* %_437,i8** %var_elem

	store i32 1,i32* %aux04

	br label %if_end_16
	if_end_16: 

	br label %loop7
	loop9: 

	%_443 = load i8*, i8** %my_head
	ret i8* %_443
}
 
define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32

	%aux01 = alloca i8*

	%var_elem = alloca i8*

	%var_end = alloca i1

	%nt = alloca i32

	store i32 0,i32* %int_ret_val

	store i8* %this,i8** %aux01

	%_459 = getelementptr i8, i8* %this, i32 24
	%_460 = bitcast i8* %_459 to i1* 
	%_461 = load i1, i1* %_460
	store i1 %_461,i1* %var_end

	%_467 = getelementptr i8, i8* %this, i32 8
	%_468 = bitcast i8* %_467 to i8** 
	%_469 = load i8*, i8** %_468
	store i8* %_469,i8** %var_elem

	br label %loop17
	loop17: 
	%_470 = load i1, i1* %var_end
%_471 = xor i1 1, %_470

	br i1 %_471, label %loop18, label %loop19 
	loop18: 
	%_472 = load i8*, i8** %e
	%_476 = bitcast i8* %_472 to i8*** 
	%_477 = load i8**, i8*** %_476 
	%_478 = getelementptr i8*, i8** %_477, i32 4 
	%_479 = load i8*, i8** %_478 
	%_480 = bitcast i8* %_479 to i1 (i8* , i8*)* 
	%_481 = load i8*, i8** %var_elem
	%_482 = call i1 %_480( i8* %_472, i8* %_481) 

	br i1 %_482, label %if_then_20, label %if_else_20 
	if_else_20: 
	store i32 0,i32* %nt

	br label %if_end_20
	if_then_20: 
	store i32 1,i32* %int_ret_val

	br label %if_end_20
	if_end_20: 

	%_498 = load i8*, i8** %aux01
	%_502 = bitcast i8* %_498 to i8*** 
	%_503 = load i8**, i8*** %_502 
	%_504 = getelementptr i8*, i8** %_503, i32 8 
	%_505 = load i8*, i8** %_504 
	%_506 = bitcast i8* %_505 to i8* (i8* )* 
	%_507 = call i8* %_506( i8* %_498) 

	store i8* %_507,i8** %aux01

	%_513 = load i8*, i8** %aux01
	%_517 = bitcast i8* %_513 to i8*** 
	%_518 = load i8**, i8*** %_517 
	%_519 = getelementptr i8*, i8** %_518, i32 6 
	%_520 = load i8*, i8** %_519 
	%_521 = bitcast i8* %_520 to i1 (i8* )* 
	%_522 = call i1 %_521( i8* %_513) 

	store i1 %_522,i1* %var_end

	%_528 = load i8*, i8** %aux01
	%_532 = bitcast i8* %_528 to i8*** 
	%_533 = load i8**, i8*** %_532 
	%_534 = getelementptr i8*, i8** %_533, i32 7 
	%_535 = load i8*, i8** %_534 
	%_536 = bitcast i8* %_535 to i8* (i8* )* 
	%_537 = call i8* %_536( i8* %_528) 

	store i8* %_537,i8** %var_elem

	br label %loop17
	loop19: 

	%_538 = load i32, i32* %int_ret_val
	ret i32 %_538
}
 
define i1 @List.GetEnd(i8* %this) {
	%_539 = getelementptr i8, i8* %this, i32 24
	%_540 = bitcast i8* %_539 to i1* 
	%_541 = load i1, i1* %_540
	ret i1 %_541
}
 
define i8* @List.GetElem(i8* %this) {
	%_542 = getelementptr i8, i8* %this, i32 8
	%_543 = bitcast i8* %_542 to i8** 
	%_544 = load i8*, i8** %_543
	ret i8* %_544
}
 
define i8* @List.GetNext(i8* %this) {
	%_545 = getelementptr i8, i8* %this, i32 16
	%_546 = bitcast i8* %_545 to i8** 
	%_547 = load i8*, i8** %_546
	ret i8* %_547
}
 
define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*

	%var_end = alloca i1

	%var_elem = alloca i8*

	store i8* %this,i8** %aux01

	%_558 = getelementptr i8, i8* %this, i32 24
	%_559 = bitcast i8* %_558 to i1* 
	%_560 = load i1, i1* %_559
	store i1 %_560,i1* %var_end

	%_566 = getelementptr i8, i8* %this, i32 8
	%_567 = bitcast i8* %_566 to i8** 
	%_568 = load i8*, i8** %_567
	store i8* %_568,i8** %var_elem

	br label %loop21
	loop21: 
	%_569 = load i1, i1* %var_end
%_570 = xor i1 1, %_569

	br i1 %_570, label %loop22, label %loop23 
	loop22: 
	%_571 = load i8*, i8** %var_elem
	%_575 = bitcast i8* %_571 to i8*** 
	%_576 = load i8**, i8*** %_575 
	%_577 = getelementptr i8*, i8** %_576, i32 1 
	%_578 = load i8*, i8** %_577 
	%_579 = bitcast i8* %_578 to i32 (i8* )* 
	%_580 = call i32 %_579( i8* %_571) 

	call void (i32) @print_int(i32 %_580)

	%_586 = load i8*, i8** %aux01
	%_590 = bitcast i8* %_586 to i8*** 
	%_591 = load i8**, i8*** %_590 
	%_592 = getelementptr i8*, i8** %_591, i32 8 
	%_593 = load i8*, i8** %_592 
	%_594 = bitcast i8* %_593 to i8* (i8* )* 
	%_595 = call i8* %_594( i8* %_586) 

	store i8* %_595,i8** %aux01

	%_601 = load i8*, i8** %aux01
	%_605 = bitcast i8* %_601 to i8*** 
	%_606 = load i8**, i8*** %_605 
	%_607 = getelementptr i8*, i8** %_606, i32 6 
	%_608 = load i8*, i8** %_607 
	%_609 = bitcast i8* %_608 to i1 (i8* )* 
	%_610 = call i1 %_609( i8* %_601) 

	store i1 %_610,i1* %var_end

	%_616 = load i8*, i8** %aux01
	%_620 = bitcast i8* %_616 to i8*** 
	%_621 = load i8**, i8*** %_620 
	%_622 = getelementptr i8*, i8** %_621, i32 7 
	%_623 = load i8*, i8** %_622 
	%_624 = bitcast i8* %_623 to i8* (i8* )* 
	%_625 = call i8* %_624( i8* %_616) 

	store i8* %_625,i8** %var_elem

	br label %loop21
	loop23: 

	ret i1 1
}
 
define i32 @LL.Start(i8* %this) {
	%head = alloca i8*

	%last_elem = alloca i8*

	%aux01 = alloca i1

	%el01 = alloca i8*

	%el02 = alloca i8*

	%el03 = alloca i8*

	%_631 = call i8* @calloc(i32 1, i32 25)
	%_632 = bitcast i8* %_631 to i8*** 
	%_633 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0 
	store i8** %_633, i8*** %_632

	store i8* %_631,i8** %last_elem

	%_639 = load i8*, i8** %last_elem
	%_643 = bitcast i8* %_639 to i8*** 
	%_644 = load i8**, i8*** %_643 
	%_645 = getelementptr i8*, i8** %_644, i32 0 
	%_646 = load i8*, i8** %_645 
	%_647 = bitcast i8* %_646 to i1 (i8* )* 
	%_648 = call i1 %_647( i8* %_639) 

	store i1 %_648,i1* %aux01

	%_654 = load i8*, i8** %last_elem
	store i8* %_654,i8** %head

	%_660 = load i8*, i8** %head
	%_664 = bitcast i8* %_660 to i8*** 
	%_665 = load i8**, i8*** %_664 
	%_666 = getelementptr i8*, i8** %_665, i32 0 
	%_667 = load i8*, i8** %_666 
	%_668 = bitcast i8* %_667 to i1 (i8* )* 
	%_669 = call i1 %_668( i8* %_660) 

	store i1 %_669,i1* %aux01

	%_675 = load i8*, i8** %head
	%_679 = bitcast i8* %_675 to i8*** 
	%_680 = load i8**, i8*** %_679 
	%_681 = getelementptr i8*, i8** %_680, i32 9 
	%_682 = load i8*, i8** %_681 
	%_683 = bitcast i8* %_682 to i1 (i8* )* 
	%_684 = call i1 %_683( i8* %_675) 

	store i1 %_684,i1* %aux01

	%_690 = call i8* @calloc(i32 1, i32 17)
	%_691 = bitcast i8* %_690 to i8*** 
	%_692 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_692, i8*** %_691

	store i8* %_690,i8** %el01

	%_698 = load i8*, i8** %el01
	%_702 = bitcast i8* %_698 to i8*** 
	%_703 = load i8**, i8*** %_702 
	%_704 = getelementptr i8*, i8** %_703, i32 0 
	%_705 = load i8*, i8** %_704 
	%_706 = bitcast i8* %_705 to i1 (i8* , i32, i32, i1)* 
	%_707 = call i1 %_706( i8* %_698, i32 25, i32 37000, i1 0) 

	store i1 %_707,i1* %aux01

	%_713 = load i8*, i8** %head
	%_717 = bitcast i8* %_713 to i8*** 
	%_718 = load i8**, i8*** %_717 
	%_719 = getelementptr i8*, i8** %_718, i32 2 
	%_720 = load i8*, i8** %_719 
	%_721 = bitcast i8* %_720 to i8* (i8* , i8*)* 
	%_722 = load i8*, i8** %el01
	%_723 = call i8* %_721( i8* %_713, i8* %_722) 

	store i8* %_723,i8** %head

	%_729 = load i8*, i8** %head
	%_733 = bitcast i8* %_729 to i8*** 
	%_734 = load i8**, i8*** %_733 
	%_735 = getelementptr i8*, i8** %_734, i32 9 
	%_736 = load i8*, i8** %_735 
	%_737 = bitcast i8* %_736 to i1 (i8* )* 
	%_738 = call i1 %_737( i8* %_729) 

	store i1 %_738,i1* %aux01

	call void (i32) @print_int(i32 10000000)

	%_744 = call i8* @calloc(i32 1, i32 17)
	%_745 = bitcast i8* %_744 to i8*** 
	%_746 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_746, i8*** %_745

	store i8* %_744,i8** %el01

	%_752 = load i8*, i8** %el01
	%_756 = bitcast i8* %_752 to i8*** 
	%_757 = load i8**, i8*** %_756 
	%_758 = getelementptr i8*, i8** %_757, i32 0 
	%_759 = load i8*, i8** %_758 
	%_760 = bitcast i8* %_759 to i1 (i8* , i32, i32, i1)* 
	%_761 = call i1 %_760( i8* %_752, i32 39, i32 42000, i1 1) 

	store i1 %_761,i1* %aux01

	%_767 = load i8*, i8** %el01
	store i8* %_767,i8** %el02

	%_773 = load i8*, i8** %head
	%_777 = bitcast i8* %_773 to i8*** 
	%_778 = load i8**, i8*** %_777 
	%_779 = getelementptr i8*, i8** %_778, i32 2 
	%_780 = load i8*, i8** %_779 
	%_781 = bitcast i8* %_780 to i8* (i8* , i8*)* 
	%_782 = load i8*, i8** %el01
	%_783 = call i8* %_781( i8* %_773, i8* %_782) 

	store i8* %_783,i8** %head

	%_789 = load i8*, i8** %head
	%_793 = bitcast i8* %_789 to i8*** 
	%_794 = load i8**, i8*** %_793 
	%_795 = getelementptr i8*, i8** %_794, i32 9 
	%_796 = load i8*, i8** %_795 
	%_797 = bitcast i8* %_796 to i1 (i8* )* 
	%_798 = call i1 %_797( i8* %_789) 

	store i1 %_798,i1* %aux01

	call void (i32) @print_int(i32 10000000)

	%_804 = call i8* @calloc(i32 1, i32 17)
	%_805 = bitcast i8* %_804 to i8*** 
	%_806 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_806, i8*** %_805

	store i8* %_804,i8** %el01

	%_812 = load i8*, i8** %el01
	%_816 = bitcast i8* %_812 to i8*** 
	%_817 = load i8**, i8*** %_816 
	%_818 = getelementptr i8*, i8** %_817, i32 0 
	%_819 = load i8*, i8** %_818 
	%_820 = bitcast i8* %_819 to i1 (i8* , i32, i32, i1)* 
	%_821 = call i1 %_820( i8* %_812, i32 22, i32 34000, i1 0) 

	store i1 %_821,i1* %aux01

	%_827 = load i8*, i8** %head
	%_831 = bitcast i8* %_827 to i8*** 
	%_832 = load i8**, i8*** %_831 
	%_833 = getelementptr i8*, i8** %_832, i32 2 
	%_834 = load i8*, i8** %_833 
	%_835 = bitcast i8* %_834 to i8* (i8* , i8*)* 
	%_836 = load i8*, i8** %el01
	%_837 = call i8* %_835( i8* %_827, i8* %_836) 

	store i8* %_837,i8** %head

	%_843 = load i8*, i8** %head
	%_847 = bitcast i8* %_843 to i8*** 
	%_848 = load i8**, i8*** %_847 
	%_849 = getelementptr i8*, i8** %_848, i32 9 
	%_850 = load i8*, i8** %_849 
	%_851 = bitcast i8* %_850 to i1 (i8* )* 
	%_852 = call i1 %_851( i8* %_843) 

	store i1 %_852,i1* %aux01

	%_858 = call i8* @calloc(i32 1, i32 17)
	%_859 = bitcast i8* %_858 to i8*** 
	%_860 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_860, i8*** %_859

	store i8* %_858,i8** %el03

	%_866 = load i8*, i8** %el03
	%_870 = bitcast i8* %_866 to i8*** 
	%_871 = load i8**, i8*** %_870 
	%_872 = getelementptr i8*, i8** %_871, i32 0 
	%_873 = load i8*, i8** %_872 
	%_874 = bitcast i8* %_873 to i1 (i8* , i32, i32, i1)* 
	%_875 = call i1 %_874( i8* %_866, i32 27, i32 34000, i1 0) 

	store i1 %_875,i1* %aux01

	%_876 = load i8*, i8** %head
	%_880 = bitcast i8* %_876 to i8*** 
	%_881 = load i8**, i8*** %_880 
	%_882 = getelementptr i8*, i8** %_881, i32 5 
	%_883 = load i8*, i8** %_882 
	%_884 = bitcast i8* %_883 to i32 (i8* , i8*)* 
	%_885 = load i8*, i8** %el02
	%_886 = call i32 %_884( i8* %_876, i8* %_885) 

	call void (i32) @print_int(i32 %_886)

	%_887 = load i8*, i8** %head
	%_891 = bitcast i8* %_887 to i8*** 
	%_892 = load i8**, i8*** %_891 
	%_893 = getelementptr i8*, i8** %_892, i32 5 
	%_894 = load i8*, i8** %_893 
	%_895 = bitcast i8* %_894 to i32 (i8* , i8*)* 
	%_896 = load i8*, i8** %el03
	%_897 = call i32 %_895( i8* %_887, i8* %_896) 

	call void (i32) @print_int(i32 %_897)

	call void (i32) @print_int(i32 10000000)

	%_903 = call i8* @calloc(i32 1, i32 17)
	%_904 = bitcast i8* %_903 to i8*** 
	%_905 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_905, i8*** %_904

	store i8* %_903,i8** %el01

	%_911 = load i8*, i8** %el01
	%_915 = bitcast i8* %_911 to i8*** 
	%_916 = load i8**, i8*** %_915 
	%_917 = getelementptr i8*, i8** %_916, i32 0 
	%_918 = load i8*, i8** %_917 
	%_919 = bitcast i8* %_918 to i1 (i8* , i32, i32, i1)* 
	%_920 = call i1 %_919( i8* %_911, i32 28, i32 35000, i1 0) 

	store i1 %_920,i1* %aux01

	%_926 = load i8*, i8** %head
	%_930 = bitcast i8* %_926 to i8*** 
	%_931 = load i8**, i8*** %_930 
	%_932 = getelementptr i8*, i8** %_931, i32 2 
	%_933 = load i8*, i8** %_932 
	%_934 = bitcast i8* %_933 to i8* (i8* , i8*)* 
	%_935 = load i8*, i8** %el01
	%_936 = call i8* %_934( i8* %_926, i8* %_935) 

	store i8* %_936,i8** %head

	%_942 = load i8*, i8** %head
	%_946 = bitcast i8* %_942 to i8*** 
	%_947 = load i8**, i8*** %_946 
	%_948 = getelementptr i8*, i8** %_947, i32 9 
	%_949 = load i8*, i8** %_948 
	%_950 = bitcast i8* %_949 to i1 (i8* )* 
	%_951 = call i1 %_950( i8* %_942) 

	store i1 %_951,i1* %aux01

	call void (i32) @print_int(i32 2220000)

	%_957 = load i8*, i8** %head
	%_961 = bitcast i8* %_957 to i8*** 
	%_962 = load i8**, i8*** %_961 
	%_963 = getelementptr i8*, i8** %_962, i32 4 
	%_964 = load i8*, i8** %_963 
	%_965 = bitcast i8* %_964 to i8* (i8* , i8*)* 
	%_966 = load i8*, i8** %el02
	%_967 = call i8* %_965( i8* %_957, i8* %_966) 

	store i8* %_967,i8** %head

	%_973 = load i8*, i8** %head
	%_977 = bitcast i8* %_973 to i8*** 
	%_978 = load i8**, i8*** %_977 
	%_979 = getelementptr i8*, i8** %_978, i32 9 
	%_980 = load i8*, i8** %_979 
	%_981 = bitcast i8* %_980 to i1 (i8* )* 
	%_982 = call i1 %_981( i8* %_973) 

	store i1 %_982,i1* %aux01

	call void (i32) @print_int(i32 33300000)

	%_988 = load i8*, i8** %head
	%_992 = bitcast i8* %_988 to i8*** 
	%_993 = load i8**, i8*** %_992 
	%_994 = getelementptr i8*, i8** %_993, i32 4 
	%_995 = load i8*, i8** %_994 
	%_996 = bitcast i8* %_995 to i8* (i8* , i8*)* 
	%_997 = load i8*, i8** %el01
	%_998 = call i8* %_996( i8* %_988, i8* %_997) 

	store i8* %_998,i8** %head

	%_1004 = load i8*, i8** %head
	%_1008 = bitcast i8* %_1004 to i8*** 
	%_1009 = load i8**, i8*** %_1008 
	%_1010 = getelementptr i8*, i8** %_1009, i32 9 
	%_1011 = load i8*, i8** %_1010 
	%_1012 = bitcast i8* %_1011 to i1 (i8* )* 
	%_1013 = call i1 %_1012( i8* %_1004) 

	store i1 %_1013,i1* %aux01

	call void (i32) @print_int(i32 44440000)

	ret i32 0
}
 
