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
	%_12 = call i8* @calloc(i32 1, i32 38)
	%_13 = bitcast i8* %_12 to i8*** 
	%_14 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0 
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
	%_51 = getelementptr i8*, i8** %_50, i32 12 
	%_52 = load i8*, i8** %_51 
	%_53 = bitcast i8* %_52 to i1 (i8* , i32)* 
	%_54 = call i1 %_53( i8* %_45, i32 24) 

	store i1 %_54,i1* %ntb

	%_55 = load i8*, i8** %root
	%_59 = bitcast i8* %_55 to i8*** 
	%_60 = load i8**, i8*** %_59 
	%_61 = getelementptr i8*, i8** %_60, i32 12 
	%_62 = load i8*, i8** %_61 
	%_63 = bitcast i8* %_62 to i1 (i8* , i32)* 
	%_64 = call i1 %_63( i8* %_55, i32 4) 

	store i1 %_64,i1* %ntb

	%_65 = load i8*, i8** %root
	%_69 = bitcast i8* %_65 to i8*** 
	%_70 = load i8**, i8*** %_69 
	%_71 = getelementptr i8*, i8** %_70, i32 12 
	%_72 = load i8*, i8** %_71 
	%_73 = bitcast i8* %_72 to i1 (i8* , i32)* 
	%_74 = call i1 %_73( i8* %_65, i32 12) 

	store i1 %_74,i1* %ntb

	%_75 = load i8*, i8** %root
	%_79 = bitcast i8* %_75 to i8*** 
	%_80 = load i8**, i8*** %_79 
	%_81 = getelementptr i8*, i8** %_80, i32 12 
	%_82 = load i8*, i8** %_81 
	%_83 = bitcast i8* %_82 to i1 (i8* , i32)* 
	%_84 = call i1 %_83( i8* %_75, i32 20) 

	store i1 %_84,i1* %ntb

	%_85 = load i8*, i8** %root
	%_89 = bitcast i8* %_85 to i8*** 
	%_90 = load i8**, i8*** %_89 
	%_91 = getelementptr i8*, i8** %_90, i32 12 
	%_92 = load i8*, i8** %_91 
	%_93 = bitcast i8* %_92 to i1 (i8* , i32)* 
	%_94 = call i1 %_93( i8* %_85, i32 28) 

	store i1 %_94,i1* %ntb

	%_95 = load i8*, i8** %root
	%_99 = bitcast i8* %_95 to i8*** 
	%_100 = load i8**, i8*** %_99 
	%_101 = getelementptr i8*, i8** %_100, i32 12 
	%_102 = load i8*, i8** %_101 
	%_103 = bitcast i8* %_102 to i1 (i8* , i32)* 
	%_104 = call i1 %_103( i8* %_95, i32 14) 

	store i1 %_104,i1* %ntb

	%_105 = load i8*, i8** %root
	%_109 = bitcast i8* %_105 to i8*** 
	%_110 = load i8**, i8*** %_109 
	%_111 = getelementptr i8*, i8** %_110, i32 18 
	%_112 = load i8*, i8** %_111 
	%_113 = bitcast i8* %_112 to i1 (i8* )* 
	%_114 = call i1 %_113( i8* %_105) 

	store i1 %_114,i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_115 = call i8* @calloc(i32 1, i32 24)
	%_116 = bitcast i8* %_115 to i8*** 
	%_117 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0 
	store i8** %_117, i8*** %_116

	store i8* %_115,i8** %v

	call void (i32) @print_int(i32 50000000)

	%_118 = load i8*, i8** %root
	%_122 = bitcast i8* %_118 to i8*** 
	%_123 = load i8**, i8*** %_122 
	%_124 = getelementptr i8*, i8** %_123, i32 20 
	%_125 = load i8*, i8** %_124 
	%_126 = bitcast i8* %_125 to i32 (i8* , i8*)* 
	%_127 = load i8*, i8** %v
	%_128 = call i32 %_126( i8* %_118, i8* %_127) 

	store i32 %_128,i32* %nti

	call void (i32) @print_int(i32 100000000)

	%_129 = load i8*, i8** %root
	%_133 = bitcast i8* %_129 to i8*** 
	%_134 = load i8**, i8*** %_133 
	%_135 = getelementptr i8*, i8** %_134, i32 17 
	%_136 = load i8*, i8** %_135 
	%_137 = bitcast i8* %_136 to i32 (i8* , i32)* 
	%_138 = call i32 %_137( i8* %_129, i32 24) 

	call void (i32) @print_int(i32 %_138)

	%_139 = load i8*, i8** %root
	%_143 = bitcast i8* %_139 to i8*** 
	%_144 = load i8**, i8*** %_143 
	%_145 = getelementptr i8*, i8** %_144, i32 17 
	%_146 = load i8*, i8** %_145 
	%_147 = bitcast i8* %_146 to i32 (i8* , i32)* 
	%_148 = call i32 %_147( i8* %_139, i32 12) 

	call void (i32) @print_int(i32 %_148)

	%_149 = load i8*, i8** %root
	%_153 = bitcast i8* %_149 to i8*** 
	%_154 = load i8**, i8*** %_153 
	%_155 = getelementptr i8*, i8** %_154, i32 17 
	%_156 = load i8*, i8** %_155 
	%_157 = bitcast i8* %_156 to i32 (i8* , i32)* 
	%_158 = call i32 %_157( i8* %_149, i32 16) 

	call void (i32) @print_int(i32 %_158)

	%_159 = load i8*, i8** %root
	%_163 = bitcast i8* %_159 to i8*** 
	%_164 = load i8**, i8*** %_163 
	%_165 = getelementptr i8*, i8** %_164, i32 17 
	%_166 = load i8*, i8** %_165 
	%_167 = bitcast i8* %_166 to i32 (i8* , i32)* 
	%_168 = call i32 %_167( i8* %_159, i32 50) 

	call void (i32) @print_int(i32 %_168)

	%_169 = load i8*, i8** %root
	%_173 = bitcast i8* %_169 to i8*** 
	%_174 = load i8**, i8*** %_173 
	%_175 = getelementptr i8*, i8** %_174, i32 17 
	%_176 = load i8*, i8** %_175 
	%_177 = bitcast i8* %_176 to i32 (i8* , i32)* 
	%_178 = call i32 %_177( i8* %_169, i32 12) 

	call void (i32) @print_int(i32 %_178)

	%_179 = load i8*, i8** %root
	%_183 = bitcast i8* %_179 to i8*** 
	%_184 = load i8**, i8*** %_183 
	%_185 = getelementptr i8*, i8** %_184, i32 13 
	%_186 = load i8*, i8** %_185 
	%_187 = bitcast i8* %_186 to i1 (i8* , i32)* 
	%_188 = call i1 %_187( i8* %_179, i32 12) 

	store i1 %_188,i1* %ntb

	%_189 = load i8*, i8** %root
	%_193 = bitcast i8* %_189 to i8*** 
	%_194 = load i8**, i8*** %_193 
	%_195 = getelementptr i8*, i8** %_194, i32 18 
	%_196 = load i8*, i8** %_195 
	%_197 = bitcast i8* %_196 to i1 (i8* )* 
	%_198 = call i1 %_197( i8* %_189) 

	store i1 %_198,i1* %ntb

	%_199 = load i8*, i8** %root
	%_203 = bitcast i8* %_199 to i8*** 
	%_204 = load i8**, i8*** %_203 
	%_205 = getelementptr i8*, i8** %_204, i32 17 
	%_206 = load i8*, i8** %_205 
	%_207 = bitcast i8* %_206 to i32 (i8* , i32)* 
	%_208 = call i32 %_207( i8* %_199, i32 12) 

	call void (i32) @print_int(i32 %_208)

	ret i32 0
}
 
