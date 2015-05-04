#define ROWS 576
#define COLS 720

__kernel
__attribute__((task))
void dilation(__global uchar* restrict img_in, __global uchar* restrict img_out, const unsigned int iterations)
{
    unsigned int count = 0;

    while(count != iterations)
    {	
		bool isMax = 0;
		if ( count > 2 * COLS + 17)
		{
			#pragma unroll
			for (int i = 0; i < 3 ; ++i)
			{
				#pragma unroll
				for (int j = 0; j < 17; ++j)
				{
					uchar pixel = img_in[ i * COLS + j + count ];
					if (pixel == 255)
					{
						isMax = 1;
					}else if (isMax != 1)
					{
						isMax = 0;
					}
				}
			}
			uchar temp = 0;
			if (isMax)
			{
				temp = 255;
			}else
			{
				temp = 0;
			}
			img_out[count++] = temp;
		}else
		{
			img_out[count++] = 0;
		}
	}
}


