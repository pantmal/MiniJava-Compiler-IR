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
	%_14 = load i32, i32* %v_Age
	store i32 %_14,i32* %_13

	%_15 = getelementptr i8, i8* %this, i32 12
	%_16 = bitcast i8* %_15 to i32* 
	%_17 = load i32, i32* %v_Salary
	store i32 %_17,i32* %_16

	%_18 = getelementptr i8, i8* %this, i32 16
	%_19 = bitcast i8* %_18 to i1* 
	%_20 = load i1, i1* %v_Married
	store i1 %_20,i1* %_19

	ret i1 1
}
 
define i32 @Element.GetAge(i8* %this) {
	%_21 = getelementptr i8, i8* %this, i32 8
	%_22 = bitcast i8* %_21 to i32* 
	%_23 = load i32, i32* %_22
	ret i32 %_23
}
 
define i32 @Element.GetSalary(i8* %this) {
	%_24 = getelementptr i8, i8* %this, i32 12
	%_25 = bitcast i8* %_24 to i32* 
	%_26 = load i32, i32* %_25
	ret i32 %_26
}
 
define i1 @Element.GetMarried(i8* %this) {
	%_27 = getelementptr i8, i8* %this, i32 16
	%_28 = bitcast i8* %_27 to i1* 
	%_29 = load i1, i1* %_28
	ret i1 %_29
}
 
define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
	store i1 1,i1* %ret_val

	%_30 = load i8*, i8** %other
	%_34 = bitcast i8* %_30 to i8*** 
	%_35 = load i8**, i8*** %_34 
	%_36 = getelementptr i8*, i8** %_35, i32 1 
	%_37 = load i8*, i8** %_36 
	%_38 = bitcast i8* %_37 to i32 (i8* )* 
	%_39 = call i32 %_38( i8* %_30) 

	store i32 %_39,i32* %aux01

	%_43 = bitcast i8* %this to i8*** 
	%_44 = load i8**, i8*** %_43 
	%_45 = getelementptr i8*, i8** %_44, i32 5 
	%_46 = load i8*, i8** %_45 
	%_47 = bitcast i8* %_46 to i1 (i8* , i32, i32)* 
	%_48 = load i32, i32* %aux01
	%_49 = getelementptr i8, i8* %this, i32 8
	%_50 = bitcast i8* %_49 to i32* 
	%_51 = load i32, i32* %_50
	%_52 = call i1 %_47( i8* %this, i32 %_48, i32 %_51) 

	%_53 = xor i1 1, %_52

	br i1 %_53, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_54 = load i8*, i8** %other
	%_58 = bitcast i8* %_54 to i8*** 
	%_59 = load i8**, i8*** %_58 
	%_60 = getelementptr i8*, i8** %_59, i32 2 
	%_61 = load i8*, i8** %_60 
	%_62 = bitcast i8* %_61 to i32 (i8* )* 
	%_63 = call i32 %_62( i8* %_54) 

	store i32 %_63,i32* %aux02

	%_67 = bitcast i8* %this to i8*** 
	%_68 = load i8**, i8*** %_67 
	%_69 = getelementptr i8*, i8** %_68, i32 5 
	%_70 = load i8*, i8** %_69 
	%_71 = bitcast i8* %_70 to i1 (i8* , i32, i32)* 
	%_72 = load i32, i32* %aux02
	%_73 = getelementptr i8, i8* %this, i32 12
	%_74 = bitcast i8* %_73 to i32* 
	%_75 = load i32, i32* %_74
	%_76 = call i1 %_71( i8* %this, i32 %_72, i32 %_75) 

	%_77 = xor i1 1, %_76

	br i1 %_77, label %if_then_1, label %if_else_1 
	if_else_1: 
	%_78 = getelementptr i8, i8* %this, i32 16
	%_79 = bitcast i8* %_78 to i1* 
	%_80 = load i1, i1* %_79
	br i1 %_80, label %if_then_2, label %if_else_2 
	if_else_2: 
	%_81 = load i8*, i8** %other
	%_85 = bitcast i8* %_81 to i8*** 
	%_86 = load i8**, i8*** %_85 
	%_87 = getelementptr i8*, i8** %_86, i32 3 
	%_88 = load i8*, i8** %_87 
	%_89 = bitcast i8* %_88 to i1 (i8* )* 
	%_90 = call i1 %_89( i8* %_81) 

	br i1 %_90, label %if_then_3, label %if_else_3 
	if_else_3: 
	store i32 0,i32* %nt

	br label %if_end_3
	if_then_3: 
	store i1 0,i1* %ret_val

	br label %if_end_3
	if_end_3: 

	br label %if_end_2
	if_then_2: 
	%_91 = load i8*, i8** %other
	%_95 = bitcast i8* %_91 to i8*** 
	%_96 = load i8**, i8*** %_95 
	%_97 = getelementptr i8*, i8** %_96, i32 3 
	%_98 = load i8*, i8** %_97 
	%_99 = bitcast i8* %_98 to i1 (i8* )* 
	%_100 = call i1 %_99( i8* %_91) 

	%_101 = xor i1 1, %_100

	br i1 %_101, label %if_then_4, label %if_else_4 
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

	%_102 = load i1, i1* %ret_val
	ret i1 %_102
}
 