define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_209 = getelementptr i8, i8* %this, i32 24
	%_210 = bitcast i8* %_209 to i32* 
	%_211 = load i32, i32* %v_key
	store i32 %_211,i32* %_210

	%_212 = getelementptr i8, i8* %this, i32 28
	%_213 = bitcast i8* %_212 to i1* 
	store i1 0,i1* %_213

	%_214 = getelementptr i8, i8* %this, i32 29
	%_215 = bitcast i8* %_214 to i1* 
	store i1 0,i1* %_215

	ret i1 1
}
 
define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_216 = getelementptr i8, i8* %this, i32 16
	%_217 = bitcast i8* %_216 to i8** 
	%_218 = load i8*, i8** %rn
	store i8* %_218,i8** %_217

	ret i1 1
}
 
define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_219 = getelementptr i8, i8* %this, i32 8
	%_220 = bitcast i8* %_219 to i8** 
	%_221 = load i8*, i8** %ln
	store i8* %_221,i8** %_220

	ret i1 1
}
 
define i8* @Tree.GetRight(i8* %this) {
	%_222 = getelementptr i8, i8* %this, i32 16
	%_223 = bitcast i8* %_222 to i8** 
	%_224 = load i8*, i8** %_223
	ret i8* %_224
}
 
define i8* @Tree.GetLeft(i8* %this) {
	%_225 = getelementptr i8, i8* %this, i32 8
	%_226 = bitcast i8* %_225 to i8** 
	%_227 = load i8*, i8** %_226
	ret i8* %_227
}
 
define i32 @Tree.GetKey(i8* %this) {
	%_228 = getelementptr i8, i8* %this, i32 24
	%_229 = bitcast i8* %_228 to i32* 
	%_230 = load i32, i32* %_229
	ret i32 %_230
}
 
define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_231 = getelementptr i8, i8* %this, i32 24
	%_232 = bitcast i8* %_231 to i32* 
	%_233 = load i32, i32* %v_key
	store i32 %_233,i32* %_232

	ret i1 1
}
 
define i1 @Tree.GetHas_Right(i8* %this) {
	%_234 = getelementptr i8, i8* %this, i32 29
	%_235 = bitcast i8* %_234 to i1* 
	%_236 = load i1, i1* %_235
	ret i1 %_236
}
 
define i1 @Tree.GetHas_Left(i8* %this) {
	%_237 = getelementptr i8, i8* %this, i32 28
	%_238 = bitcast i8* %_237 to i1* 
	%_239 = load i1, i1* %_238
	ret i1 %_239
}
 
define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_240 = getelementptr i8, i8* %this, i32 28
	%_241 = bitcast i8* %_240 to i1* 
	%_242 = load i1, i1* %val
	store i1 %_242,i1* %_241

	ret i1 1
}
 
define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_243 = getelementptr i8, i8* %this, i32 29
	%_244 = bitcast i8* %_243 to i1* 
	%_245 = load i1, i1* %val
	store i1 %_245,i1* %_244

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

	%_246 = load i32, i32* %num2
	%_247 = add i32 %_246, 1

	store i32 %_247,i32* %nti

	%_248 = load i32, i32* %num1
	%_249 = load i32, i32* %num2
	%_250 = icmp slt i32 %_248, %_249

	br i1 %_250, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_251 = load i32, i32* %num1
	%_252 = load i32, i32* %nti
	%_253 = icmp slt i32 %_251, %_252

	%_254 = xor i1 1, %_253

	br i1 %_254, label %if_then_1, label %if_else_1 
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

	%_255 = load i1, i1* %ntb
	ret i1 %_255
}
 
