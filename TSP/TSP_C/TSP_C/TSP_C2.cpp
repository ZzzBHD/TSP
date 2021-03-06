// TSP_C.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>

#define MAX_n 20

using namespace std;

int v[MAX_n][MAX_n];                      //邻接矩阵
int n;                                 //n为城镇个数
int dis, min_dis;
int route[MAX_n], min_route[MAX_n]; //存储当前路线和最短路线

void search(long serial_num)
{
	int i, temp;
	int swap[MAX_n];                        //存放该序号(serial_num)需要做的交换动作
	for (i = 0; i<n; i++)    //建造一个有n!种的数组以适应交换	     
	{
		swap[i] = serial_num % (n - i);
		serial_num -= swap[i];
		serial_num /= (n - i);
	}

	for (i = 0; i<n; i++)
		route[i] = i;
	route[n] = route[0];

	for (i = 0; i<n; i++) //利用swap数组,将route的第i个元素与第(i+swap[i])个元素进行交换  
	{
		temp = route[i];
		route[i] = route[i + swap[i]];
		route[i + swap[i]] = temp;
	}
	route[n] = route[0];
}

void tsp1()
{
	int i, j, k;
	long njie;
	i = 0;    njie = 1;
	while (i<n)
	{
		njie = njie * (n - i);
		i++;
	}
	//开始探索所有路线，并记录最短路线 
	while (njie >= 0)
	{
		njie--;
		search(njie);
		dis = 0;
		for (j = 0; j<n; j++)
			dis += v[route[j]][route[j + 1]];
		if (dis<min_dis)
		{
			min_dis = dis;
			for (k = 0; k<n + 1; k++)
				min_route[k] = route[k];
		}
	}
}

int main()
{
	int i, j, e, k;
	int weight, s = 0;
	int flag[MAX_n][MAX_n] = { 0 };
	freopen("E:\\多车协作TSP\\TSP\\in2.txt", "r", stdin);
	cin >> n >> e;
	for (i = 1; i <= e; i++)
	{
		cin >> j >> k >> weight;
		s += weight;
		v[j][k] = weight;
		flag[j][k] = 1;
	}
	for (i = 0; i<n; i++)
		for (j = 0; j<n; j++)
			if (flag[i][j] != 1)
				v[i][j] = s;

	min_dis = s * n;
	tsp1();

	for (i = 0; i<n; i++)
		cout << min_route[i] + 1 << "->";
	cout << min_route[n] + 1 << endl;
	cout << "And this dis is : " << min_dis << endl;
	/*for (i = 0; i<n; i++)
	{
		for (j = 0; j<n; j++)
		{
			if (i == j)
			{
				cout << "0" << "\t";
			}
			else
			{
				cout << v[i][j] << "\t";
			}
		}
		cout << endl;
	}*/
	fclose(stdin);
	return 0;
}