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