define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1
	%aux02 = alloca i32
	store i1 0,i1* %retval

	%_103 = load i32, i32* %num2
	%_104 = add i32 %_103, 1

	store i32 %_104,i32* %aux02

	%_105 = load i32, i32* %num1
	%_106 = load i32, i32* %num2
	%_107 = icmp slt i32 %_105, %_106

	br i1 %_107, label %if_then_5, label %if_else_5 
	if_else_5: 
	%_108 = load i32, i32* %num1
	%_109 = load i32, i32* %aux02
	%_110 = icmp slt i32 %_108, %_109

	%_111 = xor i1 1, %_110

	br i1 %_111, label %if_then_6, label %if_else_6 
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

	%_112 = load i1, i1* %retval
	ret i1 %_112
}
 
define i1 @List.Init(i8* %this) {
	%_113 = getelementptr i8, i8* %this, i32 24
	%_114 = bitcast i8* %_113 to i1* 
	store i1 1,i1* %_114

	ret i1 1
}
 
define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end
	%_115 = getelementptr i8, i8* %this, i32 24
	%_116 = bitcast i8* %_115 to i1* 
	%_117 = load i1, i1* %v_end
	store i1 %_117,i1* %_116

	%_118 = getelementptr i8, i8* %this, i32 8
	%_119 = bitcast i8* %_118 to i8** 
	%_120 = load i8*, i8** %v_elem
	store i8* %_120,i8** %_119

	%_121 = getelementptr i8, i8* %this, i32 16
	%_122 = bitcast i8* %_121 to i8** 
	%_123 = load i8*, i8** %v_next
	store i8* %_123,i8** %_122

	ret i1 1
}
 
define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1
	%aux03 = alloca i8*
	%aux02 = alloca i8*
	store i8* %this,i8** %aux03

	%_124 = call i8* @calloc(i32 1, i32 25)
	%_125 = bitcast i8* %_124 to i8*** 
	%_126 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0 
	store i8** %_126, i8*** %_125

	store i8* %_124,i8** %aux02

	%_127 = load i8*, i8** %aux02
	%_131 = bitcast i8* %_127 to i8*** 
	%_132 = load i8**, i8*** %_131 
	%_133 = getelementptr i8*, i8** %_132, i32 1 
	%_134 = load i8*, i8** %_133 
	%_135 = bitcast i8* %_134 to i1 (i8* , i8*, i8*, i1)* 
	%_136 = load i8*, i8** %new_elem
	%_137 = load i8*, i8** %aux03
	%_138 = call i1 %_135( i8* %_127, i8* %_136, i8* %_137, i1 0) 

	store i1 %_138,i1* %ret_val

	%_139 = load i8*, i8** %aux02
	ret i8* %_139
}
 
