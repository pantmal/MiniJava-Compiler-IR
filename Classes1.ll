@.Classes_vtable = global [0 x i8*] [] 
 
@.Base_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @Base.set to i8*),
	i8* bitcast (i32 (i8*)* @Base.get to i8*)
]
 
@.Derived_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*,i32)* @Derived.set to i8*),
	i8* bitcast (i32 (i8*)* @Base.get to i8*)
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
	%b = alloca i8*

	%d = alloca i8*

	%_5 = call i8* @calloc(i32 1, i32 12)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [2 x i8*], [2 x i8*]* @.Base_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	store i8* %_5,i8** %b

	%_13 = call i8* @calloc(i32 1, i32 12)
	%_14 = bitcast i8* %_13 to i8*** 
	%_15 = getelementptr [2 x i8*], [2 x i8*]* @.Derived_vtable, i32 0, i32 0 
	store i8** %_15, i8*** %_14

	store i8* %_13,i8** %d

	%_21 = load i8*, i8** %d
	store i8* %_21,i8** %b

	%_22 = load i8*, i8** %b
	%_26 = bitcast i8* %_22 to i8*** 
	%_27 = load i8**, i8*** %_26 
	%_28 = getelementptr i8*, i8** %_27, i32 0 
	%_29 = load i8*, i8** %_28 
	%_30 = bitcast i8* %_29 to i32 (i8* , i32)* 
	%_31 = call i32 %_30( i8* %_22, i32 1) 

	call void (i32) @print_int(i32 %_31)

	%_32 = load i8*, i8** %b
	%_36 = bitcast i8* %_32 to i8*** 
	%_37 = load i8**, i8*** %_36 
	%_38 = getelementptr i8*, i8** %_37, i32 0 
	%_39 = load i8*, i8** %_38 
	%_40 = bitcast i8* %_39 to i32 (i8* , i32)* 
	%_41 = call i32 %_40( i8* %_32, i32 3) 

	call void (i32) @print_int(i32 %_41)

	ret i32 0
}
 
define i32 @Base.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_42 = getelementptr i8, i8* %this, i32 8
	%_43 = bitcast i8* %_42 to i32* 
	%_49 = load i32, i32* %x
	store i32 %_49,i32* %_43

	%_50 = getelementptr i8, i8* %this, i32 8
	%_51 = bitcast i8* %_50 to i32* 
	%_52 = load i32, i32* %_51
	ret i32 %_52
}
 
define i32 @Base.get(i8* %this) {
	%_53 = getelementptr i8, i8* %this, i32 8
	%_54 = bitcast i8* %_53 to i32* 
	%_55 = load i32, i32* %_54
	ret i32 %_55
}
 
define i32 @Derived.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_56 = getelementptr i8, i8* %this, i32 8
	%_57 = bitcast i8* %_56 to i32* 
	%_61 = load i32, i32* %x
	%_62 = mul i32 %_61, 2

	store i32 %_62,i32* %_57

	%_63 = getelementptr i8, i8* %this, i32 8
	%_64 = bitcast i8* %_63 to i32* 
	%_65 = load i32, i32* %_64
	ret i32 %_65
}
 
