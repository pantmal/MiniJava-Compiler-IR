@.test20_vtable = global [0 x i8*] [] 
 
@.A23_vtable = global [ 3 x i8*] [  
	i8* bitcast (i32 (i8*,i8*)* @A23.init to i8*),
	i8* bitcast (i32 (i8*)* @A23.getI1 to i8*),
	i8* bitcast (i32 (i8*,i32)* @A23.setI1 to i8*)
]
 
@.B23_vtable = global [ 3 x i8*] [  
	i8* bitcast (i32 (i8*,i8*)* @B23.init to i8*),
	i8* bitcast (i32 (i8*)* @B23.getI1 to i8*),
	i8* bitcast (i32 (i8*,i32)* @B23.setI1 to i8*)
]
 
@.C23_vtable = global [ 3 x i8*] [  
	i8* bitcast (i32 (i8*,i8*)* @C23.init to i8*),
	i8* bitcast (i32 (i8*)* @C23.getI1 to i8*),
	i8* bitcast (i32 (i8*,i32)* @C23.setI1 to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 36)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.C23_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	%_6 = bitcast i8* %_0 to i8*** 
	%_7 = load i8**, i8*** %_6 
	%_8 = getelementptr i8*, i8** %_7, i32 0 
	%_9 = load i8*, i8** %_8 
	%_10 = bitcast i8* %_9 to i32 (i8* , i8*)* 
	%_11 = call i8* @calloc(i32 1, i32 28)
	%_12 = bitcast i8* %_11 to i8*** 
	%_13 = getelementptr [3 x i8*], [3 x i8*]* @.B23_vtable, i32 0, i32 0 
	store i8** %_13, i8*** %_12

	%_14 = call i32 %_10( i8* %_0, i8* %_11) 

	call void (i32) @print_int(i32 %_14)

	ret i32 0
}
 
define i32 @A23.init(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a
	%_15 = getelementptr i8, i8* %this, i32 12
	%_16 = bitcast i8* %_15 to i32* 
	%_17 = load i8*, i8** %a
	%_21 = bitcast i8* %_17 to i8*** 
	%_22 = load i8**, i8*** %_21 
	%_23 = getelementptr i8*, i8** %_22, i32 1 
	%_24 = load i8*, i8** %_23 
	%_25 = bitcast i8* %_24 to i32 (i8* )* 
	%_26 = call i32 %_25( i8* %_17) 

	store i32 %_26,i32* %_16

	%_27 = getelementptr i8, i8* %this, i32 16
	%_28 = bitcast i8* %_27 to i32* 
	store i32 222,i32* %_28

	%_29 = getelementptr i8, i8* %this, i32 8
	%_30 = bitcast i8* %_29 to i32* 
	%_34 = bitcast i8* %this to i8*** 
	%_35 = load i8**, i8*** %_34 
	%_36 = getelementptr i8*, i8** %_35, i32 2 
	%_37 = load i8*, i8** %_36 
	%_38 = bitcast i8* %_37 to i32 (i8* , i32)* 
	%_39 = getelementptr i8, i8* %this, i32 12
	%_40 = bitcast i8* %_39 to i32* 
	%_41 = load i32, i32* %_40
	%_42 = getelementptr i8, i8* %this, i32 16
	%_43 = bitcast i8* %_42 to i32* 
	%_44 = load i32, i32* %_43
	%_45 = add i32 %_41, %_44

	%_46 = call i32 %_38( i8* %this, i32 %_45) 

	store i32 %_46,i32* %_30

	%_47 = getelementptr i8, i8* %this, i32 8
	%_48 = bitcast i8* %_47 to i32* 
	%_49 = load i32, i32* %_48
	ret i32 %_49
}
 
define i32 @A23.getI1(i8* %this) {
	%_50 = getelementptr i8, i8* %this, i32 8
	%_51 = bitcast i8* %_50 to i32* 
	%_52 = load i32, i32* %_51
	ret i32 %_52
}
 
define i32 @A23.setI1(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%_53 = load i32, i32* %i
	ret i32 %_53
}
 
