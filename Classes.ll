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
	call void (i32) @print_int(i32 1)
	%_21 = load i8*, i8** %d
	store i8* %_21,i8** %b
	call void (i32) @print_int(i32 3)
	ret i32 0
}
define i32 @Base.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_22 = getelementptr i8, i8* %this, i32 8
	%_23 = bitcast i8* %_22 to i32* 
	%_29 = load i32, i32* %x
	store i32 %_29,i32* %_23
	%_30 = getelementptr i8, i8* %this, i32 8
	%_31 = bitcast i8* %_30 to i32* 
	%_32 = load i32, i32* %_31
	ret i32 %_32
}
 
define i32 @Base.get(i8* %this) {
	%_33 = getelementptr i8, i8* %this, i32 8
	%_34 = bitcast i8* %_33 to i32* 
	%_35 = load i32, i32* %_34
	ret i32 %_35
}
 
define i32 @Derived.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_36 = getelementptr i8, i8* %this, i32 8
	%_37 = bitcast i8* %_36 to i32* 
	%_41 = load i32, i32* %x
	%_42 = mul i32 %_41, 2
	store i32 %_42,i32* %_37
	%_43 = getelementptr i8, i8* %this, i32 8
	%_44 = bitcast i8* %_43 to i32* 
	%_45 = load i32, i32* %_44
	ret i32 %_45
}
 
