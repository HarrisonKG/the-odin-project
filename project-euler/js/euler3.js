// 3. The prime factors of 13195 are 5, 7, 13 and 29.
//What is the largest prime factor of the number 600851475143 ?
//solve for numbers smaller than 1000

function prob3( input ){
    
primeArray = [];

for (i=2; i<1000; i++) {
    if(input%i === 0) {
        primeArray.push(i);
        input = input/i;
        i--;
    }
}

var largestPrime = primeArray[primeArray.length-1];
    solution3.innerHTML = largestPrime;
}