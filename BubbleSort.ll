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

	call void (i32) @print_int(i32 99999)

	%_49 = bitcast i8* %this to i8*** 
	%_50 = load i8**, i8*** %_49 
	%_51 = getelementptr i8*, i8** %_50, i32 1 
	%_52 = load i8*, i8** %_51 
	%_53 = bitcast i8* %_52 to i32 (i8* )* 
	%_54 = call i32 %_53( i8* %this) 

	store i32 %_54,i32* %aux01

	%_63 = bitcast i8* %this to i8*** 
	%_64 = load i8**, i8*** %_63 
	%_65 = getelementptr i8*, i8** %_64, i32 2 
	%_66 = load i8*, i8** %_65 
	%_67 = bitcast i8* %_66 to i32 (i8* )* 
	%_68 = call i32 %_67( i8* %this) 

	store i32 %_68,i32* %aux01

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

	%_74 = getelementptr i8, i8* %this, i32 16
	%_75 = bitcast i8* %_74 to i32* 
	%_76 = load i32, i32* %_75
	%_77 = sub i32 %_76, 1

	store i32 %_77,i32* %i

	%_83 = sub i32 0, 1

	store i32 %_83,i32* %aux02

	br label %loop0
	loop0: 
	%_84 = load i32, i32* %aux02
	%_85 = load i32, i32* %i
	%_86 = icmp slt i32 %_84, %_85

	br i1 %_86, label %loop1, label %loop2 
	loop1: 
	store i32 1,i32* %j

	br label %loop3
	loop3: 
	%_92 = load i32, i32* %j
	%_93 = load i32, i32* %i
	%_94 = add i32 %_93, 1

	%_95 = icmp slt i32 %_92, %_94

	br i1 %_95, label %loop4, label %loop5 
	loop4: 
	%_101 = load i32, i32* %j
	%_102 = sub i32 %_101, 1

	store i32 %_102,i32* %aux07

	%_108 = getelementptr i8, i8* %this, i32 8
	%_109 = bitcast i8* %_108 to i32** 
	%_110 = load i32*, i32** %_109
	%_111 = load i32, i32* %aux07
	%_112 = load i32, i32* %_110
	%_113 = icmp sge i32 %_111, 0
	%_114 = icmp slt i32 %_111, %_112
	%_115 = and i1 %_113, %_114
	br i1 %_115, label %oob_ok_6, label %oob_err_6
 
	oob_err_6: 
	call void @throw_oob()
	br label %oob_ok_6
 
	oob_ok_6: 
	%_116 = add i32 1, %_111
	%_117 = getelementptr i32, i32* %_110, i32 %_116
	%_118 = load i32, i32* %_117

	store i32 %_118,i32* %aux04

	%_124 = getelementptr i8, i8* %this, i32 8
	%_125 = bitcast i8* %_124 to i32** 
	%_126 = load i32*, i32** %_125
	%_127 = load i32, i32* %j
	%_128 = load i32, i32* %_126
	%_129 = icmp sge i32 %_127, 0
	%_130 = icmp slt i32 %_127, %_128
	%_131 = and i1 %_129, %_130
	br i1 %_131, label %oob_ok_7, label %oob_err_7
 
	oob_err_7: 
	call void @throw_oob()
	br label %oob_ok_7
 
	oob_ok_7: 
	%_132 = add i32 1, %_127
	%_133 = getelementptr i32, i32* %_126, i32 %_132
	%_134 = load i32, i32* %_133

	store i32 %_134,i32* %aux05

	%_135 = load i32, i32* %aux05
	%_136 = load i32, i32* %aux04
	%_137 = icmp slt i32 %_135, %_136

	br i1 %_137, label %if_then_8, label %if_else_8 
	if_else_8: 
	store i32 0,i32* %nt

	br label %if_end_8
	if_then_8: 
	%_148 = load i32, i32* %j
	%_149 = sub i32 %_148, 1

	store i32 %_149,i32* %aux06

	%_155 = getelementptr i8, i8* %this, i32 8
	%_156 = bitcast i8* %_155 to i32** 
	%_157 = load i32*, i32** %_156
	%_158 = load i32, i32* %aux06
	%_159 = load i32, i32* %_157
	%_160 = icmp sge i32 %_158, 0
	%_161 = icmp slt i32 %_158, %_159
	%_162 = and i1 %_160, %_161
	br i1 %_162, label %oob_ok_9, label %oob_err_9
 
	oob_err_9: 
	call void @throw_oob()
	br label %oob_ok_9
 
	oob_ok_9: 
	%_163 = add i32 1, %_158
	%_164 = getelementptr i32, i32* %_157, i32 %_163
	%_165 = load i32, i32* %_164

	store i32 %_165,i32* %t

	%_166 = getelementptr i8, i8* %this, i32 8
	%_167 = bitcast i8* %_166 to i32** 
	%_173 = load i32, i32* %aux06
	%_174 = getelementptr i8, i8* %this, i32 8
	%_175 = bitcast i8* %_174 to i32** 
	%_176 = load i32*, i32** %_175
	%_177 = load i32, i32* %j
	%_178 = load i32, i32* %_176
	%_179 = icmp sge i32 %_177, 0
	%_180 = icmp slt i32 %_177, %_178
	%_181 = and i1 %_179, %_180
	br i1 %_181, label %oob_ok_10, label %oob_err_10
 
	oob_err_10: 
	call void @throw_oob()
	br label %oob_ok_10
 
	oob_ok_10: 
	%_182 = add i32 1, %_177
	%_183 = getelementptr i32, i32* %_176, i32 %_182
	%_184 = load i32, i32* %_183

	%_185 = load i32*, i32** %_167
	%_186 = load i32, i32* %_185
	%_187 = icmp sge i32 %_173, 0
	%_188 = icmp slt i32 %_173, %_186
	%_189 = and i1 %_187, %_188
	br i1 %_189, label %oob_ok_11, label %oob_err_11
 
	oob_err_11: 
	call void @throw_oob()
	br label %oob_ok_11
 
	oob_ok_11: 
	%_190 = add i32 1, %_173
	%_191 = getelementptr i32, i32* %_185, i32 %_190
	store i32 %_184, i32* %_191
 

	%_192 = getelementptr i8, i8* %this, i32 8
	%_193 = bitcast i8* %_192 to i32** 
	%_199 = load i32, i32* %j
	%_200 = load i32, i32* %t
	%_201 = load i32*, i32** %_193
	%_202 = load i32, i32* %_201
	%_203 = icmp sge i32 %_199, 0
	%_204 = icmp slt i32 %_199, %_202
	%_205 = and i1 %_203, %_204
	br i1 %_205, label %oob_ok_12, label %oob_err_12
 
	oob_err_12: 
	call void @throw_oob()
	br label %oob_ok_12
 
	oob_ok_12: 
	%_206 = add i32 1, %_199
	%_207 = getelementptr i32, i32* %_201, i32 %_206
	store i32 %_200, i32* %_207
 

	br label %if_end_8
	if_end_8: 

	%_213 = load i32, i32* %j
	%_214 = add i32 %_213, 1

	store i32 %_214,i32* %j

	br label %loop3
	loop5: 

	%_220 = load i32, i32* %i
	%_221 = sub i32 %_220, 1

	store i32 %_221,i32* %i

	br label %loop0
	loop2: 

	ret i32 0
}
 
