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

	%_5 = add i32 1, 2
	%_6 = icmp sge i32 %_5, 1
	br i1 %_6, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_7 = add i32 4, 2
	%_8 = call i8* @calloc(i32 1, i32 %_7) 
	%_9 = bitcast i8* %_8 to i32* 
	store i32 2, i32* %_9 
	%_10 = bitcast i32* %_9 to i8* 

	store i8* %_10,i8** %x

	%_16 = load i8*, i8** %x
	%_17 = bitcast i8* %_16 to i32* 
	%_18 = load i32, i32* %_17
	%_19 = icmp sge i32 0, 0
	%_20 = icmp slt i32 0, %_18
	%_21 = and i1 %_19, %_20
	br i1 %_21, label %oob_ok_1, label %oob_err_1
 
	oob_err_1: 
	call void @throw_oob()
	br label %oob_ok_1
 
	oob_ok_1: 
	%_22 = add i32 4, 0
	%_23 = getelementptr i8, i8* %_16, i32 %_22
	%_24 = zext i1 1 to i8 
	store i8 %_24, i8* %_23
 

	%_30 = load i8*, i8** %x
	%_31 = bitcast i8* %_30 to i32* 
	%_32 = load i32, i32* %_31
	%_33 = icmp sge i32 1, 0
	%_34 = icmp slt i32 1, %_32
	%_35 = and i1 %_33, %_34
	br i1 %_35, label %oob_ok_2, label %oob_err_2
 
	oob_err_2: 
	call void @throw_oob()
	br label %oob_ok_2
 
	oob_ok_2: 
	%_36 = add i32 4, 1
	%_37 = getelementptr i8, i8* %_30, i32 %_36
	%_38 = zext i1 0 to i8 
	store i8 %_38, i8* %_37
 

	%_44 = load i8*, i8** %x
	%_45 = bitcast i8* %_44 to i32* 
	%_46 = load i32, i32* %_45
	%_47 = icmp sge i32 0, 0
	%_48 = icmp slt i32 0, %_46
	%_49 = and i1 %_47, %_48
	br i1 %_49, label %oob_ok_3, label %oob_err_3
 
	oob_err_3: 
	call void @throw_oob()
	br label %oob_ok_3
 
	oob_ok_3: 
	%_50 = add i32 4, 0
	%_51 = getelementptr i8, i8* %_44, i32 %_50
	%_52 = load i8, i8* %_51
	%_53= trunc i8 %_52 to i1 

	store i1 %_53,i1* %y

	%_59 = load i8*, i8** %x
	%_60 = bitcast i8* %_59 to i32* 
	%_61 = load i32, i32* %_60
	%_62 = icmp sge i32 1, 0
	%_63 = icmp slt i32 1, %_61
	%_64 = and i1 %_62, %_63
	br i1 %_64, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_65 = add i32 4, 1
	%_66 = getelementptr i8, i8* %_59, i32 %_65
	%_67 = load i8, i8* %_66
	%_68= trunc i8 %_67 to i1 

	store i1 %_68,i1* %z

	%_69 = load i8*, i8** %x
	%_70 = bitcast i8* %_69 to i32* 
	%_71 = load i32, i32* %_70
	%_72 = icmp sge i32 0, 0
	%_73 = icmp slt i32 0, %_71
	%_74 = and i1 %_72, %_73
	br i1 %_74, label %oob_ok_6, label %oob_err_6
 
	oob_err_6: 
	call void @throw_oob()
	br label %oob_ok_6
 
	oob_ok_6: 
	%_75 = add i32 4, 0
	%_76 = getelementptr i8, i8* %_69, i32 %_75
	%_77 = load i8, i8* %_76
	%_78= trunc i8 %_77 to i1 

	br i1 %_78, label %if_then_5, label %if_else_5 
	if_else_5: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_5
	if_then_5: 
	call void (i32) @print_int(i32 69)

	br label %if_end_5
	if_end_5: 

	%_79 = load i1, i1* %y
	br i1 %_79, label %if_then_7, label %if_else_7 
	if_else_7: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_7
	if_then_7: 
	call void (i32) @print_int(i32 69)

	br label %if_end_7
	if_end_7: 

	%_80 = load i8*, i8** %x
	%_81 = bitcast i8* %_80 to i32* 
	%_82 = load i32, i32* %_81
	%_83 = icmp sge i32 1, 0
	%_84 = icmp slt i32 1, %_82
	%_85 = and i1 %_83, %_84
	br i1 %_85, label %oob_ok_9, label %oob_err_9
 
	oob_err_9: 
	call void @throw_oob()
	br label %oob_ok_9
 
	oob_ok_9: 
	%_86 = add i32 4, 1
	%_87 = getelementptr i8, i8* %_80, i32 %_86
	%_88 = load i8, i8* %_87
	%_89= trunc i8 %_88 to i1 

	br i1 %_89, label %if_then_8, label %if_else_8 
	if_else_8: 
	call void (i32) @print_int(i32 420)

	br label %if_end_8
	if_then_8: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_8
	if_end_8: 

	%_90 = load i1, i1* %z
	br i1 %_90, label %if_then_10, label %if_else_10 
	if_else_10: 
	call void (i32) @print_int(i32 420)

	br label %if_end_10
	if_then_10: 
	call void (i32) @print_int(i32 10000)

	br label %if_end_10
	if_end_10: 

	%_91 = load i8*, i8** %x
	%_92 = bitcast i8* %_91 to i32* 
	%_93 = load i32, i32* %_92

	call void (i32) @print_int(i32 %_93)

	ret i32 0
}
 
