@.Example1_vtable = global [0 x i8*] [] 
 
@.Test1_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i32,i1)* @Test1.Start to i8*)
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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test1_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	%_6 = bitcast i8* %_0 to i8*** 
	%_7 = load i8**, i8*** %_6 
	%_8 = getelementptr i8*, i8** %_7, i32 0 
	%_9 = load i8*, i8** %_8 
	%_10 = bitcast i8* %_9 to i32 (i8* , i32, i1)* 
	%_11 = call i32 %_10( i8* %_0, i32 5, i1 1) 

	call void (i32) @print_int(i32 %_11)

	ret i32 0
}
 
define i32 @Test1.Start(i8* %this, i32 %.b, i1 %.c) {
	%b = alloca i32
	store i32 %.b, i32* %b
	%c = alloca i1
	store i1 %.c, i1* %c
	%ntb = alloca i1
	%nti = alloca i32*
	%ourint = alloca i32
	%_12 = load i32, i32* %b
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
 

	store i32* %_16,i32** %nti

	%_17 = load i32*, i32** %nti
	%_18 = load i32, i32* %_17
	%_19 = icmp sge i32 0, 0
	%_20 = icmp slt i32 0, %_18
	%_21 = and i1 %_19, %_20
	br i1 %_21, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_22 = add i32 1, 0
	%_23 = getelementptr i32, i32* %_17, i32 %_22
	%_24 = load i32, i32* %_23

	store i32 %_24,i32* %ourint

	%_25 = load i32, i32* %ourint
	call void (i32) @print_int(i32 %_25)

	%_26 = load i32*, i32** %nti
	%_27 = load i32, i32* %_26
	%_28 = icmp sge i32 0, 0
	%_29 = icmp slt i32 0, %_27
	%_30 = and i1 %_28, %_29
	br i1 %_30, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_31 = add i32 1, 0
	%_32 = getelementptr i32, i32* %_26, i32 %_31
	%_33 = load i32, i32* %_32

	ret i32 %_33
}
 
