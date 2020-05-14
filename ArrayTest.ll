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
	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	%_6 = bitcast i8* %_0 to i8*** 
	%_7 = load i8**, i8*** %_6 
	%_8 = getelementptr i8*, i8** %_7, i32 0 
	%_9 = load i8*, i8** %_8 
	%_10 = bitcast i8* %_9 to i1 (i8* , i32)* 
	%_11 = call i1 %_10( i8* %_0, i32 10) 

	store i1 %_11,i1* %n

	ret i32 0
}
 
define i1 @Test.start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%b = alloca i32*
	%l = alloca i32
	%i = alloca i32
	%_12 = load i32, i32* %sz
	%_13 = add i32 1, %_12
	%_14 = icmp sge i32 %_13, 1
	br i1 %_14, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_15 = call i8* @calloc(i32 %_13, i32 4) 
	%_16 = bitcast i8* %_15 to i32* 
	store i32 %_12, i32* %_16
 

	store i32* %_16,i32** %b

	%_17 = load i32*, i32** %b
	%_18 = load i32, i32* %_17

	store i32 %_18,i32* %l

	store i32 0,i32* %i

	br label %loop1
	loop1: 
	%_19 = load i32, i32* %i
	%_20 = load i32, i32* %l
	%_21 = icmp slt i32 %_19, %_20

	br i1 %_21, label %loop2, label %loop3 
	loop2: 
	%_22 = load i32, i32* %i
	%_23 = load i32, i32* %i
	%_24 = load i32*, i32** %b
	%_25 = load i32, i32* %_24
	%_26 = icmp sge i32 %_22, 0
	%_27 = icmp slt i32 %_22, %_25
	%_28 = and i1 %_26, %_27
	br i1 %_28, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_29 = add i32 1, %_22
	%_30 = getelementptr i32, i32* %_24, i32 %_29
	store i32 %_23, i32* %_30
 

	%_31 = load i32*, i32** %b
	%_32 = load i32, i32* %i
	%_33 = load i32, i32* %_31
	%_34 = icmp sge i32 %_32, 0
	%_35 = icmp slt i32 %_32, %_33
	%_36 = and i1 %_34, %_35
	br i1 %_36, label %oob_ok_5, label %oob_err_5
 
	oob_err_5: 
	call void @throw_oob()
	br label %oob_ok_5
 
	oob_ok_5: 
	%_37 = add i32 1, %_32
	%_38 = getelementptr i32, i32* %_31, i32 %_37
	%_39 = load i32, i32* %_38

	call void (i32) @print_int(i32 %_39)

	%_40 = load i32, i32* %i
	%_41 = add i32 %_40, 1

	store i32 %_41,i32* %i

	br label %loop1
	loop3: 

	ret i1 1
}
 
