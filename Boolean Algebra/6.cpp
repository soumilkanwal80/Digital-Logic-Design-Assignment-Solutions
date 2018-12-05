/* Create a function “std::bitset binSub2c(std::bitset&, std::bitset&) that subtracts two binary numbers 
using 2’s compliment method. Test this function on random numbers by comparing with the output of integer 
subtraction*/

#include<iostream>
#include<bitset>
#include<cstdlib>
#include<ctime>
#include<climits>
using namespace std;

bitset<32> binAdd(bitset<32> b1, bitset<32> b2)
{
	bitset<32> res;
	bool carry = 0;
	for(int i=0;i<32;i++)
	{
		res[i] = b1[i]^b2[i]^carry;
		carry = (b1[i] & b2[i]) | (b1[i] & carry) | (b2[i] & carry);
	}
	if(carry&1)
		res[32] = 1;
	return res;
}

bitset<32> binSub2c(bitset<32> b1, bitset<32> b2)
{
	b2 = binAdd(~b2, 1);		//Calculating 2's complement of b1
	bitset<32> res = binAdd(b1, b2);
	return res;
	

}

int main()
{	
	int incorrect = 0;
	srand(time(NULL));
	for(int i=0;i<1000;i++)
	{	
		int num1 = rand();
		int num2 = rand();
		bitset<32> bin_num1 = num1;
		bitset<32> bin_num2 = num2;
		bitset<32> res = binSub2c(bin_num1, bin_num2);
		int ans = res.to_ulong();
		if(num1-num2 != ans)
			incorrect++;
	}

	cout<<"Incorrect: "<<incorrect<<endl;
	
}
