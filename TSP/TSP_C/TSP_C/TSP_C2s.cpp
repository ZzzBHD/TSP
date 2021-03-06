// TSP_C.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h" 
#include <cmath>
#include <iostream>

#define MAX_n 35//最大城镇数
#define sqr(x) ((x) * (x))
using namespace std;

double v[MAX_n][MAX_n];                      //邻接矩阵
int n;                                 //n为城镇个数
double dis, min_dis;
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
	//while (i<n)
	//{
	//	njie = njie * (n - i);
	//	i++;
	//}
	njie = (1 << n)*n*n;
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

double Dist(const int x1, const int y1,const int x2,const int y2)
{
	return sqrt(sqr(x2-x1) + sqr(y2-y1));
}

int main()
{
	//int i, j, e, k;
	int cache[MAX_n][3];
	int num;
	int x, y;
	double s = 0;
	int flag[MAX_n][MAX_n] = { 0 };
	freopen("E:\\多车协作TSP\\TSP\\chn31.txt", "r", stdin);
	cin >> n;
	for (int i = 0; i < n; i++)//储存输入的城市坐标信息
	{
		cin >> num >> x >> y;
		cache[i][0] = num;
		cache[i][1] = x;
		cache[i][2] = y;
	}
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			v[i][j] = Dist(cache[i][1], cache[i][2], cache[j][1], cache[j][2]);
			s += v[i][j];
			flag[i][j] = 1;
		}
	}
	for (int i = 0; i<n; i++)
		for (int j = 0; j<n; j++)
			if (flag[i][j] != 1)
				v[i][j] = s;

	min_dis = s * n;
	tsp1();

	for (int i = 0; i<n; i++)
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