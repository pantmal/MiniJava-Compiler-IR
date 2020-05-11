@.MoreThan4_vtable = global [0 x i8*] [] 
@.MT4_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*,i32,i32,i32,i32,i32,i32)* @MT4.Start to i8*),
	i8* bitcast (i32 (i8*,i32,i32,i32,i32,i32,i32)* @MT4.Change to i8*)
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
	%_0 = load i32, i32* %null
	call void (i32) @print_int(i32 %_0)
	ret i32 0
}
define i32 @MT4.Start(i8* %this, i32 %.p1, i32 %.p2, i32 %.p3, i32 %.p4, i32 %.p5, i32 %.p6) {
	%p1 = alloca i32
	store i32 %.p1, i32* %p1
	%p2 = alloca i32
	store i32 %.p2, i32* %p2
	%p3 = alloca i32
	store i32 %.p3, i32* %p3
	%p4 = alloca i32
	store i32 %.p4, i32* %p4
	%p5 = alloca i32
	store i32 %.p5, i32* %p5
	%p6 = alloca i32
	store i32 %.p6, i32* %p6
	%aux = alloca i32
	store i32 0,i32* %aux
	%_1 = load i32, i32* %p1
	call void (i32) @print_int(i32 %_1)
	%_2 = load i32, i32* %p2
	call void (i32) @print_int(i32 %_2)
	%_3 = load i32, i32* %p3
	call void (i32) @print_int(i32 %_3)
	%_4 = load i32, i32* %p4
	call void (i32) @print_int(i32 %_4)
	%_5 = load i32, i32* %p5
	call void (i32) @print_int(i32 %_5)
	%_6 = load i32, i32* %p6
	call void (i32) @print_int(i32 %_6)
	store i32 null,i32* %aux
}
 
define i32 @MT4.Change(i8* %this, i32 %.p1, i32 %.p2, i32 %.p3, i32 %.p4, i32 %.p5, i32 %.p6) {
	%p1 = alloca i32
	store i32 %.p1, i32* %p1
	%p2 = alloca i32
	store i32 %.p2, i32* %p2
	%p3 = alloca i32
	store i32 %.p3, i32* %p3
	%p4 = alloca i32
	store i32 %.p4, i32* %p4
	%p5 = alloca i32
	store i32 %.p5, i32* %p5
	%p6 = alloca i32
	store i32 %.p6, i32* %p6
	%_8 = load i32, i32* %p1
	call void (i32) @print_int(i32 %_8)
	%_9 = load i32, i32* %p2
	call void (i32) @print_int(i32 %_9)
	%_10 = load i32, i32* %p3
	call void (i32) @print_int(i32 %_10)
	%_11 = load i32, i32* %p4
	call void (i32) @print_int(i32 %_11)
	%_12 = load i32, i32* %p5
	call void (i32) @print_int(i32 %_12)
	%_13 = load i32, i32* %p6
	call void (i32) @print_int(i32 %_13)
}
 
