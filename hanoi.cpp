///*
// * hanoi.c
// *
// *  Created on: 08/02/2020
// *      Author: Dario
// */
//
//#include <iostream>
//#include <stack>
//#include<list>
//#include<vector>
//#include <stdlib.h>
//
//using namespace std;
//typedef  unsigned short us16;
//
//list<int> a, b,c;
//int globalCounter = 0;
//
//
//
//us16 *aPeg = (us16*) calloc( 8 , sizeof(us16));
//us16 *aTemp = aPeg;
//us16* pTemp = aPeg;
//
//us16 *bPeg = (us16*) calloc( 8 , sizeof(us16));
//us16 *bTemp = bPeg;
//
//us16 *cPeg = (us16*) calloc( 8 , sizeof(us16));
//us16 *cTemp = cPeg;
//us16  GlobalDisks = 0;
//
//us16** pArr = (us16**) calloc(3, sizeof(us16*));
//
//
//
//
//void printStacksReference()
//{
//	us16* p = aTemp;
//	cout << "Stack  A: " << endl;
//	for(int i = 0; i < 8; i++){
//		cout << *p << " ";
//		p++;
//	}
//	cout << endl;
//
//	p = bTemp;
//	cout << "Stack  B: " << endl;
//	for(int i = 0; i < 8; i++){
//		cout << *p << " ";
//		p++;
//	}
//	cout << endl;
//
//	p = cTemp;
//	cout << "Stack  C: " << endl;
//	for(int i = 0; i < 8; i++){
//		cout << *p << " ";
//		p++;
//	}
//	cout << endl;
//}
//
//void hanoiBinaryRecursivePointer(us16 n, us16* a, us16* b, us16* c)
//{
//	if(n < (1 << GlobalDisks)){
//		us16 temp = n - 1;
//		us16 from = (n & temp);
//		from = from % 3;
//		us16 to = (n | temp);
//		to = to + 1;
//		to = to % 3;
//
//		pTemp = *(pArr + from);
//		us16 temp2 = (*pTemp);
//		(*pTemp) = 0;
//		pTemp = (pTemp - 1);
//
//		pTemp = *(pArr + to);
//		(*pTemp) = temp2;
//		pTemp = (pTemp + 1);
//
//		hanoiBinaryRecursivePointer(n + 1,  a, b, c);
//	}
//}
//
//us16 mod3( us16 a ) {
//    a = (a >> 16) + (a & 0xFFFF); /* sum base 2**16 digits
//                                        a <= 0x1FFFE */
//    a = (a >>  8) + (a & 0xFF);   /* sum base 2**8 digits
//                                        a <= 0x2FD */
//    a = (a >>  4) + (a & 0xF);    /* sum base 2**4 digits
//                                        a <= 0x3C; worst case 0x3B */
//    a = (a >>  2) + (a & 0x3);    /* sum base 2**2 digits
//                                        a <= 0x1D; worst case 0x1B */
//    a = (a >>  2) + (a & 0x3);    /* sum base 2**2 digits
//                                        a <= 0x9; worst case 0x7 */
//    if (a > 2) a = a - 3;
//    return a;
//}
//
//void printStack(list<int> s, string name)
//{
//	int size = s.size();
//	cout << "Stack  " << name << ": " << endl;
//	for(int i = 0; i < size; i++){
//		cout << s.back() << " ";
//		s.pop_back();
//	}
//	cout << endl;
//
//}
//
//void printStacks()
//{
//	printStack(a, "A");
//	printStack(b, "B");
//	printStack(c, "C");
//}
//
//void hanoiBinRecursive(int count, int n, vector<list<int>* > &tw)
//{
//	if(count < (1 << n)){
//		us16 from = (count & (count - 1)) % 3;
//		us16 to = ((count | (count - 1)) + 1) % 3;
//		tw[to]->push_front(tw[from]->front());
//		tw[from]->pop_front();
//		hanoiBinRecursive(count + 1, n,  tw);
//	}
//}
//
//void hanoiBinary(int n, vector<list<int>* > &tw)
//{
//	if(n % 2 == 0 ){
//		list<int> * temp;
//		temp = tw[1];
//		tw[1] = tw[2];
//		tw[2] = temp;
//	}
//
//	for(us16 m = 1; m < 1 << n; m++)
//	{
//		us16 from = (m & (m - 1)) % 3;
//		us16 to = ((m | (m - 1)) + 1) % 3;
//		tw[to]->push_front(tw[from]->front());
//		tw[from]->pop_front();
//	}
//
//}
//
//int printTipoMovimiento(int src, int dest){
//	int m[3][3] = {{-1,1,2}, {3,-1,4}, {5,6,-1}};
//
//	return m[src][dest];
//}
//
//int main1()
//{
//	// TO DO precalculate all modulos of 3 before
//	// Accessing them
//	for(us16 i = 1; i <= 31; i++)
//	{
//		us16 from = (i & (i - 1)) % 3;
//		us16 to = ((i | (i - 1)) + 1) % 3;
//		cout << "from: " << from << " to: " << to <<endl;
////		cout << "Tipo de movimiento: " << printTipoMovimiento(from, to) << endl;
//		cout << i << "%3=" << i % 3 << " remin=" << (to) % 3 << endl;
//		cout << endl;
//	}
//
//	return 0;
//}
//
//int mai2()
//{
//	pArr[0] = aPeg;
//	pArr[1] = bPeg;
//	pArr[2] = cPeg;
//	GlobalDisks = 8;
//
//
//	for(us16 i = GlobalDisks; i > 0; i--)
//	{
//		*aPeg = i;
//		aPeg++;
//	}
//	aPeg--;
//
//	hanoiBinaryRecursivePointer(GlobalDisks, aPeg, bPeg, cPeg);
//
//	cout << "=========== Final Result =========" << endl;
//
//	printStacksReference();
//
//	return 0;
//}
