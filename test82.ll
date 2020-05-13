@.test82_vtable = global [0 x i8*] [] 
 
@.Test_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i1 (i8*)* @Test.next to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 17)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
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
 
define i32 @Test.start(i8* %this) {
	%_12 = getelementptr i8, i8* %this, i32 8
	%_13 = bitcast i8* %_12 to i8** 
	%_19 = call i8* @calloc(i32 1, i32 17)
	%_20 = bitcast i8* %_19 to i8*** 
	%_21 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_21, i8*** %_20

	store i8* %_19,i8** %_13

	%_22 = getelementptr i8, i8* %this, i32 16
	%_23 = bitcast i8* %_22 to i1* 
	%_29 = getelementptr i8, i8* %this, i32 8
	%_30 = bitcast i8* %_29 to i8** 
	%_31 = load i8*, i8** %_30
	%_35 = bitcast i8* %_31 to i8*** 
	%_36 = load i8**, i8*** %_35 
	%_37 = getelementptr i8*, i8** %_36, i32 1 
	%_38 = load i8*, i8** %_37 
	%_39 = bitcast i8* %_38 to i1 (i8* )* 
	%_40 = call i1 %_39( i8* %_31) 

	store i1 %_40,i1* %_23

	ret i32 0
}
 
define i1 @Test.next(i8* %this) {
	%b2 = alloca i1

	br i1 1, label %and_clause5, label %and_clause4 
	and_clause4: 
	br label %and_clause6
	and_clause5: 
	%_46 = icmp slt i32 7, 8

	br label %and_clause6
	and_clause6: 
	br label %and_clause7
	and_clause7: 
	%_47 = phi i1 [ 0, %and_clause4 ], [ %_46, %and_clause6] 

	br i1 %_47, label %and_clause1, label %and_clause0 
	and_clause0: 
	br label %and_clause2
	and_clause1: 
	%_48 = getelementptr i8, i8* %this, i32 16
	%_49 = bitcast i8* %_48 to i1* 
	%_50 = load i1, i1* %_49
%_51 = xor i1 1, %_50

	br label %and_clause2
	and_clause2: 
	br label %and_clause3
	and_clause3: 
	%_52 = phi i1 [ 0, %and_clause0 ], [ %_51, %and_clause2] 

	store i1 %_52,i1* %b2

	%_53 = load i1, i1* %b2
	ret i1 %_53
}
 
