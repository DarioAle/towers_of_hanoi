/*
 * originalHanoiImplementation.cpp
 *
 *  Created on: 13/02/2020
 *      Author: Dario
 */

#include <iostream>
#include <stack>
#include<list>
#include<vector>
#include <stdlib.h>

using namespace std;
typedef unsigned short us16;

us16* matHanoi[3][2] = {
		{0,0},
		{0,0},
		{0,0},

};


us16 aFixed[8] = {0,0,0,0,0,0,0,0};
us16 bFixed[8] = {0,0,0,0,0,0,0,0};
us16 cFixed[8] = {0,0,0,0,0,0,0,0};


us16* aTop;
us16* bTop;
us16* cTop;



unsigned int  globalCounter = 0;

void printStacksReference(string s)
{
	cout << s << endl;
	us16* p = aFixed;
	cout << "Stack  A: " << endl;
	for(int i = 0; i < 8; i++){
		cout << *p << " ";
		p++;
	}
	cout << endl;

	p = bFixed;
	cout << "Stack  B: " << endl;
	for(int i = 0; i < 8; i++){
		cout << *p << " ";
		p++;
	}
	cout << endl;

	p = cFixed;
	cout << "Stack  C: " << endl;
	for(int i = 0; i < 8; i++){
		cout << *p << " ";
		p++;
	}
	cout << endl;
}

void moveDebuggin(int n, us16* A[2] , us16* C[2], us16*  B[2])
{
	// TO DO clear impressions to appreciate recursion
	globalCounter++;
//	cout << "Arriving n: " << 3 - n << " TopSource:" << A[1] << " TopTarget: " << C[1];
	if(n > 0)
	{				//source target    auxiliary
		// Move n - 1 disks from source to auxiliary, so they are out of the way
//		cout <<"\n n: " << 3 - n << " Move1| Source: " << A[0] << " Auxiliary: " << C[0] << " Target: " << B[0] << endl;
		moveDebuggin(n - 1, A, B, C );
		//  # Move the nth disk from source to target of this call

//		cout << "\n ->About to move n: " << 3 - n << " TopSource:" << A[1] << " TopTarget " << C[1];

		// Read from source, in this case A
		us16 topValueA = *A[1];
		*A[1] = 0;
		A[1]--;
//		A[1] = ((A[1] - 1) < A[0]) ?  A[0] : (A[1] - 1);

		// Write to target, in this case C
		C[1]++;
		*C[1] = topValueA;

//		cout <<"\n n: " << 3 - n << " Move2| Source: " << B[0] << " Auxiliary: " << A[0] << " Target: " << C[0] << endl;
		printStacksReference(" ------------");
		// Move the n - 1 disks that we left on auxiliary onto target
		moveDebuggin(n - 1, B, C, A);
	}
}

void move(int n, us16* A[2] , us16* C[2], us16*  B[2])
{
	if(n == 1) {
		us16 topValueA = *A[1];
		*A[1] = 0;
		A[1]--;

		// Write to target, in this case C
		C[1]++;
		*C[1] = topValueA;
	}else {
		// Move n - 1 disks from source to auxiliary, so they are out of the way
		move(n - 1, A, B, C );
		//  # Move the nth disk from source to target of this call
		// Read from source, in this case A
		us16 topValueA = *A[1];
		*A[1] = 0;
		A[1]--;

		// Write to target, in this case C
		C[1]++;
		*C[1] = topValueA;

		printStacksReference(" ------------");
		// Move the n - 1 disks that we left on auxiliary onto target
		move(n - 1, B, C, A);
	}
}

int main()
{
	const unsigned short disks = 3;
	matHanoi[0][0] = aFixed;
	matHanoi[1][0] = bFixed;
	matHanoi[2][0] = cFixed;

	matHanoi[0][1] = aFixed - 1;
	matHanoi[1][1] = bFixed - 1;
	matHanoi[2][1] = cFixed - 1;


	for(us16 i = 0; i < disks; i++)
	{
		matHanoi[0][1]++;
		*(matHanoi[0][1]) = (disks - i);
	}
//	matHanoi[0][1]--;

	printStacksReference("========Initial State=========");
	move(disks, matHanoi[0], matHanoi[2], matHanoi[1]);
	printStacksReference("\n=========Result=======");

	cout << "\nTotal calls to move: " << globalCounter << endl;

	return 0;
}


