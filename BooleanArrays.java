class BooleanArrays {
	public static void main(String[] a) {
	    boolean[] x;
	    boolean y;
	    boolean z;
	    x = new boolean[2];

        x[0] = true;
       	x[1] = false;
	y = x[0];
	z = x[1];

	if(x[0]){
		System.out.println(69);
	}else{
		System.out.println(10000);
	}

	if(y){
		System.out.println(69);
	}else{
		System.out.println(10000);
	}

	if(x[1]){
		System.out.println(10000);
	}else{
		System.out.println(420);
	}

	if(z){
		System.out.println(10000);
	}else{
		System.out.println(420);
	}

	    System.out.println(x.length);
	}
}

//gia new
/*
    %_0 = add i32 1, 2
    %_1 = icmp sge i32 %_0, 1
    br i1 %_1, label %nsz_ok_0, label %nsz_err_0
    nsz_err_0:
    call void @throw_nsz()
    br label %nsz_ok_0
    nsz_ok_0:
    %_2 = call i8* @calloc(i32 %_0, i32 4)
    %_3 = bitcast i8* %_2 to i32*
    store i32 2, i32* %_3 */

/*	%_0 = add i32 1, 2
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %nsz_ok_0, label %nsz_err_0
	nsz_err_0:
	call void @throw_nsz()
	br label %nsz_ok_0
	nsz_ok_0:
	%sth = add 4,2
	%_3 = call i8* @calloc(i32 1, i32 sth) 
	%_4 = bitcast i8* %_3 to i32*
	store i32 2, i32* %_4
	%_5 = bitcast i32* %_4 to i8*

	store i8*  %_5, i8** %_1 */

//array assign
/*
    %_11 = load i32*, i32** %x
    %_12 = load i32, i32* %_11
    %_13 = icmp sge i32 1, 0
    %_14 = icmp slt i32 1, %_12
    %_15 = and i1 %_13, %_14
    br i1 %_15, label %oob_ok_1, label %oob_err_1

    oob_err_1:
    call void @throw_oob()
    br label %oob_ok_1

    oob_ok_1:
    %_16 = add i32 1, 1
    %_17 = getelementptr i32, i32* %_11, i32 %_16

    store i32 2, i32* %_17
	
   an lookup = %ll = load i32, i32* %_17
*/

/*
	%_44 = load i8*, i8** %_1
	%_54 = bitcast i8* %_44 to i32*
	%_66 = load i32, i32* %_54

    %_13 = icmp sge i32 0, 0
    %_14 = icmp slt i32 0, %_66
    %_15 = and i1 %_13, %_14
    br i1 %_15, label %oob_ok_1, label %oob_err_1

    oob_err_1:
    call void @throw_oob()
    br label %oob_ok_1

    oob_ok_1:
    %_16 = add i32 1, 1
    %_17 = getelementptr i8, i8* %_44, i32 %_16

    %Y = zext i1 1 to i8  
    store i8 %Y, i8* %_17

an lookup
	%ll = load i8, i8* %_17
	%ll1 = trunc i8 ll to i1
*/