define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%_140 = getelementptr i8, i8* %this, i32 16
	%_141 = bitcast i8* %_140 to i8** 
	%_142 = load i8*, i8** %v_next
	store i8* %_142,i8** %_141

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

	%_143 = sub i32 0, 1

	store i32 %_143,i32* %aux04

	store i8* %this,i8** %aux01

	store i8* %this,i8** %prev

	%_144 = getelementptr i8, i8* %this, i32 24
	%_145 = bitcast i8* %_144 to i1* 
	%_146 = load i1, i1* %_145
	store i1 %_146,i1* %var_end

	%_147 = getelementptr i8, i8* %this, i32 8
	%_148 = bitcast i8* %_147 to i8** 
	%_149 = load i8*, i8** %_148
	store i8* %_149,i8** %var_elem

	br label %loop7
	loop7: 
	%_150 = load i1, i1* %var_end
	%_151 = xor i1 1, %_150

	br i1 %_151, label %and_clause11, label %and_clause10 
	and_clause10: 
	br label %and_clause12
	and_clause11: 
	%_152 = load i1, i1* %ret_val
	%_153 = xor i1 1, %_152

	br label %and_clause12
	and_clause12: 
	br label %and_clause13
	and_clause13: 
	%_154 = phi i1 [ 0, %and_clause10 ], [ %_153, %and_clause12] 

	br i1 %_154, label %loop8, label %loop9 
	loop8: 
	%_155 = load i8*, i8** %e
	%_159 = bitcast i8* %_155 to i8*** 
	%_160 = load i8**, i8*** %_159 
	%_161 = getelementptr i8*, i8** %_160, i32 4 
	%_162 = load i8*, i8** %_161 
	%_163 = bitcast i8* %_162 to i1 (i8* , i8*)* 
	%_164 = load i8*, i8** %var_elem
	%_165 = call i1 %_163( i8* %_155, i8* %_164) 

	br i1 %_165, label %if_then_14, label %if_else_14 
	if_else_14: 
	store i32 0,i32* %nt

	br label %if_end_14
	if_then_14: 
	store i1 1,i1* %ret_val

	%_166 = load i32, i32* %aux04
	%_167 = icmp slt i32 %_166, 0

	br i1 %_167, label %if_then_15, label %if_else_15 
	if_else_15: 
	%_168 = sub i32 0, 555

	call void (i32) @print_int(i32 %_168)

	%_169 = load i8*, i8** %prev
	%_173 = bitcast i8* %_169 to i8*** 
	%_174 = load i8**, i8*** %_173 
	%_175 = getelementptr i8*, i8** %_174, i32 3 
	%_176 = load i8*, i8** %_175 
	%_177 = bitcast i8* %_176 to i1 (i8* , i8*)* 
	%_178 = load i8*, i8** %aux01
	%_182 = bitcast i8* %_178 to i8*** 
	%_183 = load i8**, i8*** %_182 
	%_184 = getelementptr i8*, i8** %_183, i32 8 
	%_185 = load i8*, i8** %_184 
	%_186 = bitcast i8* %_185 to i8* (i8* )* 
	%_187 = call i8* %_186( i8* %_178) 

	%_188 = call i1 %_177( i8* %_169, i8* %_187) 

	store i1 %_188,i1* %aux05

	%_189 = sub i32 0, 555

	call void (i32) @print_int(i32 %_189)

	br label %if_end_15
	if_then_15: 
	%_190 = load i8*, i8** %aux01
	%_194 = bitcast i8* %_190 to i8*** 
	%_195 = load i8**, i8*** %_194 
	%_196 = getelementptr i8*, i8** %_195, i32 8 
	%_197 = load i8*, i8** %_196 
	%_198 = bitcast i8* %_197 to i8* (i8* )* 
	%_199 = call i8* %_198( i8* %_190) 

	store i8* %_199,i8** %my_head

	br label %if_end_15
	if_end_15: 

	br label %if_end_14
	if_end_14: 

	%_200 = load i1, i1* %ret_val
	%_201 = xor i1 1, %_200

	br i1 %_201, label %if_then_16, label %if_else_16 
	if_else_16: 
	store i32 0,i32* %nt

	br label %if_end_16
	if_then_16: 
	%_202 = load i8*, i8** %aux01
	store i8* %_202,i8** %prev

	%_203 = load i8*, i8** %aux01
	%_207 = bitcast i8* %_203 to i8*** 
	%_208 = load i8**, i8*** %_207 
	%_209 = getelementptr i8*, i8** %_208, i32 8 
	%_210 = load i8*, i8** %_209 
	%_211 = bitcast i8* %_210 to i8* (i8* )* 
	%_212 = call i8* %_211( i8* %_203) 

	store i8* %_212,i8** %aux01

	%_213 = load i8*, i8** %aux01
	%_217 = bitcast i8* %_213 to i8*** 
	%_218 = load i8**, i8*** %_217 
	%_219 = getelementptr i8*, i8** %_218, i32 6 
	%_220 = load i8*, i8** %_219 
	%_221 = bitcast i8* %_220 to i1 (i8* )* 
	%_222 = call i1 %_221( i8* %_213) 

	store i1 %_222,i1* %var_end

	%_223 = load i8*, i8** %aux01
	%_227 = bitcast i8* %_223 to i8*** 
	%_228 = load i8**, i8*** %_227 
	%_229 = getelementptr i8*, i8** %_228, i32 7 
	%_230 = load i8*, i8** %_229 
	%_231 = bitcast i8* %_230 to i8* (i8* )* 
	%_232 = call i8* %_231( i8* %_223) 

	store i8* %_232,i8** %var_elem

	store i32 1,i32* %aux04

	br label %if_end_16
	if_end_16: 

	br label %loop7
	loop9: 

	%_233 = load i8*, i8** %my_head
	ret i8* %_233
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

	%_234 = getelementptr i8, i8* %this, i32 24
	%_235 = bitcast i8* %_234 to i1* 
	%_236 = load i1, i1* %_235
	store i1 %_236,i1* %var_end

	%_237 = getelementptr i8, i8* %this, i32 8
	%_238 = bitcast i8* %_237 to i8** 
	%_239 = load i8*, i8** %_238
	store i8* %_239,i8** %var_elem

	br label %loop17
	loop17: 
	%_240 = load i1, i1* %var_end
	%_241 = xor i1 1, %_240

	br i1 %_241, label %loop18, label %loop19 
	loop18: 
	%_242 = load i8*, i8** %e
	%_246 = bitcast i8* %_242 to i8*** 
	%_247 = load i8**, i8*** %_246 
	%_248 = getelementptr i8*, i8** %_247, i32 4 
	%_249 = load i8*, i8** %_248 
	%_250 = bitcast i8* %_249 to i1 (i8* , i8*)* 
	%_251 = load i8*, i8** %var_elem
	%_252 = call i1 %_250( i8* %_242, i8* %_251) 

	br i1 %_252, label %if_then_20, label %if_else_20 
	if_else_20: 
	store i32 0,i32* %nt

	br label %if_end_20
	if_then_20: 
	store i32 1,i32* %int_ret_val

	br label %if_end_20
	if_end_20: 

	%_253 = load i8*, i8** %aux01
	%_257 = bitcast i8* %_253 to i8*** 
	%_258 = load i8**, i8*** %_257 
	%_259 = getelementptr i8*, i8** %_258, i32 8 
	%_260 = load i8*, i8** %_259 
	%_261 = bitcast i8* %_260 to i8* (i8* )* 
	%_262 = call i8* %_261( i8* %_253) 

	store i8* %_262,i8** %aux01

	%_263 = load i8*, i8** %aux01
	%_267 = bitcast i8* %_263 to i8*** 
	%_268 = load i8**, i8*** %_267 
	%_269 = getelementptr i8*, i8** %_268, i32 6 
	%_270 = load i8*, i8** %_269 
	%_271 = bitcast i8* %_270 to i1 (i8* )* 
	%_272 = call i1 %_271( i8* %_263) 

	store i1 %_272,i1* %var_end

	%_273 = load i8*, i8** %aux01
	%_277 = bitcast i8* %_273 to i8*** 
	%_278 = load i8**, i8*** %_277 
	%_279 = getelementptr i8*, i8** %_278, i32 7 
	%_280 = load i8*, i8** %_279 
	%_281 = bitcast i8* %_280 to i8* (i8* )* 
	%_282 = call i8* %_281( i8* %_273) 

	store i8* %_282,i8** %var_elem

	br label %loop17
	loop19: 

	%_283 = load i32, i32* %int_ret_val
	ret i32 %_283
}
 
