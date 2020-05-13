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
	%_37 = getelementptr i8*, i8** %_36, i32 2 
	%_38 = load i8*, i8** %_37 
	%_39 = bitcast i8* %_38 to i32 (i8* )* 
	%_40 = call i32 %_39( i8* %this) 

	store i32 %_40,i32* %aux01

	call void (i32) @print_int(i32 9999)

	%_46 = getelementptr i8, i8* %this, i32 16
	%_47 = bitcast i8* %_46 to i32* 
	%_48 = load i32, i32* %_47
	%_49 = sub i32 %_48, 1

	store i32 %_49,i32* %aux01

	%_58 = bitcast i8* %this to i8*** 
	%_59 = load i8**, i8*** %_58 
	%_60 = getelementptr i8*, i8** %_59, i32 1 
	%_61 = load i8*, i8** %_60 
	%_62 = bitcast i8* %_61 to i32 (i8* , i32, i32)* 
	%_63 = load i32, i32* %aux01
	%_64 = call i32 %_62( i8* %this, i32 0, i32 %_63) 

	store i32 %_64,i32* %aux01

	%_73 = bitcast i8* %this to i8*** 
	%_74 = load i8**, i8*** %_73 
	%_75 = getelementptr i8*, i8** %_74, i32 2 
	%_76 = load i8*, i8** %_75 
	%_77 = bitcast i8* %_76 to i32 (i8* )* 
	%_78 = call i32 %_77( i8* %this) 

	store i32 %_78,i32* %aux01

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

	%_84 = load i32, i32* %left
	%_85 = load i32, i32* %right
	%_86 = icmp slt i32 %_84, %_85

	br i1 %_86, label %if_then_0, label %if_else_0 
	if_else_0: 
	store i32 0,i32* %nt

	br label %if_end_0
	if_then_0: 
	%_97 = getelementptr i8, i8* %this, i32 8
	%_98 = bitcast i8* %_97 to i32** 
	%_99 = load i32*, i32** %_98
	%_100 = load i32, i32* %right
	%_101 = load i32, i32* %_99
	%_102 = icmp sge i32 %_100, 0
	%_103 = icmp slt i32 %_100, %_101
	%_104 = and i1 %_102, %_103
	br i1 %_104, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_105 = add i32 1, %_100
	%_106 = getelementptr i32, i32* %_99, i32 %_105
	%_107 = load i32, i32* %_106

	store i32 %_107,i32* %v

	%_113 = load i32, i32* %left
	%_114 = sub i32 %_113, 1

	store i32 %_114,i32* %i

	%_120 = load i32, i32* %right
	store i32 %_120,i32* %j

	store i1 1,i1* %cont01

	br label %loop2
	loop2: 
	%_126 = load i1, i1* %cont01
	br i1 %_126, label %loop3, label %loop4 
	loop3: 
	store i1 1,i1* %cont02

	br label %loop5
	loop5: 
	%_132 = load i1, i1* %cont02
	br i1 %_132, label %loop6, label %loop7 
	loop6: 
	%_138 = load i32, i32* %i
	%_139 = add i32 %_138, 1

	store i32 %_139,i32* %i

	%_145 = getelementptr i8, i8* %this, i32 8
	%_146 = bitcast i8* %_145 to i32** 
	%_147 = load i32*, i32** %_146
	%_148 = load i32, i32* %i
	%_149 = load i32, i32* %_147
	%_150 = icmp sge i32 %_148, 0
	%_151 = icmp slt i32 %_148, %_149
	%_152 = and i1 %_150, %_151
	br i1 %_152, label %oob_ok_8, label %oob_err_8
 
	oob_err_8: 
	call void @throw_oob()
	br label %oob_ok_8
 
	oob_ok_8: 
	%_153 = add i32 1, %_148
	%_154 = getelementptr i32, i32* %_147, i32 %_153
	%_155 = load i32, i32* %_154

	store i32 %_155,i32* %aux03

	%_156 = load i32, i32* %aux03
	%_157 = load i32, i32* %v
	%_158 = icmp slt i32 %_156, %_157

