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
	%_0 = call i8* @calloc(i32 1, i32 9)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	store i8* %_0,i8** %b

	%_3 = call i8* @calloc(i32 1, i32 9)
	%_4 = bitcast i8* %_3 to i8*** 
	%_5 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0 
	store i8** %_5, i8*** %_4

	store i8* %_3,i8** %c

	%_6 = load i8*, i8** %b
	%_10 = bitcast i8* %_6 to i8*** 
	%_11 = load i8**, i8*** %_10 
	%_12 = getelementptr i8*, i8** %_11, i32 1 
	%_13 = load i8*, i8** %_12 
	%_14 = bitcast i8* %_13 to i1 (i8* )* 
	%_15 = call i1 %_14( i8* %_6) 

	store i1 %_15,i1* %rv

	%_16 = load i8*, i8** %c
	%_20 = bitcast i8* %_16 to i8*** 
	%_21 = load i8**, i8*** %_20 
	%_22 = getelementptr i8*, i8** %_21, i32 2 
	%_23 = load i8*, i8** %_22 
	%_24 = bitcast i8* %_23 to i1 (i8* )* 
	%_25 = call i1 %_24( i8* %_16) 

	store i1 %_25,i1* %rv

	%_26 = load i8*, i8** %b
	%_30 = bitcast i8* %_26 to i8*** 
	%_31 = load i8**, i8*** %_30 
	%_32 = getelementptr i8*, i8** %_31, i32 0 
	%_33 = load i8*, i8** %_32 
	%_34 = bitcast i8* %_33 to i32 (i8* )* 
	%_35 = call i32 %_34( i8* %_26) 

	call void (i32) @print_int(i32 %_35)

	%_36 = load i8*, i8** %c
	%_40 = bitcast i8* %_36 to i8*** 
	%_41 = load i8**, i8*** %_40 
	%_42 = getelementptr i8*, i8** %_41, i32 0 
	%_43 = load i8*, i8** %_42 
	%_44 = bitcast i8* %_43 to i32 (i8* )* 
	%_45 = call i32 %_44( i8* %_36) 

	call void (i32) @print_int(i32 %_45)

	ret i32 0
}
 
define i32 @A.get(i8* %this) {
	%rv = alloca i32
	%_46 = getelementptr i8, i8* %this, i32 8
	%_47 = bitcast i8* %_46 to i1* 
	%_48 = load i1, i1* %_47
	br i1 %_48, label %if_then_0, label %if_else_0 
	if_else_0: 
	store i32 0,i32* %rv

	br label %if_end_0
	if_then_0: 
	store i32 1,i32* %rv

	br label %if_end_0
	if_end_0: 

	%_49 = load i32, i32* %rv
	ret i32 %_49
}
 
define i1 @B.set(i8* %this) {
	%old = alloca i1
	%_50 = getelementptr i8, i8* %this, i32 8
	%_51 = bitcast i8* %_50 to i1* 
	%_52 = load i1, i1* %_51
	store i1 %_52,i1* %old

	%_53 = getelementptr i8, i8* %this, i32 8
	%_54 = bitcast i8* %_53 to i1* 
	store i1 1,i1* %_54

	%_55 = getelementptr i8, i8* %this, i32 8
	%_56 = bitcast i8* %_55 to i1* 
	%_57 = load i1, i1* %_56
	ret i1 %_57
}
 
define i1 @C.reset(i8* %this) {
	%old = alloca i1
	%_58 = getelementptr i8, i8* %this, i32 8
	%_59 = bitcast i8* %_58 to i1* 
	%_60 = load i1, i1* %_59
	store i1 %_60,i1* %old

	%_61 = getelementptr i8, i8* %this, i32 8
	%_62 = bitcast i8* %_61 to i1* 
	store i1 0,i1* %_62

	%_63 = getelementptr i8, i8* %this, i32 8
	%_64 = bitcast i8* %_63 to i1* 
	%_65 = load i1, i1* %_64
	ret i1 %_65
}
 
