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

	%_17 = call i8* @calloc(i32 1, i32 12)
	%_18 = bitcast i8* %_17 to i8*** 
	%_19 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_19, i8*** %_18

	store i8* %_17,i8** %test

	%_20 = getelementptr i8, i8* %this, i32 8
	%_21 = bitcast i8* %_20 to i32* 
	store i32 10,i32* %_21

	%_27 = getelementptr i8, i8* %this, i32 8
	%_28 = bitcast i8* %_27 to i32* 
	%_34 = getelementptr i8, i8* %this, i32 8
	%_35 = bitcast i8* %_34 to i32* 
	%_36 = load i32, i32* %_35
	%_37 = load i8*, i8** %test
	%_41 = bitcast i8* %_37 to i8*** 
	%_42 = load i8**, i8*** %_41 
	%_43 = getelementptr i8*, i8** %_42, i32 1 
	%_44 = load i8*, i8** %_43 
	%_45 = bitcast i8* %_44 to i8* (i8* , i8*)* 
	%_46 = call i8* %_45( i8* %_37, i8* %this) 

	%_47 = load i8*, i8** %test
	%_51 = bitcast i8* %_47 to i8*** 
	%_52 = load i8**, i8*** %_51 
	%_53 = getelementptr i8*, i8** %_52, i32 1 
	%_54 = load i8*, i8** %_53 
	%_55 = bitcast i8* %_54 to i8* (i8* , i8*)* 
	%_56 = call i8* %_55( i8* %_47, i8* %this) 

	%_60 = bitcast i8* %_56 to i8*** 
	%_61 = load i8**, i8*** %_60 
	%_62 = getelementptr i8*, i8** %_61, i32 2 
	%_63 = load i8*, i8** %_62 
	%_64 = bitcast i8* %_63 to i32 (i8* )* 
	%_65 = call i32 %_64( i8* %_56) 

	%_66 = add i32 %_36, %_65

	store i32 %_66,i32* %_28

	%_67 = getelementptr i8, i8* %this, i32 8
	%_68 = bitcast i8* %_67 to i32* 
	%_69 = load i32, i32* %_68
	ret i32 %_69
}
 
define i8* @Test.first(i8* %this, i8* %.test2) {
	%test2 = alloca i8*
	store i8* %.test2, i8** %test2
	%test3 = alloca i8*

	%_75 = load i8*, i8** %test2
	store i8* %_75,i8** %test3

	%_76 = load i8*, i8** %test3
	ret i8* %_76
}
 
define i32 @Test.second(i8* %this) {
	%_77 = getelementptr i8, i8* %this, i32 8
	%_78 = bitcast i8* %_77 to i32* 
	%_84 = getelementptr i8, i8* %this, i32 8
	%_85 = bitcast i8* %_84 to i32* 
	%_86 = load i32, i32* %_85
	%_87 = add i32 %_86, 10

	store i32 %_87,i32* %_78

	%_88 = getelementptr i8, i8* %this, i32 8
	%_89 = bitcast i8* %_88 to i32* 
	%_90 = load i32, i32* %_89
	ret i32 %_90
}
 
