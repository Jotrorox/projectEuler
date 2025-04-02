use fmt; 

export fn main() void = {
	let sum = 0z;
	let i = 0z;
	for (i < 1000; i += 1) {
		if (i % 3 == 0 || i % 5 == 0) sum += i;
	};
	fmt::printfln("{}", sum)!;
};