define i1 @List.GetEnd(i8* %this) {
	%_284 = getelementptr i8, i8* %this, i32 24
	%_285 = bitcast i8* %_284 to i1* 
	%_286 = load i1, i1* %_285
	ret i1 %_286
}
 
define i8* @List.GetElem(i8* %this) {
	%_287 = getelementptr i8, i8* %this, i32 8
	%_288 = bitcast i8* %_287 to i8** 
	%_289 = load i8*, i8** %_288
	ret i8* %_289
}
 
define i8* @List.GetNext(i8* %this) {
	%_290 = getelementptr i8, i8* %this, i32 16
	%_291 = bitcast i8* %_290 to i8** 
	%_292 = load i8*, i8** %_291
	ret i8* %_292
}
 
define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*
	store i8* %this,i8** %aux01

	%_293 = getelementptr i8, i8* %this, i32 24
	%_294 = bitcast i8* %_293 to i1* 
	%_295 = load i1, i1* %_294
	store i1 %_295,i1* %var_end

	%_296 = getelementptr i8, i8* %this, i32 8
	%_297 = bitcast i8* %_296 to i8** 
	%_298 = load i8*, i8** %_297
	store i8* %_298,i8** %var_elem

	br label %loop21
	loop21: 
	%_299 = load i1, i1* %var_end
	%_300 = xor i1 1, %_299

	br i1 %_300, label %loop22, label %loop23 
	loop22: 
	%_301 = load i8*, i8** %var_elem
	%_305 = bitcast i8* %_301 to i8*** 
	%_306 = load i8**, i8*** %_305 
	%_307 = getelementptr i8*, i8** %_306, i32 1 
	%_308 = load i8*, i8** %_307 
	%_309 = bitcast i8* %_308 to i32 (i8* )* 
	%_310 = call i32 %_309( i8* %_301) 

	call void (i32) @print_int(i32 %_310)

	%_311 = load i8*, i8** %aux01
	%_315 = bitcast i8* %_311 to i8*** 
	%_316 = load i8**, i8*** %_315 
	%_317 = getelementptr i8*, i8** %_316, i32 8 
	%_318 = load i8*, i8** %_317 
	%_319 = bitcast i8* %_318 to i8* (i8* )* 
	%_320 = call i8* %_319( i8* %_311) 

	store i8* %_320,i8** %aux01

	%_321 = load i8*, i8** %aux01
	%_325 = bitcast i8* %_321 to i8*** 
	%_326 = load i8**, i8*** %_325 
	%_327 = getelementptr i8*, i8** %_326, i32 6 
	%_328 = load i8*, i8** %_327 
	%_329 = bitcast i8* %_328 to i1 (i8* )* 
	%_330 = call i1 %_329( i8* %_321) 

	store i1 %_330,i1* %var_end

	%_331 = load i8*, i8** %aux01
	%_335 = bitcast i8* %_331 to i8*** 
	%_336 = load i8**, i8*** %_335 
	%_337 = getelementptr i8*, i8** %_336, i32 7 
	%_338 = load i8*, i8** %_337 
	%_339 = bitcast i8* %_338 to i8* (i8* )* 
	%_340 = call i8* %_339( i8* %_331) 

	store i8* %_340,i8** %var_elem

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
	%_341 = call i8* @calloc(i32 1, i32 25)
	%_342 = bitcast i8* %_341 to i8*** 
	%_343 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0 
	store i8** %_343, i8*** %_342

	store i8* %_341,i8** %last_elem

	%_344 = load i8*, i8** %last_elem
	%_348 = bitcast i8* %_344 to i8*** 
	%_349 = load i8**, i8*** %_348 
	%_350 = getelementptr i8*, i8** %_349, i32 0 
	%_351 = load i8*, i8** %_350 
	%_352 = bitcast i8* %_351 to i1 (i8* )* 
	%_353 = call i1 %_352( i8* %_344) 

	store i1 %_353,i1* %aux01

	%_354 = load i8*, i8** %last_elem
	store i8* %_354,i8** %head

	%_355 = load i8*, i8** %head
	%_359 = bitcast i8* %_355 to i8*** 
	%_360 = load i8**, i8*** %_359 
	%_361 = getelementptr i8*, i8** %_360, i32 0 
	%_362 = load i8*, i8** %_361 
	%_363 = bitcast i8* %_362 to i1 (i8* )* 
	%_364 = call i1 %_363( i8* %_355) 

	store i1 %_364,i1* %aux01

	%_365 = load i8*, i8** %head
	%_369 = bitcast i8* %_365 to i8*** 
	%_370 = load i8**, i8*** %_369 
	%_371 = getelementptr i8*, i8** %_370, i32 9 
	%_372 = load i8*, i8** %_371 
	%_373 = bitcast i8* %_372 to i1 (i8* )* 
	%_374 = call i1 %_373( i8* %_365) 

	store i1 %_374,i1* %aux01

	%_375 = call i8* @calloc(i32 1, i32 17)
	%_376 = bitcast i8* %_375 to i8*** 
	%_377 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_377, i8*** %_376

	store i8* %_375,i8** %el01

	%_378 = load i8*, i8** %el01
	%_382 = bitcast i8* %_378 to i8*** 
	%_383 = load i8**, i8*** %_382 
	%_384 = getelementptr i8*, i8** %_383, i32 0 
	%_385 = load i8*, i8** %_384 
	%_386 = bitcast i8* %_385 to i1 (i8* , i32, i32, i1)* 
	%_387 = call i1 %_386( i8* %_378, i32 25, i32 37000, i1 0) 

	store i1 %_387,i1* %aux01

	%_388 = load i8*, i8** %head
	%_392 = bitcast i8* %_388 to i8*** 
	%_393 = load i8**, i8*** %_392 
	%_394 = getelementptr i8*, i8** %_393, i32 2 
	%_395 = load i8*, i8** %_394 
	%_396 = bitcast i8* %_395 to i8* (i8* , i8*)* 
	%_397 = load i8*, i8** %el01
	%_398 = call i8* %_396( i8* %_388, i8* %_397) 

	store i8* %_398,i8** %head

	%_399 = load i8*, i8** %head
	%_403 = bitcast i8* %_399 to i8*** 
	%_404 = load i8**, i8*** %_403 
	%_405 = getelementptr i8*, i8** %_404, i32 9 
	%_406 = load i8*, i8** %_405 
	%_407 = bitcast i8* %_406 to i1 (i8* )* 
	%_408 = call i1 %_407( i8* %_399) 

	store i1 %_408,i1* %aux01

	call void (i32) @print_int(i32 10000000)

	%_409 = call i8* @calloc(i32 1, i32 17)
	%_410 = bitcast i8* %_409 to i8*** 
	%_411 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_411, i8*** %_410

	store i8* %_409,i8** %el01

	%_412 = load i8*, i8** %el01
	%_416 = bitcast i8* %_412 to i8*** 
	%_417 = load i8**, i8*** %_416 
	%_418 = getelementptr i8*, i8** %_417, i32 0 
	%_419 = load i8*, i8** %_418 
	%_420 = bitcast i8* %_419 to i1 (i8* , i32, i32, i1)* 
	%_421 = call i1 %_420( i8* %_412, i32 39, i32 42000, i1 1) 

	store i1 %_421,i1* %aux01

	%_422 = load i8*, i8** %el01
	store i8* %_422,i8** %el02

	%_423 = load i8*, i8** %head
	%_427 = bitcast i8* %_423 to i8*** 
	%_428 = load i8**, i8*** %_427 
	%_429 = getelementptr i8*, i8** %_428, i32 2 
	%_430 = load i8*, i8** %_429 
	%_431 = bitcast i8* %_430 to i8* (i8* , i8*)* 
	%_432 = load i8*, i8** %el01
	%_433 = call i8* %_431( i8* %_423, i8* %_432) 

	store i8* %_433,i8** %head

	%_434 = load i8*, i8** %head
	%_438 = bitcast i8* %_434 to i8*** 
	%_439 = load i8**, i8*** %_438 
	%_440 = getelementptr i8*, i8** %_439, i32 9 
	%_441 = load i8*, i8** %_440 
	%_442 = bitcast i8* %_441 to i1 (i8* )* 
	%_443 = call i1 %_442( i8* %_434) 

	store i1 %_443,i1* %aux01

	call void (i32) @print_int(i32 10000000)

	%_444 = call i8* @calloc(i32 1, i32 17)
	%_445 = bitcast i8* %_444 to i8*** 
	%_446 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_446, i8*** %_445

	store i8* %_444,i8** %el01

	%_447 = load i8*, i8** %el01
	%_451 = bitcast i8* %_447 to i8*** 
	%_452 = load i8**, i8*** %_451 
	%_453 = getelementptr i8*, i8** %_452, i32 0 
	%_454 = load i8*, i8** %_453 
	%_455 = bitcast i8* %_454 to i1 (i8* , i32, i32, i1)* 
	%_456 = call i1 %_455( i8* %_447, i32 22, i32 34000, i1 0) 

	store i1 %_456,i1* %aux01

	%_457 = load i8*, i8** %head
	%_461 = bitcast i8* %_457 to i8*** 
	%_462 = load i8**, i8*** %_461 
	%_463 = getelementptr i8*, i8** %_462, i32 2 
	%_464 = load i8*, i8** %_463 
	%_465 = bitcast i8* %_464 to i8* (i8* , i8*)* 
	%_466 = load i8*, i8** %el01
	%_467 = call i8* %_465( i8* %_457, i8* %_466) 

	store i8* %_467,i8** %head

	%_468 = load i8*, i8** %head
	%_472 = bitcast i8* %_468 to i8*** 
	%_473 = load i8**, i8*** %_472 
	%_474 = getelementptr i8*, i8** %_473, i32 9 
	%_475 = load i8*, i8** %_474 
	%_476 = bitcast i8* %_475 to i1 (i8* )* 
	%_477 = call i1 %_476( i8* %_468) 

	store i1 %_477,i1* %aux01

	%_478 = call i8* @calloc(i32 1, i32 17)
	%_479 = bitcast i8* %_478 to i8*** 
	%_480 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_480, i8*** %_479

	store i8* %_478,i8** %el03

	%_481 = load i8*, i8** %el03
	%_485 = bitcast i8* %_481 to i8*** 
	%_486 = load i8**, i8*** %_485 
	%_487 = getelementptr i8*, i8** %_486, i32 0 
	%_488 = load i8*, i8** %_487 
	%_489 = bitcast i8* %_488 to i1 (i8* , i32, i32, i1)* 
	%_490 = call i1 %_489( i8* %_481, i32 27, i32 34000, i1 0) 

	store i1 %_490,i1* %aux01

	%_491 = load i8*, i8** %head
	%_495 = bitcast i8* %_491 to i8*** 
	%_496 = load i8**, i8*** %_495 
	%_497 = getelementptr i8*, i8** %_496, i32 5 
	%_498 = load i8*, i8** %_497 
	%_499 = bitcast i8* %_498 to i32 (i8* , i8*)* 
	%_500 = load i8*, i8** %el02
	%_501 = call i32 %_499( i8* %_491, i8* %_500) 

	call void (i32) @print_int(i32 %_501)

	%_502 = load i8*, i8** %head
	%_506 = bitcast i8* %_502 to i8*** 
	%_507 = load i8**, i8*** %_506 
	%_508 = getelementptr i8*, i8** %_507, i32 5 
	%_509 = load i8*, i8** %_508 
	%_510 = bitcast i8* %_509 to i32 (i8* , i8*)* 
	%_511 = load i8*, i8** %el03
	%_512 = call i32 %_510( i8* %_502, i8* %_511) 

	call void (i32) @print_int(i32 %_512)

	call void (i32) @print_int(i32 10000000)

	%_513 = call i8* @calloc(i32 1, i32 17)
	%_514 = bitcast i8* %_513 to i8*** 
	%_515 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
	store i8** %_515, i8*** %_514

	store i8* %_513,i8** %el01

	%_516 = load i8*, i8** %el01
	%_520 = bitcast i8* %_516 to i8*** 
	%_521 = load i8**, i8*** %_520 
	%_522 = getelementptr i8*, i8** %_521, i32 0 
	%_523 = load i8*, i8** %_522 
	%_524 = bitcast i8* %_523 to i1 (i8* , i32, i32, i1)* 
	%_525 = call i1 %_524( i8* %_516, i32 28, i32 35000, i1 0) 

	store i1 %_525,i1* %aux01

	%_526 = load i8*, i8** %head
	%_530 = bitcast i8* %_526 to i8*** 
	%_531 = load i8**, i8*** %_530 
	%_532 = getelementptr i8*, i8** %_531, i32 2 
	%_533 = load i8*, i8** %_532 
	%_534 = bitcast i8* %_533 to i8* (i8* , i8*)* 
	%_535 = load i8*, i8** %el01
	%_536 = call i8* %_534( i8* %_526, i8* %_535) 

	store i8* %_536,i8** %head

	%_537 = load i8*, i8** %head
	%_541 = bitcast i8* %_537 to i8*** 
	%_542 = load i8**, i8*** %_541 
	%_543 = getelementptr i8*, i8** %_542, i32 9 
	%_544 = load i8*, i8** %_543 
	%_545 = bitcast i8* %_544 to i1 (i8* )* 
	%_546 = call i1 %_545( i8* %_537) 

	store i1 %_546,i1* %aux01

	call void (i32) @print_int(i32 2220000)

	%_547 = load i8*, i8** %head
	%_551 = bitcast i8* %_547 to i8*** 
	%_552 = load i8**, i8*** %_551 
	%_553 = getelementptr i8*, i8** %_552, i32 4 
	%_554 = load i8*, i8** %_553 
	%_555 = bitcast i8* %_554 to i8* (i8* , i8*)* 
	%_556 = load i8*, i8** %el02
	%_557 = call i8* %_555( i8* %_547, i8* %_556) 

	store i8* %_557,i8** %head

	%_558 = load i8*, i8** %head
	%_562 = bitcast i8* %_558 to i8*** 
	%_563 = load i8**, i8*** %_562 
	%_564 = getelementptr i8*, i8** %_563, i32 9 
	%_565 = load i8*, i8** %_564 
	%_566 = bitcast i8* %_565 to i1 (i8* )* 
	%_567 = call i1 %_566( i8* %_558) 

	store i1 %_567,i1* %aux01

	call void (i32) @print_int(i32 33300000)

	%_568 = load i8*, i8** %head
	%_572 = bitcast i8* %_568 to i8*** 
	%_573 = load i8**, i8*** %_572 
	%_574 = getelementptr i8*, i8** %_573, i32 4 
	%_575 = load i8*, i8** %_574 
	%_576 = bitcast i8* %_575 to i8* (i8* , i8*)* 
	%_577 = load i8*, i8** %el01
	%_578 = call i8* %_576( i8* %_568, i8* %_577) 

	store i8* %_578,i8** %head

	%_579 = load i8*, i8** %head
	%_583 = bitcast i8* %_579 to i8*** 
	%_584 = load i8**, i8*** %_583 
	%_585 = getelementptr i8*, i8** %_584, i32 9 
	%_586 = load i8*, i8** %_585 
	%_587 = bitcast i8* %_586 to i1 (i8* )* 
	%_588 = call i1 %_587( i8* %_579) 

	store i1 %_588,i1* %aux01

	call void (i32) @print_int(i32 44440000)

	ret i32 0
}
 