define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%current_node = alloca i8*
	%cont = alloca i1
	%key_aux = alloca i32
	%_256 = call i8* @calloc(i32 1, i32 38)
	%_257 = bitcast i8* %_256 to i8*** 
	%_258 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0 
	store i8** %_258, i8*** %_257

	store i8* %_256,i8** %new_node

	%_259 = load i8*, i8** %new_node
	%_263 = bitcast i8* %_259 to i8*** 
	%_264 = load i8**, i8*** %_263 
	%_265 = getelementptr i8*, i8** %_264, i32 0 
	%_266 = load i8*, i8** %_265 
	%_267 = bitcast i8* %_266 to i1 (i8* , i32)* 
	%_268 = load i32, i32* %v_key
	%_269 = call i1 %_267( i8* %_259, i32 %_268) 

	store i1 %_269,i1* %ntb

	store i8* %this,i8** %current_node

	store i1 1,i1* %cont

	br label %loop2
	loop2: 
	%_270 = load i1, i1* %cont
	br i1 %_270, label %loop3, label %loop4 
	loop3: 
	%_271 = load i8*, i8** %current_node
	%_275 = bitcast i8* %_271 to i8*** 
	%_276 = load i8**, i8*** %_275 
	%_277 = getelementptr i8*, i8** %_276, i32 5 
	%_278 = load i8*, i8** %_277 
	%_279 = bitcast i8* %_278 to i32 (i8* )* 
	%_280 = call i32 %_279( i8* %_271) 

	store i32 %_280,i32* %key_aux

	%_281 = load i32, i32* %v_key
	%_282 = load i32, i32* %key_aux
	%_283 = icmp slt i32 %_281, %_282

	br i1 %_283, label %if_then_5, label %if_else_5 
	if_else_5: 
	%_284 = load i8*, i8** %current_node
	%_288 = bitcast i8* %_284 to i8*** 
	%_289 = load i8**, i8*** %_288 
	%_290 = getelementptr i8*, i8** %_289, i32 7 
	%_291 = load i8*, i8** %_290 
	%_292 = bitcast i8* %_291 to i1 (i8* )* 
	%_293 = call i1 %_292( i8* %_284) 

	br i1 %_293, label %if_then_6, label %if_else_6 
	if_else_6: 
	store i1 0,i1* %cont

	%_294 = load i8*, i8** %current_node
	%_298 = bitcast i8* %_294 to i8*** 
	%_299 = load i8**, i8*** %_298 
	%_300 = getelementptr i8*, i8** %_299, i32 10 
	%_301 = load i8*, i8** %_300 
	%_302 = bitcast i8* %_301 to i1 (i8* , i1)* 
	%_303 = call i1 %_302( i8* %_294, i1 1) 

	store i1 %_303,i1* %ntb

	%_304 = load i8*, i8** %current_node
	%_308 = bitcast i8* %_304 to i8*** 
	%_309 = load i8**, i8*** %_308 
	%_310 = getelementptr i8*, i8** %_309, i32 1 
	%_311 = load i8*, i8** %_310 
	%_312 = bitcast i8* %_311 to i1 (i8* , i8*)* 
	%_313 = load i8*, i8** %new_node
	%_314 = call i1 %_312( i8* %_304, i8* %_313) 

	store i1 %_314,i1* %ntb

	br label %if_end_6
	if_then_6: 
	%_315 = load i8*, i8** %current_node
	%_319 = bitcast i8* %_315 to i8*** 
	%_320 = load i8**, i8*** %_319 
	%_321 = getelementptr i8*, i8** %_320, i32 3 
	%_322 = load i8*, i8** %_321 
	%_323 = bitcast i8* %_322 to i8* (i8* )* 
	%_324 = call i8* %_323( i8* %_315) 

	store i8* %_324,i8** %current_node

	br label %if_end_6
	if_end_6: 

	br label %if_end_5
	if_then_5: 
	%_325 = load i8*, i8** %current_node
	%_329 = bitcast i8* %_325 to i8*** 
	%_330 = load i8**, i8*** %_329 
	%_331 = getelementptr i8*, i8** %_330, i32 8 
	%_332 = load i8*, i8** %_331 
	%_333 = bitcast i8* %_332 to i1 (i8* )* 
	%_334 = call i1 %_333( i8* %_325) 

	br i1 %_334, label %if_then_7, label %if_else_7 
	if_else_7: 
	store i1 0,i1* %cont

	%_335 = load i8*, i8** %current_node
	%_339 = bitcast i8* %_335 to i8*** 
	%_340 = load i8**, i8*** %_339 
	%_341 = getelementptr i8*, i8** %_340, i32 9 
	%_342 = load i8*, i8** %_341 
	%_343 = bitcast i8* %_342 to i1 (i8* , i1)* 
	%_344 = call i1 %_343( i8* %_335, i1 1) 

	store i1 %_344,i1* %ntb

	%_345 = load i8*, i8** %current_node
	%_349 = bitcast i8* %_345 to i8*** 
	%_350 = load i8**, i8*** %_349 
	%_351 = getelementptr i8*, i8** %_350, i32 2 
	%_352 = load i8*, i8** %_351 
	%_353 = bitcast i8* %_352 to i1 (i8* , i8*)* 
	%_354 = load i8*, i8** %new_node
	%_355 = call i1 %_353( i8* %_345, i8* %_354) 

	store i1 %_355,i1* %ntb

	br label %if_end_7
	if_then_7: 
	%_356 = load i8*, i8** %current_node
	%_360 = bitcast i8* %_356 to i8*** 
	%_361 = load i8**, i8*** %_360 
	%_362 = getelementptr i8*, i8** %_361, i32 4 
	%_363 = load i8*, i8** %_362 
	%_364 = bitcast i8* %_363 to i8* (i8* )* 
	%_365 = call i8* %_364( i8* %_356) 

	store i8* %_365,i8** %current_node

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
	%_366 = load i1, i1* %cont
	br i1 %_366, label %loop9, label %loop10 
	loop9: 
	%_367 = load i8*, i8** %current_node
	%_371 = bitcast i8* %_367 to i8*** 
	%_372 = load i8**, i8*** %_371 
	%_373 = getelementptr i8*, i8** %_372, i32 5 
	%_374 = load i8*, i8** %_373 
	%_375 = bitcast i8* %_374 to i32 (i8* )* 
	%_376 = call i32 %_375( i8* %_367) 

	store i32 %_376,i32* %key_aux

	%_377 = load i32, i32* %v_key
	%_378 = load i32, i32* %key_aux
	%_379 = icmp slt i32 %_377, %_378

	br i1 %_379, label %if_then_11, label %if_else_11 
	if_else_11: 
	%_380 = load i32, i32* %key_aux
	%_381 = load i32, i32* %v_key
	%_382 = icmp slt i32 %_380, %_381

	br i1 %_382, label %if_then_12, label %if_else_12 
	if_else_12: 
	%_383 = load i1, i1* %is_root
	br i1 %_383, label %if_then_13, label %if_else_13 
	if_else_13: 
	%_387 = bitcast i8* %this to i8*** 
	%_388 = load i8**, i8*** %_387 
	%_389 = getelementptr i8*, i8** %_388, i32 14 
	%_390 = load i8*, i8** %_389 
	%_391 = bitcast i8* %_390 to i1 (i8* , i8*, i8*)* 
	%_392 = load i8*, i8** %parent_node
	%_393 = load i8*, i8** %current_node
	%_394 = call i1 %_391( i8* %this, i8* %_392, i8* %_393) 

	store i1 %_394,i1* %ntb

	br label %if_end_13
	if_then_13: 
	%_395 = load i8*, i8** %current_node
	%_399 = bitcast i8* %_395 to i8*** 
	%_400 = load i8**, i8*** %_399 
	%_401 = getelementptr i8*, i8** %_400, i32 7 
	%_402 = load i8*, i8** %_401 
	%_403 = bitcast i8* %_402 to i1 (i8* )* 
	%_404 = call i1 %_403( i8* %_395) 

	%_405 = xor i1 1, %_404

	br i1 %_405, label %and_clause16, label %and_clause15 
	and_clause15: 
	br label %and_clause17
	and_clause16: 
	%_406 = load i8*, i8** %current_node
	%_410 = bitcast i8* %_406 to i8*** 
	%_411 = load i8**, i8*** %_410 
	%_412 = getelementptr i8*, i8** %_411, i32 8 
	%_413 = load i8*, i8** %_412 
	%_414 = bitcast i8* %_413 to i1 (i8* )* 
	%_415 = call i1 %_414( i8* %_406) 

	%_416 = xor i1 1, %_415

	br label %and_clause17
	and_clause17: 
	br label %and_clause18
	and_clause18: 
	%_417 = phi i1 [ 0, %and_clause15 ], [ %_416, %and_clause17] 

	br i1 %_417, label %if_then_14, label %if_else_14 
	if_else_14: 
	%_421 = bitcast i8* %this to i8*** 
	%_422 = load i8**, i8*** %_421 
	%_423 = getelementptr i8*, i8** %_422, i32 14 
	%_424 = load i8*, i8** %_423 
	%_425 = bitcast i8* %_424 to i1 (i8* , i8*, i8*)* 
	%_426 = load i8*, i8** %parent_node
	%_427 = load i8*, i8** %current_node
	%_428 = call i1 %_425( i8* %this, i8* %_426, i8* %_427) 

	store i1 %_428,i1* %ntb

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
	%_429 = load i8*, i8** %current_node
	%_433 = bitcast i8* %_429 to i8*** 
	%_434 = load i8**, i8*** %_433 
	%_435 = getelementptr i8*, i8** %_434, i32 7 
	%_436 = load i8*, i8** %_435 
	%_437 = bitcast i8* %_436 to i1 (i8* )* 
	%_438 = call i1 %_437( i8* %_429) 

	br i1 %_438, label %if_then_19, label %if_else_19 
	if_else_19: 
	store i1 0,i1* %cont

	br label %if_end_19
	if_then_19: 
	%_439 = load i8*, i8** %current_node
	store i8* %_439,i8** %parent_node

	%_440 = load i8*, i8** %current_node
	%_444 = bitcast i8* %_440 to i8*** 
	%_445 = load i8**, i8*** %_444 
	%_446 = getelementptr i8*, i8** %_445, i32 3 
	%_447 = load i8*, i8** %_446 
	%_448 = bitcast i8* %_447 to i8* (i8* )* 
	%_449 = call i8* %_448( i8* %_440) 

	store i8* %_449,i8** %current_node

	br label %if_end_19
	if_end_19: 

	br label %if_end_12
	if_end_12: 

	br label %if_end_11
	if_then_11: 
	%_450 = load i8*, i8** %current_node
	%_454 = bitcast i8* %_450 to i8*** 
	%_455 = load i8**, i8*** %_454 
	%_456 = getelementptr i8*, i8** %_455, i32 8 
	%_457 = load i8*, i8** %_456 
	%_458 = bitcast i8* %_457 to i1 (i8* )* 
	%_459 = call i1 %_458( i8* %_450) 

	br i1 %_459, label %if_then_20, label %if_else_20 
	if_else_20: 
	store i1 0,i1* %cont

	br label %if_end_20
	if_then_20: 
	%_460 = load i8*, i8** %current_node
	store i8* %_460,i8** %parent_node

	%_461 = load i8*, i8** %current_node
	%_465 = bitcast i8* %_461 to i8*** 
	%_466 = load i8**, i8*** %_465 
	%_467 = getelementptr i8*, i8** %_466, i32 4 
	%_468 = load i8*, i8** %_467 
	%_469 = bitcast i8* %_468 to i8* (i8* )* 
	%_470 = call i8* %_469( i8* %_461) 

	store i8* %_470,i8** %current_node

	br label %if_end_20
	if_end_20: 

	br label %if_end_11
	if_end_11: 

	store i1 0,i1* %is_root

	br label %loop8
	loop10: 

	%_471 = load i1, i1* %found
	ret i1 %_471
}
 