define i32 @BBS.Print(i8* %this) {
	%j = alloca i32

	store i32 0,i32* %j

	br label %loop13
	loop13: 
	%_227 = load i32, i32* %j
	%_228 = getelementptr i8, i8* %this, i32 16
	%_229 = bitcast i8* %_228 to i32* 
	%_230 = load i32, i32* %_229
	%_231 = icmp slt i32 %_227, %_230

	br i1 %_231, label %loop14, label %loop15 
	loop14: 
	%_232 = getelementptr i8, i8* %this, i32 8
	%_233 = bitcast i8* %_232 to i32** 
	%_234 = load i32*, i32** %_233
	%_235 = load i32, i32* %j
	%_236 = load i32, i32* %_234
	%_237 = icmp sge i32 %_235, 0
	%_238 = icmp slt i32 %_235, %_236
	%_239 = and i1 %_237, %_238
	br i1 %_239, label %oob_ok_16, label %oob_err_16
 
	oob_err_16: 
	call void @throw_oob()
	br label %oob_ok_16
 
	oob_ok_16: 
	%_240 = add i32 1, %_235
	%_241 = getelementptr i32, i32* %_234, i32 %_240
	%_242 = load i32, i32* %_241

	call void (i32) @print_int(i32 %_242)

	%_248 = load i32, i32* %j
	%_249 = add i32 %_248, 1

	store i32 %_249,i32* %j

	br label %loop13
	loop15: 

	ret i32 0
}
 
