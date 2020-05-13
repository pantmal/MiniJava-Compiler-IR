@.ArrayTest_vtable = global [0 x i8*] [] 
 
@.Test_vtable = global [ 1 x i8*] [  
	i8* bitcast (i1 (i8*,i32)* @Test.start to i8*)
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
	%n = alloca i1

	%_5 = call i8* @calloc(i32 1, i32 8)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [1 x i8*], [1 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	%_11 = bitcast i8* %_5 to i8*** 
	%_12 = load i8**, i8*** %_11 
	%_13 = getelementptr i8*, i8** %_12, i32 0 
	%_14 = load i8*, i8** %_13 
	%_15 = bitcast i8* %_14 to i1 (i8* , i32)* 
	%_16 = call i1 %_15( i8* %_5, i32 10) 

	store i1 %_16,i1* %n

	ret i32 0
}
 
define i1 @Test.start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%b = alloca i32*

	%l = alloca i32

	%i = alloca i32

	%_22 = load i32, i32* %sz
	%_23 = add i32 1, %_22
	%_24 = icmp sge i32 %_23, 1
	br i1 %_24, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_25 = call i8* @calloc(i32 %_23, i32 4) 
	%_26 = bitcast i8* %_25 to i32* 
	store i32 %_22, i32* %_26
 

	store i32* %_26,i32** %b

	%_32 = load i32*, i32** %b
	%_33 = load i32, i32* %_32

	store i32 %_33,i32* %l

	store i32 0,i32* %i

	br label %loop1
	loop1: 
	%_39 = load i32, i32* %i
	%_40 = load i32, i32* %l
	%_41 = icmp slt i32 %_39, %_40

	br i1 %_41, label %loop2, label %loop3 
	loop2: 
	%_47 = load i32, i32* %i
	%_48 = load i32, i32* %i
	%_49 = load i32*, i32** %b
	%_50 = load i32, i32* %_49
	%_51 = icmp sge i32 %_47, 0
	%_52 = icmp slt i32 %_47, %_50
	%_53 = and i1 %_51, %_52
	br i1 %_53, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_54 = add i32 1, %_47
	%_55 = getelementptr i32, i32* %_49, i32 %_54
	store i32 %_48, i32* %_55
 

	%_56 = load i32*, i32** %b
	%_57 = load i32, i32* %i
	%_58 = load i32, i32* %_56
	%_59 = icmp sge i32 %_57, 0
	%_60 = icmp slt i32 %_57, %_58
	%_61 = and i1 %_59, %_60
	br i1 %_61, label %oob_ok_5, label %oob_err_5
 
	oob_err_5: 
	call void @throw_oob()
	br label %oob_ok_5
 
	oob_ok_5: 
	%_62 = add i32 1, %_57
	%_63 = getelementptr i32, i32* %_56, i32 %_62
	%_64 = load i32, i32* %_63

	call void (i32) @print_int(i32 %_64)

	%_70 = load i32, i32* %i
	%_71 = add i32 %_70, 1

	store i32 %_71,i32* %i

	br label %loop1
	loop3: 

	ret i1 1
}
 