define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
	%_472 = load i8*, i8** %c_node
	%_476 = bitcast i8* %_472 to i8*** 
	%_477 = load i8**, i8*** %_476 
	%_478 = getelementptr i8*, i8** %_477, i32 8 
	%_479 = load i8*, i8** %_478 
	%_480 = bitcast i8* %_479 to i1 (i8* )* 
	%_481 = call i1 %_480( i8* %_472) 

	br i1 %_481, label %if_then_21, label %if_else_21 
	if_else_21: 
	%_482 = load i8*, i8** %c_node
	%_486 = bitcast i8* %_482 to i8*** 
	%_487 = load i8**, i8*** %_486 
	%_488 = getelementptr i8*, i8** %_487, i32 7 
	%_489 = load i8*, i8** %_488 
	%_490 = bitcast i8* %_489 to i1 (i8* )* 
	%_491 = call i1 %_490( i8* %_482) 

	br i1 %_491, label %if_then_22, label %if_else_22 
	if_else_22: 
	%_492 = load i8*, i8** %c_node
	%_496 = bitcast i8* %_492 to i8*** 
	%_497 = load i8**, i8*** %_496 
	%_498 = getelementptr i8*, i8** %_497, i32 5 
	%_499 = load i8*, i8** %_498 
	%_500 = bitcast i8* %_499 to i32 (i8* )* 
	%_501 = call i32 %_500( i8* %_492) 

	store i32 %_501,i32* %auxkey1

	%_502 = load i8*, i8** %p_node
	%_506 = bitcast i8* %_502 to i8*** 
	%_507 = load i8**, i8*** %_506 
	%_508 = getelementptr i8*, i8** %_507, i32 4 
	%_509 = load i8*, i8** %_508 
	%_510 = bitcast i8* %_509 to i8* (i8* )* 
	%_511 = call i8* %_510( i8* %_502) 

	%_512 = load i8*, i8** %p_node
	%_516 = bitcast i8* %_512 to i8*** 
	%_517 = load i8**, i8*** %_516 
	%_518 = getelementptr i8*, i8** %_517, i32 4 
	%_519 = load i8*, i8** %_518 
	%_520 = bitcast i8* %_519 to i8* (i8* )* 
	%_521 = call i8* %_520( i8* %_512) 

	%_525 = bitcast i8* %_521 to i8*** 
	%_526 = load i8**, i8*** %_525 
	%_527 = getelementptr i8*, i8** %_526, i32 5 
	%_528 = load i8*, i8** %_527 
	%_529 = bitcast i8* %_528 to i32 (i8* )* 
	%_530 = call i32 %_529( i8* %_521) 

	store i32 %_530,i32* %auxkey2

	%_534 = bitcast i8* %this to i8*** 
	%_535 = load i8**, i8*** %_534 
	%_536 = getelementptr i8*, i8** %_535, i32 11 
	%_537 = load i8*, i8** %_536 
	%_538 = bitcast i8* %_537 to i1 (i8* , i32, i32)* 
	%_539 = load i32, i32* %auxkey1
	%_540 = load i32, i32* %auxkey2
	%_541 = call i1 %_538( i8* %this, i32 %_539, i32 %_540) 

	br i1 %_541, label %if_then_23, label %if_else_23 
	if_else_23: 
	%_542 = load i8*, i8** %p_node
	%_546 = bitcast i8* %_542 to i8*** 
	%_547 = load i8**, i8*** %_546 
	%_548 = getelementptr i8*, i8** %_547, i32 1 
	%_549 = load i8*, i8** %_548 
	%_550 = bitcast i8* %_549 to i1 (i8* , i8*)* 
	%_551 = getelementptr i8, i8* %this, i32 30
	%_552 = bitcast i8* %_551 to i8** 
	%_553 = load i8*, i8** %_552
	%_554 = call i1 %_550( i8* %_542, i8* %_553) 

	store i1 %_554,i1* %ntb

	%_555 = load i8*, i8** %p_node
	%_559 = bitcast i8* %_555 to i8*** 
	%_560 = load i8**, i8*** %_559 
	%_561 = getelementptr i8*, i8** %_560, i32 10 
	%_562 = load i8*, i8** %_561 
	%_563 = bitcast i8* %_562 to i1 (i8* , i1)* 
	%_564 = call i1 %_563( i8* %_555, i1 0) 

	store i1 %_564,i1* %ntb

	br label %if_end_23
	if_then_23: 
	%_565 = load i8*, i8** %p_node
	%_569 = bitcast i8* %_565 to i8*** 
	%_570 = load i8**, i8*** %_569 
	%_571 = getelementptr i8*, i8** %_570, i32 2 
	%_572 = load i8*, i8** %_571 
	%_573 = bitcast i8* %_572 to i1 (i8* , i8*)* 
	%_574 = getelementptr i8, i8* %this, i32 30
	%_575 = bitcast i8* %_574 to i8** 
	%_576 = load i8*, i8** %_575
	%_577 = call i1 %_573( i8* %_565, i8* %_576) 

	store i1 %_577,i1* %ntb

	%_578 = load i8*, i8** %p_node
	%_582 = bitcast i8* %_578 to i8*** 
	%_583 = load i8**, i8*** %_582 
	%_584 = getelementptr i8*, i8** %_583, i32 9 
	%_585 = load i8*, i8** %_584 
	%_586 = bitcast i8* %_585 to i1 (i8* , i1)* 
	%_587 = call i1 %_586( i8* %_578, i1 0) 

	store i1 %_587,i1* %ntb

	br label %if_end_23
	if_end_23: 

	br label %if_end_22
	if_then_22: 
	%_591 = bitcast i8* %this to i8*** 
	%_592 = load i8**, i8*** %_591 
	%_593 = getelementptr i8*, i8** %_592, i32 15 
	%_594 = load i8*, i8** %_593 
	%_595 = bitcast i8* %_594 to i1 (i8* , i8*, i8*)* 
	%_596 = load i8*, i8** %p_node
	%_597 = load i8*, i8** %c_node
	%_598 = call i1 %_595( i8* %this, i8* %_596, i8* %_597) 

	store i1 %_598,i1* %ntb

	br label %if_end_22
	if_end_22: 

	br label %if_end_21
	if_then_21: 
	%_602 = bitcast i8* %this to i8*** 
	%_603 = load i8**, i8*** %_602 
	%_604 = getelementptr i8*, i8** %_603, i32 16 
	%_605 = load i8*, i8** %_604 
	%_606 = bitcast i8* %_605 to i1 (i8* , i8*, i8*)* 
	%_607 = load i8*, i8** %p_node
	%_608 = load i8*, i8** %c_node
	%_609 = call i1 %_606( i8* %this, i8* %_607, i8* %_608) 

	store i1 %_609,i1* %ntb

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
	%_610 = load i8*, i8** %c_node
	%_614 = bitcast i8* %_610 to i8*** 
	%_615 = load i8**, i8*** %_614 
	%_616 = getelementptr i8*, i8** %_615, i32 7 
	%_617 = load i8*, i8** %_616 
	%_618 = bitcast i8* %_617 to i1 (i8* )* 
	%_619 = call i1 %_618( i8* %_610) 

	br i1 %_619, label %loop25, label %loop26 
	loop25: 
	%_620 = load i8*, i8** %c_node
	%_624 = bitcast i8* %_620 to i8*** 
	%_625 = load i8**, i8*** %_624 
	%_626 = getelementptr i8*, i8** %_625, i32 6 
	%_627 = load i8*, i8** %_626 
	%_628 = bitcast i8* %_627 to i1 (i8* , i32)* 
	%_629 = load i8*, i8** %c_node
	%_633 = bitcast i8* %_629 to i8*** 
	%_634 = load i8**, i8*** %_633 
	%_635 = getelementptr i8*, i8** %_634, i32 3 
	%_636 = load i8*, i8** %_635 
	%_637 = bitcast i8* %_636 to i8* (i8* )* 
	%_638 = call i8* %_637( i8* %_629) 

	%_639 = load i8*, i8** %c_node
	%_643 = bitcast i8* %_639 to i8*** 
	%_644 = load i8**, i8*** %_643 
	%_645 = getelementptr i8*, i8** %_644, i32 3 
	%_646 = load i8*, i8** %_645 
	%_647 = bitcast i8* %_646 to i8* (i8* )* 
	%_648 = call i8* %_647( i8* %_639) 

	%_652 = bitcast i8* %_648 to i8*** 
	%_653 = load i8**, i8*** %_652 
	%_654 = getelementptr i8*, i8** %_653, i32 5 
	%_655 = load i8*, i8** %_654 
	%_656 = bitcast i8* %_655 to i32 (i8* )* 
	%_657 = call i32 %_656( i8* %_648) 

	%_658 = call i1 %_628( i8* %_620, i32 %_657) 

	store i1 %_658,i1* %ntb

	%_659 = load i8*, i8** %c_node
	store i8* %_659,i8** %p_node

	%_660 = load i8*, i8** %c_node
	%_664 = bitcast i8* %_660 to i8*** 
	%_665 = load i8**, i8*** %_664 
	%_666 = getelementptr i8*, i8** %_665, i32 3 
	%_667 = load i8*, i8** %_666 
	%_668 = bitcast i8* %_667 to i8* (i8* )* 
	%_669 = call i8* %_668( i8* %_660) 

	store i8* %_669,i8** %c_node

	br label %loop24
	loop26: 

	%_670 = load i8*, i8** %p_node
	%_674 = bitcast i8* %_670 to i8*** 
	%_675 = load i8**, i8*** %_674 
	%_676 = getelementptr i8*, i8** %_675, i32 1 
	%_677 = load i8*, i8** %_676 
	%_678 = bitcast i8* %_677 to i1 (i8* , i8*)* 
	%_679 = getelementptr i8, i8* %this, i32 30
	%_680 = bitcast i8* %_679 to i8** 
	%_681 = load i8*, i8** %_680
	%_682 = call i1 %_678( i8* %_670, i8* %_681) 

	store i1 %_682,i1* %ntb

	%_683 = load i8*, i8** %p_node
	%_687 = bitcast i8* %_683 to i8*** 
	%_688 = load i8**, i8*** %_687 
	%_689 = getelementptr i8*, i8** %_688, i32 10 
	%_690 = load i8*, i8** %_689 
	%_691 = bitcast i8* %_690 to i1 (i8* , i1)* 
	%_692 = call i1 %_691( i8* %_683, i1 0) 

	store i1 %_692,i1* %ntb

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
	%_693 = load i8*, i8** %c_node
	%_697 = bitcast i8* %_693 to i8*** 
	%_698 = load i8**, i8*** %_697 
	%_699 = getelementptr i8*, i8** %_698, i32 8 
	%_700 = load i8*, i8** %_699 
	%_701 = bitcast i8* %_700 to i1 (i8* )* 
	%_702 = call i1 %_701( i8* %_693) 

	br i1 %_702, label %loop28, label %loop29 
	loop28: 
	%_703 = load i8*, i8** %c_node
	%_707 = bitcast i8* %_703 to i8*** 
	%_708 = load i8**, i8*** %_707 
	%_709 = getelementptr i8*, i8** %_708, i32 6 
	%_710 = load i8*, i8** %_709 
	%_711 = bitcast i8* %_710 to i1 (i8* , i32)* 
	%_712 = load i8*, i8** %c_node
	%_716 = bitcast i8* %_712 to i8*** 
	%_717 = load i8**, i8*** %_716 
	%_718 = getelementptr i8*, i8** %_717, i32 4 
	%_719 = load i8*, i8** %_718 
	%_720 = bitcast i8* %_719 to i8* (i8* )* 
	%_721 = call i8* %_720( i8* %_712) 

	%_722 = load i8*, i8** %c_node
	%_726 = bitcast i8* %_722 to i8*** 
	%_727 = load i8**, i8*** %_726 
	%_728 = getelementptr i8*, i8** %_727, i32 4 
	%_729 = load i8*, i8** %_728 
	%_730 = bitcast i8* %_729 to i8* (i8* )* 
	%_731 = call i8* %_730( i8* %_722) 

	%_735 = bitcast i8* %_731 to i8*** 
	%_736 = load i8**, i8*** %_735 
	%_737 = getelementptr i8*, i8** %_736, i32 5 
	%_738 = load i8*, i8** %_737 
	%_739 = bitcast i8* %_738 to i32 (i8* )* 
	%_740 = call i32 %_739( i8* %_731) 

	%_741 = call i1 %_711( i8* %_703, i32 %_740) 

	store i1 %_741,i1* %ntb

	%_742 = load i8*, i8** %c_node
	store i8* %_742,i8** %p_node

	%_743 = load i8*, i8** %c_node
	%_747 = bitcast i8* %_743 to i8*** 
	%_748 = load i8**, i8*** %_747 
	%_749 = getelementptr i8*, i8** %_748, i32 4 
	%_750 = load i8*, i8** %_749 
	%_751 = bitcast i8* %_750 to i8* (i8* )* 
	%_752 = call i8* %_751( i8* %_743) 

	store i8* %_752,i8** %c_node

	br label %loop27
	loop29: 

	%_753 = load i8*, i8** %p_node
	%_757 = bitcast i8* %_753 to i8*** 
	%_758 = load i8**, i8*** %_757 
	%_759 = getelementptr i8*, i8** %_758, i32 2 
	%_760 = load i8*, i8** %_759 
	%_761 = bitcast i8* %_760 to i1 (i8* , i8*)* 
	%_762 = getelementptr i8, i8* %this, i32 30
	%_763 = bitcast i8* %_762 to i8** 
	%_764 = load i8*, i8** %_763
	%_765 = call i1 %_761( i8* %_753, i8* %_764) 

	store i1 %_765,i1* %ntb

	%_766 = load i8*, i8** %p_node
	%_770 = bitcast i8* %_766 to i8*** 
	%_771 = load i8**, i8*** %_770 
	%_772 = getelementptr i8*, i8** %_771, i32 9 
	%_773 = load i8*, i8** %_772 
	%_774 = bitcast i8* %_773 to i1 (i8* , i1)* 
	%_775 = call i1 %_774( i8* %_766, i1 0) 

	store i1 %_775,i1* %ntb

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
	%_776 = load i1, i1* %cont
	br i1 %_776, label %loop31, label %loop32 
	loop31: 
	%_777 = load i8*, i8** %current_node
	%_781 = bitcast i8* %_777 to i8*** 
	%_782 = load i8**, i8*** %_781 
	%_783 = getelementptr i8*, i8** %_782, i32 5 
	%_784 = load i8*, i8** %_783 
	%_785 = bitcast i8* %_784 to i32 (i8* )* 
	%_786 = call i32 %_785( i8* %_777) 

	store i32 %_786,i32* %key_aux

	%_787 = load i32, i32* %v_key
	%_788 = load i32, i32* %key_aux
	%_789 = icmp slt i32 %_787, %_788

	br i1 %_789, label %if_then_33, label %if_else_33 
	if_else_33: 
	%_790 = load i32, i32* %key_aux
	%_791 = load i32, i32* %v_key
	%_792 = icmp slt i32 %_790, %_791

	br i1 %_792, label %if_then_34, label %if_else_34 
	if_else_34: 
	store i32 1,i32* %ifound

	store i1 0,i1* %cont

	br label %if_end_34
	if_then_34: 
	%_793 = load i8*, i8** %current_node
	%_797 = bitcast i8* %_793 to i8*** 
	%_798 = load i8**, i8*** %_797 
	%_799 = getelementptr i8*, i8** %_798, i32 7 
	%_800 = load i8*, i8** %_799 
	%_801 = bitcast i8* %_800 to i1 (i8* )* 
	%_802 = call i1 %_801( i8* %_793) 

	br i1 %_802, label %if_then_35, label %if_else_35 
	if_else_35: 
	store i1 0,i1* %cont

	br label %if_end_35
	if_then_35: 
	%_803 = load i8*, i8** %current_node
	%_807 = bitcast i8* %_803 to i8*** 
	%_808 = load i8**, i8*** %_807 
	%_809 = getelementptr i8*, i8** %_808, i32 3 
	%_810 = load i8*, i8** %_809 
	%_811 = bitcast i8* %_810 to i8* (i8* )* 
	%_812 = call i8* %_811( i8* %_803) 

	store i8* %_812,i8** %current_node

	br label %if_end_35
	if_end_35: 

	br label %if_end_34
	if_end_34: 

	br label %if_end_33
	if_then_33: 
	%_813 = load i8*, i8** %current_node
	%_817 = bitcast i8* %_813 to i8*** 
	%_818 = load i8**, i8*** %_817 
	%_819 = getelementptr i8*, i8** %_818, i32 8 
	%_820 = load i8*, i8** %_819 
	%_821 = bitcast i8* %_820 to i1 (i8* )* 
	%_822 = call i1 %_821( i8* %_813) 

	br i1 %_822, label %if_then_36, label %if_else_36 
	if_else_36: 
	store i1 0,i1* %cont

	br label %if_end_36
	if_then_36: 
	%_823 = load i8*, i8** %current_node
	%_827 = bitcast i8* %_823 to i8*** 
	%_828 = load i8**, i8*** %_827 
	%_829 = getelementptr i8*, i8** %_828, i32 4 
	%_830 = load i8*, i8** %_829 
	%_831 = bitcast i8* %_830 to i8* (i8* )* 
	%_832 = call i8* %_831( i8* %_823) 

	store i8* %_832,i8** %current_node

	br label %if_end_36
	if_end_36: 

	br label %if_end_33
	if_end_33: 

	br label %loop30
	loop32: 

	%_833 = load i32, i32* %ifound
	ret i32 %_833
}
 
