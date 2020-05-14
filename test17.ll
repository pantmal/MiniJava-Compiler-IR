@.test17_vtable = global [0 x i8*] [] 
 
@.Test_vtable = global [ 3 x i8*] [  
	i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i8* (i8*,i8*)* @Test.first to i8*),
	i8* bitcast (i32 (i8*)* @Test.second to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 12)
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
	%test = alloca i8*
	%_12 = call i8* @calloc(i32 1, i32 12)
	%_13 = bitcast i8* %_12 to i8*** 
	%_14 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_14, i8*** %_13

	store i8* %_12,i8** %test

	%_15 = getelementptr i8, i8* %this, i32 8
	%_16 = bitcast i8* %_15 to i32* 
	store i32 10,i32* %_16

	%_17 = getelementptr i8, i8* %this, i32 8
	%_18 = bitcast i8* %_17 to i32* 
	%_19 = getelementptr i8, i8* %this, i32 8
	%_20 = bitcast i8* %_19 to i32* 
	%_21 = load i32, i32* %_20
	%_22 = load i8*, i8** %test
	%_26 = bitcast i8* %_22 to i8*** 
	%_27 = load i8**, i8*** %_26 
	%_28 = getelementptr i8*, i8** %_27, i32 1 
	%_29 = load i8*, i8** %_28 
	%_30 = bitcast i8* %_29 to i8* (i8* , i8*)* 
	%_31 = call i8* %_30( i8* %_22, i8* %this) 

	%_32 = load i8*, i8** %test
	%_36 = bitcast i8* %_32 to i8*** 
	%_37 = load i8**, i8*** %_36 
	%_38 = getelementptr i8*, i8** %_37, i32 1 
	%_39 = load i8*, i8** %_38 
	%_40 = bitcast i8* %_39 to i8* (i8* , i8*)* 
	%_41 = call i8* %_40( i8* %_32, i8* %this) 

	%_45 = bitcast i8* %_41 to i8*** 
	%_46 = load i8**, i8*** %_45 
	%_47 = getelementptr i8*, i8** %_46, i32 2 
	%_48 = load i8*, i8** %_47 
	%_49 = bitcast i8* %_48 to i32 (i8* )* 
	%_50 = call i32 %_49( i8* %_41) 

	%_51 = add i32 %_21, %_50

	store i32 %_51,i32* %_18

	%_52 = getelementptr i8, i8* %this, i32 8
	%_53 = bitcast i8* %_52 to i32* 
	%_54 = load i32, i32* %_53
	ret i32 %_54
}
 
define i8* @Test.first(i8* %this, i8* %.test2) {
	%test2 = alloca i8*
	store i8* %.test2, i8** %test2
	%test3 = alloca i8*
	%_55 = load i8*, i8** %test2
	store i8* %_55,i8** %test3

	%_56 = load i8*, i8** %test3
	ret i8* %_56
}
 
define i32 @Test.second(i8* %this) {
	%_57 = getelementptr i8, i8* %this, i32 8
	%_58 = bitcast i8* %_57 to i32* 
	%_59 = getelementptr i8, i8* %this, i32 8
	%_60 = bitcast i8* %_59 to i32* 
	%_61 = load i32, i32* %_60
	%_62 = add i32 %_61, 10

	store i32 %_62,i32* %_58

	%_63 = getelementptr i8, i8* %this, i32 8
	%_64 = bitcast i8* %_63 to i32* 
	%_65 = load i32, i32* %_64
	ret i32 %_65
}
 
