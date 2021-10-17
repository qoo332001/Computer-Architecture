#include<stdio.h>
int maxSubArray(int* nums, int numsSize);
int main(){
    int a[9]={-2,1,-3,4,-1,2,1,-5,4};
    int len1=sizeof(a)/sizeof(int);
    int best,i;
    best=maxSubArray(a,len1);
    printf("best= %d\n",best);
    
}
int maxSubArray(int* nums, int numsSize)
{
    int i;
    int best = 0x80000000;
    int currsum = 0;
	
    for (i = 0; i < numsSize; i++) {
        if(currsum<0){
            currsum =nums[i];     
        }else{
            currsum = currsum + nums[i];
        }
        if(best<currsum)
            best=currsum;
    }
    return best;
}
