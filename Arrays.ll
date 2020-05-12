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
	%_5 = add i32 1, 2
	%_6 = icmp sge i32 %_5, 1
	br i1 %_6, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_7 = call i8* @calloc(i32 %_5, i32 4) 
	%_8 = bitcast i8* %_7 to i32* 
	store i32 2, i32* %_8
 
	store i32* %_8,i32** %x
	%_14 = load i32*, i32** %x
	%_15 = load i32, i32* %_14
	%_16 = icmp sge i32 0, 0
	%_17 = icmp slt i32 0, %_15
	%_18 = and i1 %_16, %_17
	br i1 %_18, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_19 = add i32 1, 0
	%_20 = getelementptr i32, i32* %_14, i32 %_19
	store i32 1, i32* %_20
 
	%_26 = load i32*, i32** %x
	%_27 = load i32, i32* %_26
	%_28 = icmp sge i32 1, 0
	%_29 = icmp slt i32 1, %_27
	%_30 = and i1 %_28, %_29
	br i1 %_30, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_31 = add i32 1, 1
	%_32 = getelementptr i32, i32* %_26, i32 %_31
	store i32 2, i32* %_32
 
	%_33 = load i32*, i32** %x
	%_34 = load i32, i32* %_33
	%_35 = icmp sge i32 0, 0
	%_36 = icmp slt i32 0, %_34
	%_37 = and i1 %_35, %_36
	br i1 %_37, label %oob_ok_3, label %oob_err_3
 
	oob_err_3: 
	call void @throw_oob()
	br label %oob_ok_3
 
	oob_ok_3: 
	%_38 = add i32 1, 0
	%_39 = getelementptr i32, i32* %_33, i32 %_38
	%_40 = load i32, i32* %_39
	%_41 = load i32*, i32** %x
	%_42 = load i32, i32* %_41
	%_43 = icmp sge i32 1, 0
	%_44 = icmp slt i32 1, %_42
	%_45 = and i1 %_43, %_44
	br i1 %_45, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_46 = add i32 1, 1
	%_47 = getelementptr i32, i32* %_41, i32 %_46
	%_48 = load i32, i32* %_47
	%_49 = add i32 %_40, %_48
	call void (i32) @print_int(i32 %_49)
	%_50 = load i32*, i32** %x
	%_51 = load i32, i32* %_50
	call void (i32) @print_int(i32 %_51)
	ret i32 0
}
