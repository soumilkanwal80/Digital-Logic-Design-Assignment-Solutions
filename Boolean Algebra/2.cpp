/* Create a function “unsigned int bin2dec(std::bitset &)” that converts array of bits into unsigned integer. Do not use std::bitset::to_ulong() but create your own function. */

#include<iostream>
#include<bitset>
using namespace std;

void rev(string &s, int i, int j)
{
	if(i>j)
		return ;

	swap(s[i], s[j]);
	rev(s, i+1, j-1);


}

unsigned int bin2dec(bitset <32> bin32)
{
	unsigned int num = 0;
	unsigned int pow2 = 1;
	for(int i=0;i<32;i++)
	{
		if(bin32[i] == 1)
			num += pow2;
		pow2 <<= 1;
	}
	return num;
}

int main()
{
	cout<<"Enter a string of binary numbers: ";
	string s;
	cin>>s;
	rev(s, 0, s.length()-1);
	bitset<32> bin32;
	for(int i=0;i<s.size();i++)
	{
		if(s[i] == '1')
			bin32[i] = 1;

	}
	cout<<"Decimal Equivalent is: "<<bin2dec(bin32)<<endl; 
}
