define i1 @Tree.Print(i8* %this) {
	%ntb = alloca i1
	%current_node = alloca i8*
	store i8* %this,i8** %current_node

	%_837 = bitcast i8* %this to i8*** 
	%_838 = load i8**, i8*** %_837 
	%_839 = getelementptr i8*, i8** %_838, i32 19 
	%_840 = load i8*, i8** %_839 
	%_841 = bitcast i8* %_840 to i1 (i8* , i8*)* 
	%_842 = load i8*, i8** %current_node
	%_843 = call i1 %_841( i8* %this, i8* %_842) 

	store i1 %_843,i1* %ntb

	ret i1 1
}
 
define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1
	%_844 = load i8*, i8** %node
	%_848 = bitcast i8* %_844 to i8*** 
	%_849 = load i8**, i8*** %_848 
	%_850 = getelementptr i8*, i8** %_849, i32 8 
	%_851 = load i8*, i8** %_850 
	%_852 = bitcast i8* %_851 to i1 (i8* )* 
	%_853 = call i1 %_852( i8* %_844) 

	br i1 %_853, label %if_then_37, label %if_else_37 
	if_else_37: 
	store i1 1,i1* %ntb

	br label %if_end_37
	if_then_37: 
	%_857 = bitcast i8* %this to i8*** 
	%_858 = load i8**, i8*** %_857 
	%_859 = getelementptr i8*, i8** %_858, i32 19 
	%_860 = load i8*, i8** %_859 
	%_861 = bitcast i8* %_860 to i1 (i8* , i8*)* 
	%_862 = load i8*, i8** %node
	%_866 = bitcast i8* %_862 to i8*** 
	%_867 = load i8**, i8*** %_866 
	%_868 = getelementptr i8*, i8** %_867, i32 4 
	%_869 = load i8*, i8** %_868 
	%_870 = bitcast i8* %_869 to i8* (i8* )* 
	%_871 = call i8* %_870( i8* %_862) 

	%_872 = call i1 %_861( i8* %this, i8* %_871) 

	store i1 %_872,i1* %ntb

	br label %if_end_37
	if_end_37: 

	%_873 = load i8*, i8** %node
	%_877 = bitcast i8* %_873 to i8*** 
	%_878 = load i8**, i8*** %_877 
	%_879 = getelementptr i8*, i8** %_878, i32 5 
	%_880 = load i8*, i8** %_879 
	%_881 = bitcast i8* %_880 to i32 (i8* )* 
	%_882 = call i32 %_881( i8* %_873) 

	call void (i32) @print_int(i32 %_882)

	%_883 = load i8*, i8** %node
	%_887 = bitcast i8* %_883 to i8*** 
	%_888 = load i8**, i8*** %_887 
	%_889 = getelementptr i8*, i8** %_888, i32 7 
	%_890 = load i8*, i8** %_889 
	%_891 = bitcast i8* %_890 to i1 (i8* )* 
	%_892 = call i1 %_891( i8* %_883) 

	br i1 %_892, label %if_then_38, label %if_else_38 
	if_else_38: 
	store i1 1,i1* %ntb

	br label %if_end_38
	if_then_38: 
	%_896 = bitcast i8* %this to i8*** 
	%_897 = load i8**, i8*** %_896 
	%_898 = getelementptr i8*, i8** %_897, i32 19 
	%_899 = load i8*, i8** %_898 
	%_900 = bitcast i8* %_899 to i1 (i8* , i8*)* 
	%_901 = load i8*, i8** %node
	%_905 = bitcast i8* %_901 to i8*** 
	%_906 = load i8**, i8*** %_905 
	%_907 = getelementptr i8*, i8** %_906, i32 3 
	%_908 = load i8*, i8** %_907 
	%_909 = bitcast i8* %_908 to i8* (i8* )* 
	%_910 = call i8* %_909( i8* %_901) 

	%_911 = call i1 %_900( i8* %this, i8* %_910) 

	store i1 %_911,i1* %ntb

	br label %if_end_38
	if_end_38: 

	ret i1 1
}
 
