function eContinuedFractionTerms(n) {
    const terms = [2];
    for (let i = 1; i < n; i++) {
        if (i % 3 === 2) {
            const k = Math.floor(i / 3) + 1;
            terms.push(2 * k);
        } else {
            terms.push(1);
        }
    }
    return terms;
}

function computeConvergent(terms) {
    let p_prevprev = 1n;
    let p_prev = BigInt(terms[0]);
    let q_prevprev = 0n;
    let q_prev = 1n;
    let p, q;

    for (let i = 1; i < terms.length; i++) {
        const a = BigInt(terms[i]);
        p = a * p_prev + p_prevprev;
        q = a * q_prev + q_prevprev;
        p_prevprev = p_prev;
        p_prev = p;
        q_prevprev = q_prev;
        q_prev = q;
    }
    return { numerator: p, denominator: q };
}

function sumDigits(n) {
    return n.toString().split('')
        .reduce((acc, d) => acc + Number(d), 0);
}

const numTerms = 100;
const terms = eContinuedFractionTerms(numTerms);
const convergent = computeConvergent(terms);
const result = sumDigits(convergent.numerator);
console.log(result);