%_159 = xor i1 1, %_158

	br i1 %_159, label %if_then_9, label %if_else_9 
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
	%_175 = load i1, i1* %cont02
	br i1 %_175, label %loop11, label %loop12 
	loop11: 
	%_181 = load i32, i32* %j
	%_182 = sub i32 %_181, 1

	store i32 %_182,i32* %j

	%_188 = getelementptr i8, i8* %this, i32 8
	%_189 = bitcast i8* %_188 to i32** 
	%_190 = load i32*, i32** %_189
	%_191 = load i32, i32* %j
	%_192 = load i32, i32* %_190
	%_193 = icmp sge i32 %_191, 0
	%_194 = icmp slt i32 %_191, %_192
	%_195 = and i1 %_193, %_194
	br i1 %_195, label %oob_ok_13, label %oob_err_13
 
	oob_err_13: 
	call void @throw_oob()
	br label %oob_ok_13
 
	oob_ok_13: 
	%_196 = add i32 1, %_191
	%_197 = getelementptr i32, i32* %_190, i32 %_196
	%_198 = load i32, i32* %_197

	store i32 %_198,i32* %aux03

	%_199 = load i32, i32* %v
	%_200 = load i32, i32* %aux03
	%_201 = icmp slt i32 %_199, %_200

%_202 = xor i1 1, %_201

	br i1 %_202, label %if_then_14, label %if_else_14 
	if_else_14: 
	store i1 1,i1* %cont02

	br label %if_end_14
	if_then_14: 
	store i1 0,i1* %cont02

	br label %if_end_14
	if_end_14: 

	br label %loop10
	loop12: 

	%_218 = getelementptr i8, i8* %this, i32 8
	%_219 = bitcast i8* %_218 to i32** 
	%_220 = load i32*, i32** %_219
	%_221 = load i32, i32* %i
	%_222 = load i32, i32* %_220
	%_223 = icmp sge i32 %_221, 0
	%_224 = icmp slt i32 %_221, %_222
	%_225 = and i1 %_223, %_224
	br i1 %_225, label %oob_ok_15, label %oob_err_15
 
	oob_err_15: 
	call void @throw_oob()
	br label %oob_ok_15
 
	oob_ok_15: 
	%_226 = add i32 1, %_221
	%_227 = getelementptr i32, i32* %_220, i32 %_226
	%_228 = load i32, i32* %_227

	store i32 %_228,i32* %t

	%_229 = getelementptr i8, i8* %this, i32 8
	%_230 = bitcast i8* %_229 to i32** 
	%_236 = load i32, i32* %i
	%_237 = getelementptr i8, i8* %this, i32 8
	%_238 = bitcast i8* %_237 to i32** 
	%_239 = load i32*, i32** %_238
	%_240 = load i32, i32* %j
	%_241 = load i32, i32* %_239
	%_242 = icmp sge i32 %_240, 0
	%_243 = icmp slt i32 %_240, %_241
	%_244 = and i1 %_242, %_243
	br i1 %_244, label %oob_ok_16, label %oob_err_16
 
	oob_err_16: 
	call void @throw_oob()
	br label %oob_ok_16
 
	oob_ok_16: 
	%_245 = add i32 1, %_240
	%_246 = getelementptr i32, i32* %_239, i32 %_245
	%_247 = load i32, i32* %_246

	%_248 = load i32*, i32** %_230
	%_249 = load i32, i32* %_248
	%_250 = icmp sge i32 %_236, 0
	%_251 = icmp slt i32 %_236, %_249
	%_252 = and i1 %_250, %_251
	br i1 %_252, label %oob_ok_17, label %oob_err_17
 
	oob_err_17: 
	call void @throw_oob()
	br label %oob_ok_17
 
	oob_ok_17: 
	%_253 = add i32 1, %_236
	%_254 = getelementptr i32, i32* %_248, i32 %_253
	store i32 %_247, i32* %_254
 

	%_255 = getelementptr i8, i8* %this, i32 8
	%_256 = bitcast i8* %_255 to i32** 
	%_262 = load i32, i32* %j
	%_263 = load i32, i32* %t
	%_264 = load i32*, i32** %_256
	%_265 = load i32, i32* %_264
	%_266 = icmp sge i32 %_262, 0
	%_267 = icmp slt i32 %_262, %_265
	%_268 = and i1 %_266, %_267
	br i1 %_268, label %oob_ok_18, label %oob_err_18
 
	oob_err_18: 
	call void @throw_oob()
	br label %oob_ok_18
 
	oob_ok_18: 
	%_269 = add i32 1, %_262
	%_270 = getelementptr i32, i32* %_264, i32 %_269
	store i32 %_263, i32* %_270
 

	%_271 = load i32, i32* %j
	%_272 = load i32, i32* %i
	%_273 = add i32 %_272, 1

	%_274 = icmp slt i32 %_271, %_273

	br i1 %_274, label %if_then_19, label %if_else_19 
	if_else_19: 
	store i1 1,i1* %cont01

	br label %if_end_19
	if_then_19: 
	store i1 0,i1* %cont01

	br label %if_end_19
	if_end_19: 

	br label %loop2
	loop4: 

	%_285 = getelementptr i8, i8* %this, i32 8
	%_286 = bitcast i8* %_285 to i32** 
	%_292 = load i32, i32* %j
	%_293 = getelementptr i8, i8* %this, i32 8
	%_294 = bitcast i8* %_293 to i32** 
	%_295 = load i32*, i32** %_294
	%_296 = load i32, i32* %i
	%_297 = load i32, i32* %_295
	%_298 = icmp sge i32 %_296, 0
	%_299 = icmp slt i32 %_296, %_297
	%_300 = and i1 %_298, %_299
	br i1 %_300, label %oob_ok_20, label %oob_err_20
 
	oob_err_20: 
	call void @throw_oob()
	br label %oob_ok_20
 
	oob_ok_20: 
	%_301 = add i32 1, %_296
	%_302 = getelementptr i32, i32* %_295, i32 %_301
	%_303 = load i32, i32* %_302

	%_304 = load i32*, i32** %_286
	%_305 = load i32, i32* %_304
	%_306 = icmp sge i32 %_292, 0
	%_307 = icmp slt i32 %_292, %_305
	%_308 = and i1 %_306, %_307
	br i1 %_308, label %oob_ok_21, label %oob_err_21
 
	oob_err_21: 
	call void @throw_oob()
	br label %oob_ok_21
 
	oob_ok_21: 
	%_309 = add i32 1, %_292
	%_310 = getelementptr i32, i32* %_304, i32 %_309
	store i32 %_303, i32* %_310
 

	%_311 = getelementptr i8, i8* %this, i32 8
	%_312 = bitcast i8* %_311 to i32** 
	%_318 = load i32, i32* %i
	%_319 = getelementptr i8, i8* %this, i32 8
	%_320 = bitcast i8* %_319 to i32** 
	%_321 = load i32*, i32** %_320
	%_322 = load i32, i32* %right
	%_323 = load i32, i32* %_321
	%_324 = icmp sge i32 %_322, 0
	%_325 = icmp slt i32 %_322, %_323
	%_326 = and i1 %_324, %_325
	br i1 %_326, label %oob_ok_22, label %oob_err_22
 
	oob_err_22: 
	call void @throw_oob()
	br label %oob_ok_22
 
	oob_ok_22: 
	%_327 = add i32 1, %_322
	%_328 = getelementptr i32, i32* %_321, i32 %_327
	%_329 = load i32, i32* %_328

	%_330 = load i32*, i32** %_312
	%_331 = load i32, i32* %_330
	%_332 = icmp sge i32 %_318, 0
	%_333 = icmp slt i32 %_318, %_331
	%_334 = and i1 %_332, %_333
	br i1 %_334, label %oob_ok_23, label %oob_err_23
 
	oob_err_23: 
	call void @throw_oob()
	br label %oob_ok_23
 
	oob_ok_23: 
	%_335 = add i32 1, %_318
	%_336 = getelementptr i32, i32* %_330, i32 %_335
	store i32 %_329, i32* %_336
 

	%_337 = getelementptr i8, i8* %this, i32 8
	%_338 = bitcast i8* %_337 to i32** 
	%_344 = load i32, i32* %right
	%_345 = load i32, i32* %t
	%_346 = load i32*, i32** %_338
	%_347 = load i32, i32* %_346
	%_348 = icmp sge i32 %_344, 0
	%_349 = icmp slt i32 %_344, %_347
	%_350 = and i1 %_348, %_349
	br i1 %_350, label %oob_ok_24, label %oob_err_24
 
	oob_err_24: 
	call void @throw_oob()
	br label %oob_ok_24
 
	oob_ok_24: 
	%_351 = add i32 1, %_344
	%_352 = getelementptr i32, i32* %_346, i32 %_351
	store i32 %_345, i32* %_352
 

	%_361 = bitcast i8* %this to i8*** 
	%_362 = load i8**, i8*** %_361 
	%_363 = getelementptr i8*, i8** %_362, i32 1 
	%_364 = load i8*, i8** %_363 
	%_365 = bitcast i8* %_364 to i32 (i8* , i32, i32)* 
	%_366 = load i32, i32* %left
	%_367 = load i32, i32* %i
	%_368 = sub i32 %_367, 1

	%_369 = call i32 %_365( i8* %this, i32 %_366, i32 %_368) 

	store i32 %_369,i32* %nt

	%_378 = bitcast i8* %this to i8*** 
	%_379 = load i8**, i8*** %_378 
	%_380 = getelementptr i8*, i8** %_379, i32 1 
	%_381 = load i8*, i8** %_380 
	%_382 = bitcast i8* %_381 to i32 (i8* , i32, i32)* 
	%_383 = load i32, i32* %i
	%_384 = add i32 %_383, 1

	%_385 = load i32, i32* %right
	%_386 = call i32 %_382( i8* %this, i32 %_384, i32 %_385) 

	store i32 %_386,i32* %nt

	br label %if_end_0
	if_end_0: 

	ret i32 0
}
 
