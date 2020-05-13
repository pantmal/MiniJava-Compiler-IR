@.test15_vtable = global [0 x i8*] [] 
 
@.Test_vtable = global [ 3 x i8*] [  
	i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i32 (i8*)* @Test.mutual1 to i8*),
	i8* bitcast (i32 (i8*)* @Test.mutual2 to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 16)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0 
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
 
define i32 @Test.start(i8* %this) {
	%_12 = getelementptr i8, i8* %this, i32 8
	%_13 = bitcast i8* %_12 to i32* 
	store i32 4,i32* %_13

	%_19 = getelementptr i8, i8* %this, i32 12
	%_20 = bitcast i8* %_19 to i32* 
	store i32 0,i32* %_20

	%_29 = bitcast i8* %this to i8*** 
	%_30 = load i8**, i8*** %_29 
	%_31 = getelementptr i8*, i8** %_30, i32 1 
	%_32 = load i8*, i8** %_31 
	%_33 = bitcast i8* %_32 to i32 (i8* )* 
	%_34 = call i32 %_33( i8* %this) 

	ret i32 %_34
}
 
define i32 @Test.mutual1(i8* %this) {
	%j = alloca i32

	%_35 = getelementptr i8, i8* %this, i32 8
	%_36 = bitcast i8* %_35 to i32* 
	%_42 = getelementptr i8, i8* %this, i32 8
	%_43 = bitcast i8* %_42 to i32* 
	%_44 = load i32, i32* %_43
	%_45 = sub i32 %_44, 1

	store i32 %_45,i32* %_36

	%_46 = getelementptr i8, i8* %this, i32 8
	%_47 = bitcast i8* %_46 to i32* 
	%_48 = load i32, i32* %_47
	%_49 = icmp slt i32 %_48, 0

	br i1 %_49, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_50 = getelementptr i8, i8* %this, i32 12
	%_51 = bitcast i8* %_50 to i32* 
	%_52 = load i32, i32* %_51
	call void (i32) @print_int(i32 %_52)

	%_53 = getelementptr i8, i8* %this, i32 12
	%_54 = bitcast i8* %_53 to i32* 
	store i32 1,i32* %_54

	%_68 = bitcast i8* %this to i8*** 
	%_69 = load i8**, i8*** %_68 
	%_70 = getelementptr i8*, i8** %_69, i32 2 
	%_71 = load i8*, i8** %_70 
	%_72 = bitcast i8* %_71 to i32 (i8* )* 
	%_73 = call i32 %_72( i8* %this) 

	store i32 %_73,i32* %j

	br label %if_end_0
	if_then_0: 
	%_74 = getelementptr i8, i8* %this, i32 12
	%_75 = bitcast i8* %_74 to i32* 
	store i32 0,i32* %_75

	br label %if_end_0
	if_end_0: 

	%_81 = getelementptr i8, i8* %this, i32 12
	%_82 = bitcast i8* %_81 to i32* 
	%_83 = load i32, i32* %_82
	ret i32 %_83
}
 
define i32 @Test.mutual2(i8* %this) {
	%j = alloca i32

	%_84 = getelementptr i8, i8* %this, i32 8
	%_85 = bitcast i8* %_84 to i32* 
	%_91 = getelementptr i8, i8* %this, i32 8
	%_92 = bitcast i8* %_91 to i32* 
	%_93 = load i32, i32* %_92
	%_94 = sub i32 %_93, 1

	store i32 %_94,i32* %_85

	%_95 = getelementptr i8, i8* %this, i32 8
	%_96 = bitcast i8* %_95 to i32* 
	%_97 = load i32, i32* %_96
	%_98 = icmp slt i32 %_97, 0

	br i1 %_98, label %if_then_1, label %if_else_1 
	if_else_1: 
	%_99 = getelementptr i8, i8* %this, i32 12
	%_100 = bitcast i8* %_99 to i32* 
	%_101 = load i32, i32* %_100
	call void (i32) @print_int(i32 %_101)

	%_102 = getelementptr i8, i8* %this, i32 12
	%_103 = bitcast i8* %_102 to i32* 
	store i32 0,i32* %_103

	%_117 = bitcast i8* %this to i8*** 
	%_118 = load i8**, i8*** %_117 
	%_119 = getelementptr i8*, i8** %_118, i32 1 
	%_120 = load i8*, i8** %_119 
	%_121 = bitcast i8* %_120 to i32 (i8* )* 
	%_122 = call i32 %_121( i8* %this) 

	store i32 %_122,i32* %j

	br label %if_end_1
	if_then_1: 
	%_123 = getelementptr i8, i8* %this, i32 12
	%_124 = bitcast i8* %_123 to i32* 
	store i32 0,i32* %_124

	br label %if_end_1
	if_end_1: 

	%_130 = getelementptr i8, i8* %this, i32 12
	%_131 = bitcast i8* %_130 to i32* 
	%_132 = load i32, i32* %_131
	ret i32 %_132
}
 