define i32 @Tree.accept(i8* %this, i8* %.v) {
	%v = alloca i8*
	store i8* %.v, i8** %v
	%nti = alloca i32
	call void (i32) @print_int(i32 333)

	%_912 = load i8*, i8** %v
	%_916 = bitcast i8* %_912 to i8*** 
	%_917 = load i8**, i8*** %_916 
	%_918 = getelementptr i8*, i8** %_917, i32 0 
	%_919 = load i8*, i8** %_918 
	%_920 = bitcast i8* %_919 to i32 (i8* , i8*)* 
	%_921 = call i32 %_920( i8* %_912, i8* %this) 

	store i32 %_921,i32* %nti

	ret i32 0
}
 
define i32 @Visitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32
	%_922 = load i8*, i8** %n
	%_926 = bitcast i8* %_922 to i8*** 
	%_927 = load i8**, i8*** %_926 
	%_928 = getelementptr i8*, i8** %_927, i32 7 
	%_929 = load i8*, i8** %_928 
	%_930 = bitcast i8* %_929 to i1 (i8* )* 
	%_931 = call i1 %_930( i8* %_922) 

	br i1 %_931, label %if_then_39, label %if_else_39 
	if_else_39: 
	store i32 0,i32* %nti

	br label %if_end_39
	if_then_39: 
	%_932 = getelementptr i8, i8* %this, i32 16
	%_933 = bitcast i8* %_932 to i8** 
	%_934 = load i8*, i8** %n
	%_938 = bitcast i8* %_934 to i8*** 
	%_939 = load i8**, i8*** %_938 
	%_940 = getelementptr i8*, i8** %_939, i32 3 
	%_941 = load i8*, i8** %_940 
	%_942 = bitcast i8* %_941 to i8* (i8* )* 
	%_943 = call i8* %_942( i8* %_934) 

	store i8* %_943,i8** %_933

	%_944 = getelementptr i8, i8* %this, i32 16
	%_945 = bitcast i8* %_944 to i8** 
	%_946 = load i8*, i8** %_945
	%_950 = bitcast i8* %_946 to i8*** 
	%_951 = load i8**, i8*** %_950 
	%_952 = getelementptr i8*, i8** %_951, i32 20 
	%_953 = load i8*, i8** %_952 
	%_954 = bitcast i8* %_953 to i32 (i8* , i8*)* 
	%_955 = call i32 %_954( i8* %_946, i8* %this) 

	store i32 %_955,i32* %nti

	br label %if_end_39
	if_end_39: 

	%_956 = load i8*, i8** %n
	%_960 = bitcast i8* %_956 to i8*** 
	%_961 = load i8**, i8*** %_960 
	%_962 = getelementptr i8*, i8** %_961, i32 8 
	%_963 = load i8*, i8** %_962 
	%_964 = bitcast i8* %_963 to i1 (i8* )* 
	%_965 = call i1 %_964( i8* %_956) 

	br i1 %_965, label %if_then_40, label %if_else_40 
	if_else_40: 
	store i32 0,i32* %nti

	br label %if_end_40
	if_then_40: 
	%_966 = getelementptr i8, i8* %this, i32 8
	%_967 = bitcast i8* %_966 to i8** 
	%_968 = load i8*, i8** %n
	%_972 = bitcast i8* %_968 to i8*** 
	%_973 = load i8**, i8*** %_972 
	%_974 = getelementptr i8*, i8** %_973, i32 4 
	%_975 = load i8*, i8** %_974 
	%_976 = bitcast i8* %_975 to i8* (i8* )* 
	%_977 = call i8* %_976( i8* %_968) 

	store i8* %_977,i8** %_967

	%_978 = getelementptr i8, i8* %this, i32 8
	%_979 = bitcast i8* %_978 to i8** 
	%_980 = load i8*, i8** %_979
	%_984 = bitcast i8* %_980 to i8*** 
	%_985 = load i8**, i8*** %_984 
	%_986 = getelementptr i8*, i8** %_985, i32 20 
	%_987 = load i8*, i8** %_986 
	%_988 = bitcast i8* %_987 to i32 (i8* , i8*)* 
	%_989 = call i32 %_988( i8* %_980, i8* %this) 

	store i32 %_989,i32* %nti

	br label %if_end_40
	if_end_40: 

	ret i32 0
}
 
