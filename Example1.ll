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

	%_17 = load i32, i32* %b
	%_18 = add i32 1, %_17
	%_19 = icmp sge i32 %_18, 1
	br i1 %_19, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_20 = call i8* @calloc(i32 %_18, i32 4) 
	%_21 = bitcast i8* %_20 to i32* 
	store i32 %_17, i32* %_21
 

	store i32* %_21,i32** %nti

	%_27 = load i32*, i32** %nti
	%_28 = load i32, i32* %_27
	%_29 = icmp sge i32 0, 0
	%_30 = icmp slt i32 0, %_28
	%_31 = and i1 %_29, %_30
	br i1 %_31, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_32 = add i32 1, 0
	%_33 = getelementptr i32, i32* %_27, i32 %_32
	%_34 = load i32, i32* %_33

	store i32 %_34,i32* %ourint

	%_35 = load i32, i32* %ourint
	call void (i32) @print_int(i32 %_35)

	%_36 = load i32*, i32** %nti
	%_37 = load i32, i32* %_36
	%_38 = icmp sge i32 0, 0
	%_39 = icmp slt i32 0, %_37
	%_40 = and i1 %_38, %_39
	br i1 %_40, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_41 = add i32 1, 0
	%_42 = getelementptr i32, i32* %_36, i32 %_41
	%_43 = load i32, i32* %_42

	ret i32 %_43
}
 
