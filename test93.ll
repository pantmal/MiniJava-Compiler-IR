@.test93_vtable = global [0 x i8*] [] 
 
@.Test_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i8* (i8*)* @Test.next to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 24)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
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
	%_12 = getelementptr i8, i8* %this, i32 16
	%_13 = bitcast i8* %_12 to i32** 
	%_19 = add i32 1, 10
	%_20 = icmp sge i32 %_19, 1
	br i1 %_20, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_21 = call i8* @calloc(i32 %_19, i32 4) 
	%_22 = bitcast i8* %_21 to i32* 
	store i32 10, i32* %_22
 

	store i32* %_22,i32** %_13

	%_23 = getelementptr i8, i8* %this, i32 8
	%_24 = bitcast i8* %_23 to i8** 
	%_30 = call i8* @calloc(i32 1, i32 24)
	%_31 = bitcast i8* %_30 to i8*** 
	%_32 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_32, i8*** %_31

	store i8* %_30,i8** %_24

	%_33 = getelementptr i8, i8* %this, i32 8
	%_34 = bitcast i8* %_33 to i8** 
	%_40 = getelementptr i8, i8* %this, i32 8
	%_41 = bitcast i8* %_40 to i8** 
	%_42 = load i8*, i8** %_41
	%_46 = bitcast i8* %_42 to i8*** 
	%_47 = load i8**, i8*** %_46 
	%_48 = getelementptr i8*, i8** %_47, i32 1 
	%_49 = load i8*, i8** %_48 
	%_50 = bitcast i8* %_49 to i8* (i8* )* 
	%_51 = call i8* %_50( i8* %_42) 

	%_52 = getelementptr i8, i8* %this, i32 8
	%_53 = bitcast i8* %_52 to i8** 
	%_54 = load i8*, i8** %_53
	%_58 = bitcast i8* %_54 to i8*** 
	%_59 = load i8**, i8*** %_58 
	%_60 = getelementptr i8*, i8** %_59, i32 1 
	%_61 = load i8*, i8** %_60 
	%_62 = bitcast i8* %_61 to i8* (i8* )* 
	%_63 = call i8* %_62( i8* %_54) 

	%_67 = bitcast i8* %_63 to i8*** 
	%_68 = load i8**, i8*** %_67 
	%_69 = getelementptr i8*, i8** %_68, i32 1 
	%_70 = load i8*, i8** %_69 
	%_71 = bitcast i8* %_70 to i8* (i8* )* 
	%_72 = call i8* %_71( i8* %_63) 

	store i8* %_72,i8** %_34

	ret i32 0
}
 
define i8* @Test.next(i8* %this) {
	%_73 = getelementptr i8, i8* %this, i32 8
	%_74 = bitcast i8* %_73 to i8** 
	%_80 = call i8* @calloc(i32 1, i32 24)
	%_81 = bitcast i8* %_80 to i8*** 
	%_82 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_82, i8*** %_81

	store i8* %_80,i8** %_74

	%_83 = getelementptr i8, i8* %this, i32 8
	%_84 = bitcast i8* %_83 to i8** 
	%_85 = load i8*, i8** %_84
	ret i8* %_85
}
 
