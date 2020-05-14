@.Main_vtable = global [0 x i8*] [] 
 
@.ArrayTest_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @ArrayTest.test to i8*)
]
 
@.B_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @B.test to i8*)
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
	%ab = alloca i8*
	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.ArrayTest_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	store i8* %_0,i8** %ab

	%_3 = load i8*, i8** %ab
	%_7 = bitcast i8* %_3 to i8*** 
	%_8 = load i8**, i8*** %_7 
	%_9 = getelementptr i8*, i8** %_8, i32 0 
	%_10 = load i8*, i8** %_9 
	%_11 = bitcast i8* %_10 to i32 (i8* , i32)* 
	%_12 = call i32 %_11( i8* %_3, i32 3) 

	call void (i32) @print_int(i32 %_12)

	ret i32 0
}
 
define i32 @ArrayTest.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32
	%intArray = alloca i32*
	%_13 = load i32, i32* %num
	%_14 = add i32 1, %_13
	%_15 = icmp sge i32 %_14, 1
	br i1 %_15, label %nsz_ok_0, label %nsz_err_0
 
	nsz_err_0: 
	call void @throw_nsz()
	br label %nsz_ok_0
 
	nsz_ok_0: 
	%_16 = call i8* @calloc(i32 %_14, i32 4) 
	%_17 = bitcast i8* %_16 to i32* 
	store i32 %_13, i32* %_17
 

	store i32* %_17,i32** %intArray

	%_18 = getelementptr i8, i8* %this, i32 16
	%_19 = bitcast i8* %_18 to i32* 
	store i32 0,i32* %_19

	%_20 = getelementptr i8, i8* %this, i32 16
	%_21 = bitcast i8* %_20 to i32* 
	%_22 = load i32, i32* %_21
	call void (i32) @print_int(i32 %_22)

	%_23 = load i32*, i32** %intArray
	%_24 = load i32, i32* %_23

	call void (i32) @print_int(i32 %_24)

	store i32 0,i32* %i

	call void (i32) @print_int(i32 111)

	br label %loop1
	loop1: 
	%_25 = load i32, i32* %i
	%_26 = load i32*, i32** %intArray
	%_27 = load i32, i32* %_26

	%_28 = icmp slt i32 %_25, %_27

	br i1 %_28, label %loop2, label %loop3 
	loop2: 
	%_29 = load i32, i32* %i
	%_30 = add i32 %_29, 1

	call void (i32) @print_int(i32 %_30)

	%_31 = load i32, i32* %i
	%_32 = load i32, i32* %i
	%_33 = add i32 %_32, 1

	%_34 = load i32*, i32** %intArray
	%_35 = load i32, i32* %_34
	%_36 = icmp sge i32 %_31, 0
	%_37 = icmp slt i32 %_31, %_35
	%_38 = and i1 %_36, %_37
	br i1 %_38, label %oob_ok_4, label %oob_err_4
 
	oob_err_4: 
	call void @throw_oob()
	br label %oob_ok_4
 
	oob_ok_4: 
	%_39 = add i32 1, %_31
	%_40 = getelementptr i32, i32* %_34, i32 %_39
	store i32 %_33, i32* %_40
 

	%_41 = load i32, i32* %i
	%_42 = add i32 %_41, 1

	store i32 %_42,i32* %i

	br label %loop1
	loop3: 

	call void (i32) @print_int(i32 222)

	store i32 0,i32* %i

	br label %loop5
	loop5: 
	%_43 = load i32, i32* %i
	%_44 = load i32*, i32** %intArray
	%_45 = load i32, i32* %_44

	%_46 = icmp slt i32 %_43, %_45

	br i1 %_46, label %loop6, label %loop7 
	loop6: 
	%_47 = load i32*, i32** %intArray
	%_48 = load i32, i32* %i
	%_49 = load i32, i32* %_47
	%_50 = icmp sge i32 %_48, 0
	%_51 = icmp slt i32 %_48, %_49
	%_52 = and i1 %_50, %_51
	br i1 %_52, label %oob_ok_8, label %oob_err_8
 
	oob_err_8: 
	call void @throw_oob()
	br label %oob_ok_8
 
	oob_ok_8: 
	%_53 = add i32 1, %_48
	%_54 = getelementptr i32, i32* %_47, i32 %_53
	%_55 = load i32, i32* %_54

	call void (i32) @print_int(i32 %_55)

	%_56 = load i32, i32* %i
	%_57 = add i32 %_56, 1

	store i32 %_57,i32* %i

	br label %loop5
	loop7: 

	call void (i32) @print_int(i32 333)

	%_58 = load i32*, i32** %intArray
	%_59 = load i32, i32* %_58

	ret i32 %_59
}
 
