const numberToWords = (num) => {
    const ones = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
    const teens = ["", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"];
    const tens = ["", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];

    if (num === 1000) return "one thousand";

    let words = "";
    if (Math.floor(num / 100) > 0) {
        words += ones[Math.floor(num / 100)] + " hundred";
        if (num % 100 !== 0) words += " and ";
    }

    num %= 100;
    if (num >= 11 && num <= 19) {
        words += teens[num - 10];
    } else {
        if (Math.floor(num / 10) > 0) words += tens[Math.floor(num / 10)];
        if (num % 10 > 0) words += " " + ones[num % 10];
    }

    return words.trim();
};

const countLetters = (text) => text.replace(/[^a-z]/gi, "").length;

let totalLetters = 0;
for (let i = 1; i <= 1000; i++) {
    totalLetters += countLetters(numberToWords(i));
}

console.log(totalLetters);
