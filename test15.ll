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

	%_14 = getelementptr i8, i8* %this, i32 12
	%_15 = bitcast i8* %_14 to i32* 
	store i32 0,i32* %_15

	%_19 = bitcast i8* %this to i8*** 
	%_20 = load i8**, i8*** %_19 
	%_21 = getelementptr i8*, i8** %_20, i32 1 
	%_22 = load i8*, i8** %_21 
	%_23 = bitcast i8* %_22 to i32 (i8* )* 
	%_24 = call i32 %_23( i8* %this) 

	ret i32 %_24
}
 
define i32 @Test.mutual1(i8* %this) {
	%j = alloca i32
	%_25 = getelementptr i8, i8* %this, i32 8
	%_26 = bitcast i8* %_25 to i32* 
	%_27 = getelementptr i8, i8* %this, i32 8
	%_28 = bitcast i8* %_27 to i32* 
	%_29 = load i32, i32* %_28
	%_30 = sub i32 %_29, 1

	store i32 %_30,i32* %_26

	%_31 = getelementptr i8, i8* %this, i32 8
	%_32 = bitcast i8* %_31 to i32* 
	%_33 = load i32, i32* %_32
	%_34 = icmp slt i32 %_33, 0

	br i1 %_34, label %if_then_0, label %if_else_0 
	if_else_0: 
	%_35 = getelementptr i8, i8* %this, i32 12
	%_36 = bitcast i8* %_35 to i32* 
	%_37 = load i32, i32* %_36
	call void (i32) @print_int(i32 %_37)

	%_38 = getelementptr i8, i8* %this, i32 12
	%_39 = bitcast i8* %_38 to i32* 
	store i32 1,i32* %_39

	%_43 = bitcast i8* %this to i8*** 
	%_44 = load i8**, i8*** %_43 
	%_45 = getelementptr i8*, i8** %_44, i32 2 
	%_46 = load i8*, i8** %_45 
	%_47 = bitcast i8* %_46 to i32 (i8* )* 
	%_48 = call i32 %_47( i8* %this) 

	store i32 %_48,i32* %j

	br label %if_end_0
	if_then_0: 
	%_49 = getelementptr i8, i8* %this, i32 12
	%_50 = bitcast i8* %_49 to i32* 
	store i32 0,i32* %_50

	br label %if_end_0
	if_end_0: 

	%_51 = getelementptr i8, i8* %this, i32 12
	%_52 = bitcast i8* %_51 to i32* 
	%_53 = load i32, i32* %_52
	ret i32 %_53
}
 
define i32 @Test.mutual2(i8* %this) {
	%j = alloca i32
	%_54 = getelementptr i8, i8* %this, i32 8
	%_55 = bitcast i8* %_54 to i32* 
	%_56 = getelementptr i8, i8* %this, i32 8
	%_57 = bitcast i8* %_56 to i32* 
	%_58 = load i32, i32* %_57
	%_59 = sub i32 %_58, 1

	store i32 %_59,i32* %_55

	%_60 = getelementptr i8, i8* %this, i32 8
	%_61 = bitcast i8* %_60 to i32* 
	%_62 = load i32, i32* %_61
	%_63 = icmp slt i32 %_62, 0

	br i1 %_63, label %if_then_1, label %if_else_1 
	if_else_1: 
	%_64 = getelementptr i8, i8* %this, i32 12
	%_65 = bitcast i8* %_64 to i32* 
	%_66 = load i32, i32* %_65
	call void (i32) @print_int(i32 %_66)

	%_67 = getelementptr i8, i8* %this, i32 12
	%_68 = bitcast i8* %_67 to i32* 
	store i32 0,i32* %_68

	%_72 = bitcast i8* %this to i8*** 
	%_73 = load i8**, i8*** %_72 
	%_74 = getelementptr i8*, i8** %_73, i32 1 
	%_75 = load i8*, i8** %_74 
	%_76 = bitcast i8* %_75 to i32 (i8* )* 
	%_77 = call i32 %_76( i8* %this) 

	store i32 %_77,i32* %j

	br label %if_end_1
	if_then_1: 
	%_78 = getelementptr i8, i8* %this, i32 12
	%_79 = bitcast i8* %_78 to i32* 
	store i32 0,i32* %_79

	br label %if_end_1
	if_end_1: 

	%_80 = getelementptr i8, i8* %this, i32 12
	%_81 = bitcast i8* %_80 to i32* 
	%_82 = load i32, i32* %_81
	ret i32 %_82
}
 