define i32 @B.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32
	%intArray = alloca i32*
	%_60 = load i32, i32* %num
	%_61 = add i32 1, %_60
	%_62 = icmp sge i32 %_61, 1
	br i1 %_62, label %nsz_ok_9, label %nsz_err_9
 
	nsz_err_9: 
	call void @throw_nsz()
	br label %nsz_ok_9
 
	nsz_ok_9: 
	%_63 = call i8* @calloc(i32 %_61, i32 4) 
	%_64 = bitcast i8* %_63 to i32* 
	store i32 %_60, i32* %_64
 

	store i32* %_64,i32** %intArray

	%_65 = getelementptr i8, i8* %this, i32 20
	%_66 = bitcast i8* %_65 to i32* 
	store i32 12,i32* %_66

	%_67 = getelementptr i8, i8* %this, i32 20
	%_68 = bitcast i8* %_67 to i32* 
	%_69 = load i32, i32* %_68
	call void (i32) @print_int(i32 %_69)

	%_70 = load i32*, i32** %intArray
	%_71 = load i32, i32* %_70

	call void (i32) @print_int(i32 %_71)

	store i32 0,i32* %i

	call void (i32) @print_int(i32 111)

	br label %loop10
	loop10: 
	%_72 = load i32, i32* %i
	%_73 = load i32*, i32** %intArray
	%_74 = load i32, i32* %_73

	%_75 = icmp slt i32 %_72, %_74

	br i1 %_75, label %loop11, label %loop12 
	loop11: 
	%_76 = load i32, i32* %i
	%_77 = add i32 %_76, 1

	call void (i32) @print_int(i32 %_77)

	%_78 = load i32, i32* %i
	%_79 = load i32, i32* %i
	%_80 = add i32 %_79, 1

	%_81 = load i32*, i32** %intArray
	%_82 = load i32, i32* %_81
	%_83 = icmp sge i32 %_78, 0
	%_84 = icmp slt i32 %_78, %_82
	%_85 = and i1 %_83, %_84
	br i1 %_85, label %oob_ok_13, label %oob_err_13
 
	oob_err_13: 
	call void @throw_oob()
	br label %oob_ok_13
 
	oob_ok_13: 
	%_86 = add i32 1, %_78
	%_87 = getelementptr i32, i32* %_81, i32 %_86
	store i32 %_80, i32* %_87
 

	%_88 = load i32, i32* %i
	%_89 = add i32 %_88, 1

	store i32 %_89,i32* %i

	br label %loop10
	loop12: 

	call void (i32) @print_int(i32 222)

	store i32 0,i32* %i

	br label %loop14
	loop14: 
	%_90 = load i32, i32* %i
	%_91 = load i32*, i32** %intArray
	%_92 = load i32, i32* %_91

	%_93 = icmp slt i32 %_90, %_92

	br i1 %_93, label %loop15, label %loop16 
	loop15: 
	%_94 = load i32*, i32** %intArray
	%_95 = load i32, i32* %i
	%_96 = load i32, i32* %_94
	%_97 = icmp sge i32 %_95, 0
	%_98 = icmp slt i32 %_95, %_96
	%_99 = and i1 %_97, %_98
	br i1 %_99, label %oob_ok_17, label %oob_err_17
 
	oob_err_17: 
	call void @throw_oob()
	br label %oob_ok_17
 
	oob_ok_17: 
	%_100 = add i32 1, %_95
	%_101 = getelementptr i32, i32* %_94, i32 %_100
	%_102 = load i32, i32* %_101

	call void (i32) @print_int(i32 %_102)

	%_103 = load i32, i32* %i
	%_104 = add i32 %_103, 1

	store i32 %_104,i32* %i

	br label %loop14
	loop16: 

	call void (i32) @print_int(i32 333)

	%_105 = load i32*, i32** %intArray
	%_106 = load i32, i32* %_105

	ret i32 %_106
}
 
