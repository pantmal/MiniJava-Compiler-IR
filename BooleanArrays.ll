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
	%z = zext i1 1 to i8 
	store i8 %z, i8* %_23
 
	%_24 = load i8*, i8** %x
	%_25 = bitcast i8* %_24 to i32* 
	%_26 = load i32, i32* %_25
	call void (i32) @print_int(i32 %_26)
	ret i32 0
}
