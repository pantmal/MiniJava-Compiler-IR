@.ManyClasses_vtable = global [0 x i8*] [] 
 
@.A_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.get to i8*)
]
 
@.B_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.get to i8*),
	i8* bitcast (i1 (i8*)* @B.set to i8*)
]
 
@.C_vtable = global [ 3 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.get to i8*),
	i8* bitcast (i1 (i8*)* @B.set to i8*),
	i8* bitcast (i1 (i8*)* @C.reset to i8*)
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
	%rv = alloca i1

	%a = alloca i8*

	%b = alloca i8*

	%c = alloca i8*

	%_5 = call i8* @calloc(i32 1, i32 9)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	store i8* %_5,i8** %b

	%_13 = call i8* @calloc(i32 1, i32 9)
	%_14 = bitcast i8* %_13 to i8*** 
	%_15 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0 
	store i8** %_15, i8*** %_14

	store i8* %_13,i8** %c

	%_21 = load i8*, i8** %b
	%_25 = bitcast i8* %_21 to i8*** 
	%_26 = load i8**, i8*** %_25 
	%_27 = getelementptr i8*, i8** %_26, i32 1 
	%_28 = load i8*, i8** %_27 
	%_29 = bitcast i8* %_28 to i1 (i8* )* 
	%_30 = call i1 %_29( i8* %_21) 

	store i1 %_30,i1* %rv

	%_36 = load i8*, i8** %c
	%_40 = bitcast i8* %_36 to i8*** 
	%_41 = load i8**, i8*** %_40 
	%_42 = getelementptr i8*, i8** %_41, i32 2 
	%_43 = load i8*, i8** %_42 
	%_44 = bitcast i8* %_43 to i1 (i8* )* 
	%_45 = call i1 %_44( i8* %_36) 

	store i1 %_45,i1* %rv

	%_46 = load i8*, i8** %b
	%_50 = bitcast i8* %_46 to i8*** 
	%_51 = load i8**, i8*** %_50 
	%_52 = getelementptr i8*, i8** %_51, i32 0 
	%_53 = load i8*, i8** %_52 
	%_54 = bitcast i8* %_53 to i32 (i8* )* 
	%_55 = call i32 %_54( i8* %_46) 

	call void (i32) @print_int(i32 %_55)

	%_56 = load i8*, i8** %c
	%_60 = bitcast i8* %_56 to i8*** 
	%_61 = load i8**, i8*** %_60 
	%_62 = getelementptr i8*, i8** %_61, i32 0 
	%_63 = load i8*, i8** %_62 
	%_64 = bitcast i8* %_63 to i32 (i8* )* 
	%_65 = call i32 %_64( i8* %_56) 

	call void (i32) @print_int(i32 %_65)

	ret i32 0
}
 
define i32 @A.get(i8* %this) {
	%rv = alloca i32

	%_66 = getelementptr i8, i8* %this, i32 8
	%_67 = bitcast i8* %_66 to i1* 
	%_68 = load i1, i1* %_67
	br i1 %_68, label %if_then_0, label %if_else_0 
	if_else_0: 
	store i32 0,i32* %rv

	br label %if_end_0
	if_then_0: 
	store i32 1,i32* %rv

	br label %if_end_0
	if_end_0: 

	%_79 = load i32, i32* %rv
	ret i32 %_79
}
 
define i1 @B.set(i8* %this) {
	%old = alloca i1

	%_90 = getelementptr i8, i8* %this, i32 8
	%_91 = bitcast i8* %_90 to i1* 
	%_92 = load i1, i1* %_91
	store i1 %_92,i1* %old

	%_90 = getelementptr i8, i8* %this, i32 8
	%_91 = bitcast i8* %_90 to i1* 
	store i1 1,i1* %_91

	%_95 = getelementptr i8, i8* %this, i32 8
	%_96 = bitcast i8* %_95 to i1* 
	%_97 = load i1, i1* %_96
	ret i1 %_97
}
 
define i1 @C.reset(i8* %this) {
	%old = alloca i1

	%_100 = getelementptr i8, i8* %this, i32 8
	%_101 = bitcast i8* %_100 to i1* 
	%_102 = load i1, i1* %_101
	store i1 %_102,i1* %old

	%_100 = getelementptr i8, i8* %this, i32 8
	%_101 = bitcast i8* %_100 to i1* 
	store i1 0,i1* %_101

	%_105 = getelementptr i8, i8* %this, i32 8
	%_106 = bitcast i8* %_105 to i1* 
	%_107 = load i1, i1* %_106
	ret i1 %_107
}
 
