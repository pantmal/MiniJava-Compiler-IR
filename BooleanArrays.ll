@.BooleanArrays_vtable = global [0 x i8*] [] 
 

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
	%x = alloca i8*
	%y = alloca i1
	%z = alloca i1
	%_0 = add i32 1, 2
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_2 = add i32 4, 2
	%_3 = call i8* @calloc(i32 1, i32 %_2) 
	%_4 = bitcast i8* %_3 to i32* 
	store i32 2, i32* %_4 
	%_5 = bitcast i32* %_4 to i8* 

	store i8* %_5,i8** %x

	%_6 = load i8*, i8** %x
	%_7 = bitcast i8* %_6 to i32* 
	%_8 = load i32, i32* %_7
	%_9 = icmp sge i32 0, 0
	%_10 = icmp slt i32 0, %_8
	%_11 = and i1 %_9, %_10
	br i1 %_11, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_12 = add i32 4, 0
	%_13 = getelementptr i8, i8* %_6, i32 %_12
	%_14 = zext i1 1 to i8 
	store i8 %_14, i8* %_13
 

	%_15 = load i8*, i8** %x
	%_16 = bitcast i8* %_15 to i32* 
	%_17 = load i32, i32* %_16
	%_18 = icmp sge i32 1, 0
	%_19 = icmp slt i32 1, %_17
	%_20 = and i1 %_18, %_19
	br i1 %_20, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_21 = add i32 4, 1
	%_22 = getelementptr i8, i8* %_15, i32 %_21
	%_23 = zext i1 0 to i8 
	store i8 %_23, i8* %_22
 

	%_24 = load i8*, i8** %x
	%_25 = bitcast i8* %_24 to i32* 
	%_26 = load i32, i32* %_25
	%_27 = icmp sge i32 0, 0
	%_28 = icmp slt i32 0, %_26
	%_29 = and i1 %_27, %_28
	br i1 %_29, label %oob_ok_3, label %oob_err_3
 
	oob_err_3: 
	call void @throw_oob()
	br label %oob_ok_3
 
	oob_ok_3: 
	%_30 = add i32 4, 0
	%_31 = getelementptr i8, i8* %_24, i32 %_30
	%_32 = load i8, i8* %_31
	%_33= trunc i8 %_32 to i1 

	store i1 %_33,i1* %y

	%_34 = load i8*, i8** %x
	%_35 = bitcast i8* %_34 to i32* 
	%_36 = load i32, i32* %_35
	%_37 = icmp sge i32 1, 0
	%_38 = icmp slt i32 1, %_36
	%_39 = and i1 %_37, %_38
	br i1 %_39, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_40 = add i32 4, 1
	%_41 = getelementptr i8, i8* %_34, i32 %_40
	%_42 = load i8, i8* %_41
	%_43= trunc i8 %_42 to i1 

	store i1 %_43,i1* %z

	%_44 = load i8*, i8** %x
	%_45 = bitcast i8* %_44 to i32* 
	%_46 = load i32, i32* %_45
	%_47 = icmp sge i32 0, 0
	%_48 = icmp slt i32 0, %_46
	%_49 = and i1 %_47, %_48
	br i1 %_49, label %oob_ok_6, label %oob_err_6
 
	oob_err_6: 
	call void @throw_oob()
	br label %oob_ok_6
 
	oob_ok_6: 
	%_50 = add i32 4, 0
	%_51 = getelementptr i8, i8* %_44, i32 %_50
	%_52 = load i8, i8* %_51
	%_53= trunc i8 %_52 to i1 

	br i1 %_53, label %if_then_5, label %if_else_5 
	if_else_5: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_5
	if_then_5: 
	call void (i32) @print_int(i32 69)

	br label %if_end_5
	if_end_5: 

	%_54 = load i1, i1* %y
	br i1 %_54, label %if_then_7, label %if_else_7 
	if_else_7: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_7
	if_then_7: 
	call void (i32) @print_int(i32 69)

	br label %if_end_7
	if_end_7: 

	%_55 = load i8*, i8** %x
	%_56 = bitcast i8* %_55 to i32* 
	%_57 = load i32, i32* %_56
	%_58 = icmp sge i32 1, 0
	%_59 = icmp slt i32 1, %_57
	%_60 = and i1 %_58, %_59
	br i1 %_60, label %oob_ok_9, label %oob_err_9
 
	oob_err_9: 
	call void @throw_oob()
	br label %oob_ok_9
 
	oob_ok_9: 
	%_61 = add i32 4, 1
	%_62 = getelementptr i8, i8* %_55, i32 %_61
	%_63 = load i8, i8* %_62
	%_64= trunc i8 %_63 to i1 

	br i1 %_64, label %if_then_8, label %if_else_8 
	if_else_8: 
	call void (i32) @print_int(i32 420)

	br label %if_end_8
	if_then_8: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_8
	if_end_8: 

	%_65 = load i1, i1* %z
	br i1 %_65, label %if_then_10, label %if_else_10 
	if_else_10: 
	call void (i32) @print_int(i32 420)

	br label %if_end_10
	if_then_10: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_10
	if_end_10: 

	%_66 = load i8*, i8** %x
	%_67 = bitcast i8* %_66 to i32* 
	%_68 = load i32, i32* %_67

	call void (i32) @print_int(i32 %_68)

	ret i32 0
}
 