define i32 @MyVisitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32
	%_990 = load i8*, i8** %n
	%_994 = bitcast i8* %_990 to i8*** 
	%_995 = load i8**, i8*** %_994 
	%_996 = getelementptr i8*, i8** %_995, i32 7 
	%_997 = load i8*, i8** %_996 
	%_998 = bitcast i8* %_997 to i1 (i8* )* 
	%_999 = call i1 %_998( i8* %_990) 

	br i1 %_999, label %if_then_41, label %if_else_41 
	if_else_41: 
	store i32 0,i32* %nti

	br label %if_end_41
	if_then_41: 
	%_1000 = getelementptr i8, i8* %this, i32 16
	%_1001 = bitcast i8* %_1000 to i8** 
	%_1002 = load i8*, i8** %n
	%_1006 = bitcast i8* %_1002 to i8*** 
	%_1007 = load i8**, i8*** %_1006 
	%_1008 = getelementptr i8*, i8** %_1007, i32 3 
	%_1009 = load i8*, i8** %_1008 
	%_1010 = bitcast i8* %_1009 to i8* (i8* )* 
	%_1011 = call i8* %_1010( i8* %_1002) 

	store i8* %_1011,i8** %_1001

	%_1012 = getelementptr i8, i8* %this, i32 16
	%_1013 = bitcast i8* %_1012 to i8** 
	%_1014 = load i8*, i8** %_1013
	%_1018 = bitcast i8* %_1014 to i8*** 
	%_1019 = load i8**, i8*** %_1018 
	%_1020 = getelementptr i8*, i8** %_1019, i32 20 
	%_1021 = load i8*, i8** %_1020 
	%_1022 = bitcast i8* %_1021 to i32 (i8* , i8*)* 
	%_1023 = call i32 %_1022( i8* %_1014, i8* %this) 

	store i32 %_1023,i32* %nti

	br label %if_end_41
	if_end_41: 

	%_1024 = load i8*, i8** %n
	%_1028 = bitcast i8* %_1024 to i8*** 
	%_1029 = load i8**, i8*** %_1028 
	%_1030 = getelementptr i8*, i8** %_1029, i32 5 
	%_1031 = load i8*, i8** %_1030 
	%_1032 = bitcast i8* %_1031 to i32 (i8* )* 
	%_1033 = call i32 %_1032( i8* %_1024) 

	call void (i32) @print_int(i32 %_1033)

	%_1034 = load i8*, i8** %n
	%_1038 = bitcast i8* %_1034 to i8*** 
	%_1039 = load i8**, i8*** %_1038 
	%_1040 = getelementptr i8*, i8** %_1039, i32 8 
	%_1041 = load i8*, i8** %_1040 
	%_1042 = bitcast i8* %_1041 to i1 (i8* )* 
	%_1043 = call i1 %_1042( i8* %_1034) 

	br i1 %_1043, label %if_then_42, label %if_else_42 
	if_else_42: 
	store i32 0,i32* %nti

	br label %if_end_42
	if_then_42: 
	%_1044 = getelementptr i8, i8* %this, i32 8
	%_1045 = bitcast i8* %_1044 to i8** 
	%_1046 = load i8*, i8** %n
	%_1050 = bitcast i8* %_1046 to i8*** 
	%_1051 = load i8**, i8*** %_1050 
	%_1052 = getelementptr i8*, i8** %_1051, i32 4 
	%_1053 = load i8*, i8** %_1052 
	%_1054 = bitcast i8* %_1053 to i8* (i8* )* 
	%_1055 = call i8* %_1054( i8* %_1046) 

	store i8* %_1055,i8** %_1045

	%_1056 = getelementptr i8, i8* %this, i32 8
	%_1057 = bitcast i8* %_1056 to i8** 
	%_1058 = load i8*, i8** %_1057
	%_1062 = bitcast i8* %_1058 to i8*** 
	%_1063 = load i8**, i8*** %_1062 
	%_1064 = getelementptr i8*, i8** %_1063, i32 20 
	%_1065 = load i8*, i8** %_1064 
	%_1066 = bitcast i8* %_1065 to i32 (i8* , i8*)* 
	%_1067 = call i32 %_1066( i8* %_1058, i8* %this) 

	store i32 %_1067,i32* %nti

	br label %if_end_42
	if_end_42: 

	ret i32 0
}
 
