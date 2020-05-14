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
	%_14 = add i32 1, 10
	%_15 = icmp sge i32 %_14, 1
	br i1 %_15, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_16 = call i8* @calloc(i32 %_14, i32 4) 
	%_17 = bitcast i8* %_16 to i32* 
	store i32 10, i32* %_17
 

	store i32* %_17,i32** %_13

	%_18 = getelementptr i8, i8* %this, i32 8
	%_19 = bitcast i8* %_18 to i8** 
	%_20 = call i8* @calloc(i32 1, i32 24)
	%_21 = bitcast i8* %_20 to i8*** 
	%_22 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_22, i8*** %_21

	store i8* %_20,i8** %_19

	%_23 = getelementptr i8, i8* %this, i32 8
	%_24 = bitcast i8* %_23 to i8** 
	%_25 = getelementptr i8, i8* %this, i32 8
	%_26 = bitcast i8* %_25 to i8** 
	%_27 = load i8*, i8** %_26
	%_31 = bitcast i8* %_27 to i8*** 
	%_32 = load i8**, i8*** %_31 
	%_33 = getelementptr i8*, i8** %_32, i32 1 
	%_34 = load i8*, i8** %_33 
	%_35 = bitcast i8* %_34 to i8* (i8* )* 
	%_36 = call i8* %_35( i8* %_27) 

	%_37 = getelementptr i8, i8* %this, i32 8
	%_38 = bitcast i8* %_37 to i8** 
	%_39 = load i8*, i8** %_38
	%_43 = bitcast i8* %_39 to i8*** 
	%_44 = load i8**, i8*** %_43 
	%_45 = getelementptr i8*, i8** %_44, i32 1 
	%_46 = load i8*, i8** %_45 
	%_47 = bitcast i8* %_46 to i8* (i8* )* 
	%_48 = call i8* %_47( i8* %_39) 

	%_52 = bitcast i8* %_48 to i8*** 
	%_53 = load i8**, i8*** %_52 
	%_54 = getelementptr i8*, i8** %_53, i32 1 
	%_55 = load i8*, i8** %_54 
	%_56 = bitcast i8* %_55 to i8* (i8* )* 
	%_57 = call i8* %_56( i8* %_48) 

	store i8* %_57,i8** %_24

	ret i32 0
}
 
define i8* @Test.next(i8* %this) {
	%_58 = getelementptr i8, i8* %this, i32 8
	%_59 = bitcast i8* %_58 to i8** 
	%_60 = call i8* @calloc(i32 1, i32 24)
	%_61 = bitcast i8* %_60 to i8*** 
	%_62 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_62, i8*** %_61

	store i8* %_60,i8** %_59

	%_63 = getelementptr i8, i8* %this, i32 8
	%_64 = bitcast i8* %_63 to i8** 
	%_65 = load i8*, i8** %_64
	ret i8* %_65
}
 