define i32 @QS.Print(i8* %this) {
	%j = alloca i32

	store i32 0,i32* %j

	br label %loop25
	loop25: 
	%_392 = load i32, i32* %j
	%_393 = getelementptr i8, i8* %this, i32 16
	%_394 = bitcast i8* %_393 to i32* 
	%_395 = load i32, i32* %_394
	%_396 = icmp slt i32 %_392, %_395

	br i1 %_396, label %loop26, label %loop27 
	loop26: 
	%_397 = getelementptr i8, i8* %this, i32 8
	%_398 = bitcast i8* %_397 to i32** 
	%_399 = load i32*, i32** %_398
	%_400 = load i32, i32* %j
	%_401 = load i32, i32* %_399
	%_402 = icmp sge i32 %_400, 0
	%_403 = icmp slt i32 %_400, %_401
	%_404 = and i1 %_402, %_403
	br i1 %_404, label %oob_ok_28, label %oob_err_28
 
	oob_err_28: 
	call void @throw_oob()
	br label %oob_ok_28
 
	oob_ok_28: 
	%_405 = add i32 1, %_400
	%_406 = getelementptr i32, i32* %_399, i32 %_405
	%_407 = load i32, i32* %_406

	call void (i32) @print_int(i32 %_407)

	%_413 = load i32, i32* %j
	%_414 = add i32 %_413, 1

	store i32 %_414,i32* %j

	br label %loop25
	loop27: 

	ret i32 0
}
 
