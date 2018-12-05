#include<iostream>
#include<bitset>
#include<ctime>
#include<cstdlib>
using namespace std;

bitset<33> binAdd(bitset<32> b1, bitset<32> b2)
{
	bitset<33> res;
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

bitset<32> dec2bin(unsigned int dec)
{
	bitset<32> bin32;
	int i = 0;
	while(dec!=0)
	{
		if(dec&1)
			bin32.set(i);
		i++;
		dec/=2;			
	}		
	return bin32;
}

unsigned int bin2dec(bitset <33> bin32)
{
	unsigned int num = 0;
	unsigned int pow2 = 1;
	for(int i=0;i<33;i++)
	{
		if(bin32[i] == 1)
			num += pow2;
		pow2 <<= 1;
	}
	return num;
}

int test_binAdd()
{
	int incorrect = 0;
	srand(time(NULL));
	for(int i=0;i<1000;i++)
	{
		unsigned int num1 = rand();
		unsigned int num2 = rand();
		bitset<32> b1 = dec2bin(num1);
		bitset<32> b2 = dec2bin(num2);
		bitset<33> res = binAdd(b1, b2);

		unsigned int sum = num1 + num2;
		unsigned int csum = bin2dec(res);
		// cout<<sum<<" "<<csum<<endl;
		if(sum != csum)
			incorrect++;	 	
	}
	return incorrect;
}

int main()
{
	cout<<"Incorrect :"<<test_binAdd()<<endl;

}