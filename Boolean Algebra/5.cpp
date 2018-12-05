#include<iostream>
#include<bitset>
#include<cstdlib>
#include<ctime>
using namespace std;

bitset<32> binSubBorrow(bitset<32> b1, bitset<32> b2)
{
	bitset<32> res;
	bool borrow = 0;
	for(int i=0;i<32;i++)
	{
		res[i] = (b1[i] ^ b2[i]) ^ borrow;
		borrow = (~b1[i]&borrow) | (~b1[i]&b2[i]) | (b2[i]&borrow);
	}
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
		bitset<32> res = binSubBorrow(num1, num2);
		int ans = res.to_ulong();
		if(num1-num2 != ans)
			incorrect++;
	}

	cout<<"No of incorrect subtractions are: "<<incorrect<<endl;
}