define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%_250 = getelementptr i8, i8* %this, i32 16
	%_251 = bitcast i8* %_250 to i32* 
	%_257 = load i32, i32* %sz
	store i32 %_257,i32* %_251

	%_258 = getelementptr i8, i8* %this, i32 8
	%_259 = bitcast i8* %_258 to i32** 
	%_265 = load i32, i32* %sz
	%_266 = add i32 1, %_265
	%_267 = icmp sge i32 %_266, 1
	br i1 %_267, label %nsz_ok_17, label %nsz_err_17
 
	nsz_err_17: 
	call void @throw_nsz()
	br label %nsz_ok_17
 
	nsz_ok_17: 
	%_268 = call i8* @calloc(i32 %_266, i32 4) 
	%_269 = bitcast i8* %_268 to i32* 
	store i32 %_265, i32* %_269
 

	store i32* %_269,i32** %_259

	%_270 = getelementptr i8, i8* %this, i32 8
	%_271 = bitcast i8* %_270 to i32** 
	%_277 = load i32*, i32** %_271
	%_278 = load i32, i32* %_277
	%_279 = icmp sge i32 0, 0
	%_280 = icmp slt i32 0, %_278
	%_281 = and i1 %_279, %_280
	br i1 %_281, label %oob_ok_18, label %oob_err_18
 
	oob_err_18: 
	call void @throw_oob()
	br label %oob_ok_18
 
	oob_ok_18: 
	%_282 = add i32 1, 0
	%_283 = getelementptr i32, i32* %_277, i32 %_282
	store i32 20, i32* %_283
 

	%_284 = getelementptr i8, i8* %this, i32 8
	%_285 = bitcast i8* %_284 to i32** 
	%_291 = load i32*, i32** %_285
	%_292 = load i32, i32* %_291
	%_293 = icmp sge i32 1, 0
	%_294 = icmp slt i32 1, %_292
	%_295 = and i1 %_293, %_294
	br i1 %_295, label %oob_ok_19, label %oob_err_19
 
	oob_err_19: 
	call void @throw_oob()
	br label %oob_ok_19
 
	oob_ok_19: 
	%_296 = add i32 1, 1
	%_297 = getelementptr i32, i32* %_291, i32 %_296
	store i32 7, i32* %_297
 

	%_298 = getelementptr i8, i8* %this, i32 8
	%_299 = bitcast i8* %_298 to i32** 
	%_305 = load i32*, i32** %_299
	%_306 = load i32, i32* %_305
	%_307 = icmp sge i32 2, 0
	%_308 = icmp slt i32 2, %_306
	%_309 = and i1 %_307, %_308
	br i1 %_309, label %oob_ok_20, label %oob_err_20
 
	oob_err_20: 
	call void @throw_oob()
	br label %oob_ok_20
 
	oob_ok_20: 
	%_310 = add i32 1, 2
	%_311 = getelementptr i32, i32* %_305, i32 %_310
	store i32 12, i32* %_311
 

	%_312 = getelementptr i8, i8* %this, i32 8
	%_313 = bitcast i8* %_312 to i32** 
	%_319 = load i32*, i32** %_313
	%_320 = load i32, i32* %_319
	%_321 = icmp sge i32 3, 0
	%_322 = icmp slt i32 3, %_320
	%_323 = and i1 %_321, %_322
	br i1 %_323, label %oob_ok_21, label %oob_err_21
 
	oob_err_21: 
	call void @throw_oob()
	br label %oob_ok_21
 
	oob_ok_21: 
	%_324 = add i32 1, 3
	%_325 = getelementptr i32, i32* %_319, i32 %_324
	store i32 18, i32* %_325
 

	%_326 = getelementptr i8, i8* %this, i32 8
	%_327 = bitcast i8* %_326 to i32** 
	%_333 = load i32*, i32** %_327
	%_334 = load i32, i32* %_333
	%_335 = icmp sge i32 4, 0
	%_336 = icmp slt i32 4, %_334
	%_337 = and i1 %_335, %_336
	br i1 %_337, label %oob_ok_22, label %oob_err_22
 
	oob_err_22: 
	call void @throw_oob()
	br label %oob_ok_22
 
	oob_ok_22: 
	%_338 = add i32 1, 4
	%_339 = getelementptr i32, i32* %_333, i32 %_338
	store i32 2, i32* %_339
 

	%_340 = getelementptr i8, i8* %this, i32 8
	%_341 = bitcast i8* %_340 to i32** 
	%_347 = load i32*, i32** %_341
	%_348 = load i32, i32* %_347
	%_349 = icmp sge i32 5, 0
	%_350 = icmp slt i32 5, %_348
	%_351 = and i1 %_349, %_350
	br i1 %_351, label %oob_ok_23, label %oob_err_23
 
	oob_err_23: 
	call void @throw_oob()
	br label %oob_ok_23
 
	oob_ok_23: 
	%_352 = add i32 1, 5
	%_353 = getelementptr i32, i32* %_347, i32 %_352
	store i32 11, i32* %_353
 

	%_354 = getelementptr i8, i8* %this, i32 8
	%_355 = bitcast i8* %_354 to i32** 
	%_361 = load i32*, i32** %_355
	%_362 = load i32, i32* %_361
	%_363 = icmp sge i32 6, 0
	%_364 = icmp slt i32 6, %_362
	%_365 = and i1 %_363, %_364
	br i1 %_365, label %oob_ok_24, label %oob_err_24
 
	oob_err_24: 
	call void @throw_oob()
	br label %oob_ok_24
 
	oob_ok_24: 
	%_366 = add i32 1, 6
	%_367 = getelementptr i32, i32* %_361, i32 %_366
	store i32 6, i32* %_367
 

	%_368 = getelementptr i8, i8* %this, i32 8
	%_369 = bitcast i8* %_368 to i32** 
	%_375 = load i32*, i32** %_369
	%_376 = load i32, i32* %_375
	%_377 = icmp sge i32 7, 0
	%_378 = icmp slt i32 7, %_376
	%_379 = and i1 %_377, %_378
	br i1 %_379, label %oob_ok_25, label %oob_err_25
 
	oob_err_25: 
	call void @throw_oob()
	br label %oob_ok_25
 
	oob_ok_25: 
	%_380 = add i32 1, 7
	%_381 = getelementptr i32, i32* %_375, i32 %_380
	store i32 9, i32* %_381
 

	%_382 = getelementptr i8, i8* %this, i32 8
	%_383 = bitcast i8* %_382 to i32** 
	%_389 = load i32*, i32** %_383
	%_390 = load i32, i32* %_389
	%_391 = icmp sge i32 8, 0
	%_392 = icmp slt i32 8, %_390
	%_393 = and i1 %_391, %_392
	br i1 %_393, label %oob_ok_26, label %oob_err_26
 
	oob_err_26: 
	call void @throw_oob()
	br label %oob_ok_26
 
	oob_ok_26: 
	%_394 = add i32 1, 8
	%_395 = getelementptr i32, i32* %_389, i32 %_394
	store i32 19, i32* %_395
 

	%_396 = getelementptr i8, i8* %this, i32 8
	%_397 = bitcast i8* %_396 to i32** 
	%_403 = load i32*, i32** %_397
	%_404 = load i32, i32* %_403
	%_405 = icmp sge i32 9, 0
	%_406 = icmp slt i32 9, %_404
	%_407 = and i1 %_405, %_406
	br i1 %_407, label %oob_ok_27, label %oob_err_27
 
	oob_err_27: 
	call void @throw_oob()
	br label %oob_ok_27
 
	oob_ok_27: 
	%_408 = add i32 1, 9
	%_409 = getelementptr i32, i32* %_403, i32 %_408
	store i32 5, i32* %_409
 

	ret i32 0
}
 