define i32 @QS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%_415 = getelementptr i8, i8* %this, i32 16
	%_416 = bitcast i8* %_415 to i32* 
	%_422 = load i32, i32* %sz
	store i32 %_422,i32* %_416

	%_423 = getelementptr i8, i8* %this, i32 8
	%_424 = bitcast i8* %_423 to i32** 
	%_430 = load i32, i32* %sz
	%_431 = add i32 1, %_430
	%_432 = icmp sge i32 %_431, 1
	br i1 %_432, label %nsz_ok_29, label %nsz_err_29
 
	nsz_err_29: 
	call void @throw_nsz()
	br label %nsz_ok_29
 
	nsz_ok_29: 
	%_433 = call i8* @calloc(i32 %_431, i32 4) 
	%_434 = bitcast i8* %_433 to i32* 
	store i32 %_430, i32* %_434
 

	store i32* %_434,i32** %_424

	%_435 = getelementptr i8, i8* %this, i32 8
	%_436 = bitcast i8* %_435 to i32** 
	%_442 = load i32*, i32** %_436
	%_443 = load i32, i32* %_442
	%_444 = icmp sge i32 0, 0
	%_445 = icmp slt i32 0, %_443
	%_446 = and i1 %_444, %_445
	br i1 %_446, label %oob_ok_30, label %oob_err_30
 
	oob_err_30: 
	call void @throw_oob()
	br label %oob_ok_30
 
	oob_ok_30: 
	%_447 = add i32 1, 0
	%_448 = getelementptr i32, i32* %_442, i32 %_447
	store i32 20, i32* %_448
 

	%_449 = getelementptr i8, i8* %this, i32 8
	%_450 = bitcast i8* %_449 to i32** 
	%_456 = load i32*, i32** %_450
	%_457 = load i32, i32* %_456
	%_458 = icmp sge i32 1, 0
	%_459 = icmp slt i32 1, %_457
	%_460 = and i1 %_458, %_459
	br i1 %_460, label %oob_ok_31, label %oob_err_31
 
	oob_err_31: 
	call void @throw_oob()
	br label %oob_ok_31
 
	oob_ok_31: 
	%_461 = add i32 1, 1
	%_462 = getelementptr i32, i32* %_456, i32 %_461
	store i32 7, i32* %_462
 

	%_463 = getelementptr i8, i8* %this, i32 8
	%_464 = bitcast i8* %_463 to i32** 
	%_470 = load i32*, i32** %_464
	%_471 = load i32, i32* %_470
	%_472 = icmp sge i32 2, 0
	%_473 = icmp slt i32 2, %_471
	%_474 = and i1 %_472, %_473
	br i1 %_474, label %oob_ok_32, label %oob_err_32
 
	oob_err_32: 
	call void @throw_oob()
	br label %oob_ok_32
 
	oob_ok_32: 
	%_475 = add i32 1, 2
	%_476 = getelementptr i32, i32* %_470, i32 %_475
	store i32 12, i32* %_476
 

	%_477 = getelementptr i8, i8* %this, i32 8
	%_478 = bitcast i8* %_477 to i32** 
	%_484 = load i32*, i32** %_478
	%_485 = load i32, i32* %_484
	%_486 = icmp sge i32 3, 0
	%_487 = icmp slt i32 3, %_485
	%_488 = and i1 %_486, %_487
	br i1 %_488, label %oob_ok_33, label %oob_err_33
 
	oob_err_33: 
	call void @throw_oob()
	br label %oob_ok_33
 
	oob_ok_33: 
	%_489 = add i32 1, 3
	%_490 = getelementptr i32, i32* %_484, i32 %_489
	store i32 18, i32* %_490
 

	%_491 = getelementptr i8, i8* %this, i32 8
	%_492 = bitcast i8* %_491 to i32** 
	%_498 = load i32*, i32** %_492
	%_499 = load i32, i32* %_498
	%_500 = icmp sge i32 4, 0
	%_501 = icmp slt i32 4, %_499
	%_502 = and i1 %_500, %_501
	br i1 %_502, label %oob_ok_34, label %oob_err_34
 
	oob_err_34: 
	call void @throw_oob()
	br label %oob_ok_34
 
	oob_ok_34: 
	%_503 = add i32 1, 4
	%_504 = getelementptr i32, i32* %_498, i32 %_503
	store i32 2, i32* %_504
 

	%_505 = getelementptr i8, i8* %this, i32 8
	%_506 = bitcast i8* %_505 to i32** 
	%_512 = load i32*, i32** %_506
	%_513 = load i32, i32* %_512
	%_514 = icmp sge i32 5, 0
	%_515 = icmp slt i32 5, %_513
	%_516 = and i1 %_514, %_515
	br i1 %_516, label %oob_ok_35, label %oob_err_35
 
	oob_err_35: 
	call void @throw_oob()
	br label %oob_ok_35
 
	oob_ok_35: 
	%_517 = add i32 1, 5
	%_518 = getelementptr i32, i32* %_512, i32 %_517
	store i32 11, i32* %_518
 

	%_519 = getelementptr i8, i8* %this, i32 8
	%_520 = bitcast i8* %_519 to i32** 
	%_526 = load i32*, i32** %_520
	%_527 = load i32, i32* %_526
	%_528 = icmp sge i32 6, 0
	%_529 = icmp slt i32 6, %_527
	%_530 = and i1 %_528, %_529
	br i1 %_530, label %oob_ok_36, label %oob_err_36
 
	oob_err_36: 
	call void @throw_oob()
	br label %oob_ok_36
 
	oob_ok_36: 
	%_531 = add i32 1, 6
	%_532 = getelementptr i32, i32* %_526, i32 %_531
	store i32 6, i32* %_532
 

	%_533 = getelementptr i8, i8* %this, i32 8
	%_534 = bitcast i8* %_533 to i32** 
	%_540 = load i32*, i32** %_534
	%_541 = load i32, i32* %_540
	%_542 = icmp sge i32 7, 0
	%_543 = icmp slt i32 7, %_541
	%_544 = and i1 %_542, %_543
	br i1 %_544, label %oob_ok_37, label %oob_err_37
 
	oob_err_37: 
	call void @throw_oob()
	br label %oob_ok_37
 
	oob_ok_37: 
	%_545 = add i32 1, 7
	%_546 = getelementptr i32, i32* %_540, i32 %_545
	store i32 9, i32* %_546
 

	%_547 = getelementptr i8, i8* %this, i32 8
	%_548 = bitcast i8* %_547 to i32** 
	%_554 = load i32*, i32** %_548
	%_555 = load i32, i32* %_554
	%_556 = icmp sge i32 8, 0
	%_557 = icmp slt i32 8, %_555
	%_558 = and i1 %_556, %_557
	br i1 %_558, label %oob_ok_38, label %oob_err_38
 
	oob_err_38: 
	call void @throw_oob()
	br label %oob_ok_38
 
	oob_ok_38: 
	%_559 = add i32 1, 8
	%_560 = getelementptr i32, i32* %_554, i32 %_559
	store i32 19, i32* %_560
 

	%_561 = getelementptr i8, i8* %this, i32 8
	%_562 = bitcast i8* %_561 to i32** 
	%_568 = load i32*, i32** %_562
	%_569 = load i32, i32* %_568
	%_570 = icmp sge i32 9, 0
	%_571 = icmp slt i32 9, %_569
	%_572 = and i1 %_570, %_571
	br i1 %_572, label %oob_ok_39, label %oob_err_39
 
	oob_err_39: 
	call void @throw_oob()
	br label %oob_ok_39
 
	oob_ok_39: 
	%_573 = add i32 1, 9
	%_574 = getelementptr i32, i32* %_568, i32 %_573
	store i32 5, i32* %_574
 

	ret i32 0
}
 
