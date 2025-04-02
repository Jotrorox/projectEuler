use fmt; 

export fn main() void = {
	let sum = 0z;
	let a = 0z;
	let b = 1z;

	for (true) {
        if (b > 4000000) {
            break;
        };
        
        if (b % 2 == 0) {
            sum += b;
        };

        let temp = b;
        b = b + a;
        a = temp;
	};
	fmt::printfln("{}", sum)!;
};