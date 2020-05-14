@.OutOfBounds1_vtable = global [0 x i8*] [] 
 
@.A_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.run to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0 
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
 
define i32 @A.run(i8* %this) {
	%a = alloca i32*
	%_12 = add i32 1, 20
	%_13 = icmp sge i32 %_12, 1
	br i1 %_13, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_14 = call i8* @calloc(i32 %_12, i32 4) 
	%_15 = bitcast i8* %_14 to i32* 
	store i32 20, i32* %_15
 

	store i32* %_15,i32** %a

	%_16 = load i32*, i32** %a
	%_17 = load i32, i32* %_16
	%_18 = icmp sge i32 10, 0
	%_19 = icmp slt i32 10, %_17
	%_20 = and i1 %_18, %_19
	br i1 %_20, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_21 = add i32 1, 10
	%_22 = getelementptr i32, i32* %_16, i32 %_21
	%_23 = load i32, i32* %_22

	call void (i32) @print_int(i32 %_23)

	%_24 = load i32*, i32** %a
	%_25 = load i32, i32* %_24
	%_26 = icmp sge i32 40, 0
	%_27 = icmp slt i32 40, %_25
	%_28 = and i1 %_26, %_27
	br i1 %_28, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_29 = add i32 1, 40
	%_30 = getelementptr i32, i32* %_24, i32 %_29
	%_31 = load i32, i32* %_30

	ret i32 %_31
}
 
