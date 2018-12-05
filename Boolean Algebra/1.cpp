
/* Create a function "std::bitset dec2bin(unsigned int)" that takes an unsigned integer as input and 
returns an array of bits. Zeroth index of array of bitset stores the least significant bit of the binary number. 
The function generates each bit of output by division and reminder method. */


#include<iostream>
#include<bitset>
#include<ctime>
#include<cstdlib>
#include<climits>

using namespace std;

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

int main()
{
	 unsigned int num;
	 cout<<"Enter a decimal number: ";
	cin>>num;
	bitset<32> bin32 = dec2bin(num);
	cout<<"Binary Equivalent is: ";
	for(int i=bin32.size()-1;i>=0;i--)
		cout<<bin32.test(i)<<"";
	cout<<endl; 
	
	
}
