@.Arrays_vtable = global [0 x i8*] [] 
 

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
	%x = alloca i32*
	%_0 = sub i32 0, 666

	%_1 = add i32 1, %_0
	%_2 = icmp sge i32 %_1, 1
	br i1 %_2, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_3 = call i8* @calloc(i32 %_1, i32 4) 
	%_4 = bitcast i8* %_3 to i32* 
	store i32 %_0, i32* %_4
 

	store i32* %_4,i32** %x

	%_5 = load i32*, i32** %x
	%_6 = load i32, i32* %_5
	%_7 = icmp sge i32 0, 0
	%_8 = icmp slt i32 0, %_6
	%_9 = and i1 %_7, %_8
	br i1 %_9, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_10 = add i32 1, 0
	%_11 = getelementptr i32, i32* %_5, i32 %_10
	store i32 1, i32* %_11
 

	%_12 = load i32*, i32** %x
	%_13 = load i32, i32* %_12
	%_14 = icmp sge i32 1, 0
	%_15 = icmp slt i32 1, %_13
	%_16 = and i1 %_14, %_15
	br i1 %_16, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_17 = add i32 1, 1
	%_18 = getelementptr i32, i32* %_12, i32 %_17
	store i32 2, i32* %_18
 

	%_19 = load i32*, i32** %x
	%_20 = load i32, i32* %_19
	%_21 = icmp sge i32 0, 0
	%_22 = icmp slt i32 0, %_20
	%_23 = and i1 %_21, %_22
	br i1 %_23, label %oob_ok_3, label %oob_err_3
 
	oob_err_3: 
	call void @throw_oob()
	br label %oob_ok_3
 
	oob_ok_3: 
	%_24 = add i32 1, 0
	%_25 = getelementptr i32, i32* %_19, i32 %_24
	%_26 = load i32, i32* %_25

	%_27 = load i32*, i32** %x
	%_28 = load i32, i32* %_27
	%_29 = icmp sge i32 1, 0
	%_30 = icmp slt i32 1, %_28
	%_31 = and i1 %_29, %_30
	br i1 %_31, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_32 = add i32 1, 1
	%_33 = getelementptr i32, i32* %_27, i32 %_32
	%_34 = load i32, i32* %_33

	%_35 = add i32 %_26, %_34

	call void (i32) @print_int(i32 %_35)

	%_36 = load i32*, i32** %x
	%_37 = load i32, i32* %_36

	call void (i32) @print_int(i32 %_37)

	ret i32 0
}
 