define i32 @B23.init(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a
	%a_local = alloca i8*
	%_54 = call i8* @calloc(i32 1, i32 20)
	%_55 = bitcast i8* %_54 to i8*** 
	%_56 = getelementptr [3 x i8*], [3 x i8*]* @.A23_vtable, i32 0, i32 0 
	store i8** %_56, i8*** %_55

	store i8* %_54,i8** %a_local

	%_57 = getelementptr i8, i8* %this, i32 24
	%_58 = bitcast i8* %_57 to i32* 
	%_59 = load i8*, i8** %a
	%_63 = bitcast i8* %_59 to i8*** 
	%_64 = load i8**, i8*** %_63 
	%_65 = getelementptr i8*, i8** %_64, i32 1 
	%_66 = load i8*, i8** %_65 
	%_67 = bitcast i8* %_66 to i32 (i8* )* 
	%_68 = call i32 %_67( i8* %_59) 

	store i32 %_68,i32* %_58

	%_69 = getelementptr i8, i8* %this, i32 20
	%_70 = bitcast i8* %_69 to i32* 
	%_74 = bitcast i8* %this to i8*** 
	%_75 = load i8**, i8*** %_74 
	%_76 = getelementptr i8*, i8** %_75, i32 2 
	%_77 = load i8*, i8** %_76 
	%_78 = bitcast i8* %_77 to i32 (i8* , i32)* 
	%_79 = getelementptr i8, i8* %this, i32 24
	%_80 = bitcast i8* %_79 to i32* 
	%_81 = load i32, i32* %_80
	%_82 = call i32 %_78( i8* %this, i32 %_81) 

	store i32 %_82,i32* %_70

	%_83 = load i8*, i8** %a_local
	%_87 = bitcast i8* %_83 to i8*** 
	%_88 = load i8**, i8*** %_87 
	%_89 = getelementptr i8*, i8** %_88, i32 0 
	%_90 = load i8*, i8** %_89 
	%_91 = bitcast i8* %_90 to i32 (i8* , i8*)* 
	%_92 = call i32 %_91( i8* %_83, i8* %this) 

	ret i32 %_92
}
 
define i32 @B23.getI1(i8* %this) {
	%_93 = getelementptr i8, i8* %this, i32 20
	%_94 = bitcast i8* %_93 to i32* 
	%_95 = load i32, i32* %_94
	ret i32 %_95
}
 
define i32 @B23.setI1(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%_96 = load i32, i32* %i
	%_97 = add i32 %_96, 111

	ret i32 %_97
}
 
define i32 @C23.init(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a
	%_98 = getelementptr i8, i8* %this, i32 32
	%_99 = bitcast i8* %_98 to i32* 
	store i32 333,i32* %_99

	%_100 = getelementptr i8, i8* %this, i32 28
	%_101 = bitcast i8* %_100 to i32* 
	%_105 = bitcast i8* %this to i8*** 
	%_106 = load i8**, i8*** %_105 
	%_107 = getelementptr i8*, i8** %_106, i32 2 
	%_108 = load i8*, i8** %_107 
	%_109 = bitcast i8* %_108 to i32 (i8* , i32)* 
	%_110 = getelementptr i8, i8* %this, i32 32
	%_111 = bitcast i8* %_110 to i32* 
	%_112 = load i32, i32* %_111
	%_113 = call i32 %_109( i8* %this, i32 %_112) 

	store i32 %_113,i32* %_101

	%_114 = load i8*, i8** %a
	%_118 = bitcast i8* %_114 to i8*** 
	%_119 = load i8**, i8*** %_118 
	%_120 = getelementptr i8*, i8** %_119, i32 0 
	%_121 = load i8*, i8** %_120 
	%_122 = bitcast i8* %_121 to i32 (i8* , i8*)* 
	%_123 = call i32 %_122( i8* %_114, i8* %this) 

	ret i32 %_123
}
 
define i32 @C23.getI1(i8* %this) {
	%_124 = getelementptr i8, i8* %this, i32 28
	%_125 = bitcast i8* %_124 to i32* 
	%_126 = load i32, i32* %_125
	ret i32 %_126
}
 
define i32 @C23.setI1(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%_127 = load i32, i32* %i
	%_128 = mul i32 %_127, 2

	ret i32 %_128
}
 
