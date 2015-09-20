/* 


  Compute the pdf of a MultiVariate Gaussian Mixture


  Usage:    pdf = pdf_mvgm(x , mu , sigma , p);
  ------

  Inputs 
  ------
     x        Support vector (d x N x [v1] , ... , [vp]) 
     mu       Mean vector (d x 1 x M x [n1] , ... , [nl]) 
     sigma    Covariance  (d x d x M x [n1] , ... , [nl]) 
	 p        Weights vector (1 x 1 x M x [n1] , ... , [nl])

  Outputs
  -------

     pdf    : (1 x N x v1 x ... x vp x n1 x ... x nl)

 		  
 Example
 -------
			
 mu          = cat(3 , [0.6 ; 6] , [1 ; -10] ,[10 ; -1] , [ 0 ; 10] , [1 ; -3] , [5 ; 5]);            %(d x 1 x M)
 sigma       = corr2cov(cat(3 , [1 0.9 ; 0.9 1] , [1 -0.9 ; -0.9 1] , [2 0 ; 0 2] , [2 0 ; 0 2] , [2 0 ; 0 2] , [2 0 ; 0 2]  )); %(d x d x M)
 p           = cat(3 , [0.1] , [0.1]  , [0.2] , [0.2] , [0.2] , [0.2] );                       %(1 x 1 x M)
 N           = 1000;
 [Z , index] = sample_mvgm(N , mu , sigma , p);
 support     = (-15:0.3:15);
 [X , Y]     = meshgrid(support);
 grid        = [X(:) , Y(:)]';
 % pdf         = pdf_mvgm(grid , mu(:,:,:,ones(1,3)) , sigma(:,:,:,ones(1,3)) , p(:,:,:,ones(1,3)));
 pdf         = pdf_mvgm(grid , mu , sigma , p);
 pdf_Z       = pdf_mvgm(Z , mu , sigma , p);
 ZZ          = griddata(Z(1 , :) , Z(2 , :) , pdf_Z , X(:) , Y(:));


 figure(1)

 h           = surfc(X , Y , reshape(pdf , length(support) , length(support)));
 hold on
 stem3(Z(1 , :) , Z(2 , :) , pdf_Z);
 alpha(h , 0.7);
 hold off
 shading interp
 lighting phong
 light

 figure(2)

 surfc(X , Y , reshape(ZZ , length(support) , length(support)) )
 hold on
 stem3(Z(1 , :) , Z(2 , :) , pdf_Z);
 alpha(h , 0.7);
 hold off
 shading interp
 lighting phong
 light				
  
  To compile
  ----------
  
  mex  pdf_mvgm.c

  or myself, I use Intel CPP compiler as : 

  mex  -f mexopts_intel10.bat pdf_mvgm.c

  Ver 1.2 (01/19/09)

  Author : Sébastien PARIS (sebastien.paris@lsis.org) 
  -------
 				  
*/


#include <math.h>
#include "mex.h"

#define NUMERICS_FLOAT_MIN 1.0E-37
#define M_PI 3.14159265358979323846


/*--------------------------------------------------------------- */

double gauss(double *, double * , int , int);
void lubksb(double *, int , int *, double *);
int ludcmp(double *, int , int *, double * , double *);
double inv(double * , double * , double * , double * , int * , int );
void pdf_mvgm(double * , double * , double * , double * , int , int , int , int , int , double * , double * , double * , double * , double * , double * , double * , int * , double *);

/*--------------------------------------------------------------- */
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] )
{	
	double *x , *mu , *sigma , *p;
	double *pdf;
	const int  *dimsmu , *dimssigma , *dimsp , *dimsx;
	int  *dimspdf , *indx;
	double *vect , *vv , *invsigma  , *temp_sigma , *temp_invsigma , *det_sigma , *res;
	int  numdimsmu , numdimssigma  , numdimsp , numdimsx;
	int  numdimspdf;
	int  i , d , d2 , N , M=1 , K = 1, V=1, ctedimsmu = 2;
		
	/* Check input */
	
	if(nrhs < 4)	
	{     
		mexErrMsgTxt("At least 3 inputs argument are required for pdf_mvgm");	
	}
	
	/* Input 1 */
	
	x               = mxGetPr(prhs[0]);
	numdimsx        = mxGetNumberOfDimensions(prhs[0]);
	dimsx           = mxGetDimensions(prhs[0]);
	
	N               = dimsx[1];
	for (i = 2 ; i<numdimsx ; i++)
	{
		V          *= dimsx[i];	
	}
	
	/* Input 2 */
		
	mu                 = mxGetPr(prhs[1]);
	numdimsmu          = mxGetNumberOfDimensions(prhs[1]);
	dimsmu             = mxGetDimensions(prhs[1]);
	if ( (numdimsmu >3) && (dimsmu[1] != 1))
	{
		mexErrMsgTxt("mu must be (d x 1 x M)");	
	}
	
	d                  = dimsmu[0];
	if(numdimsmu > 2)
	{
		M              = dimsmu[2];
		ctedimsmu      = 3;
	}
	for(i = 3 ; i < numdimsmu ; i++)	
	{
		K              *= dimsmu[i];	
	}
	d2                  = d*d;
	
	/* Input 3 */
	
	sigma               = mxGetPr(prhs[2]);
	numdimssigma        = mxGetNumberOfDimensions(prhs[2]);
	dimssigma           = mxGetDimensions(prhs[2]);
	
	if (  (dimssigma[0] != d) && (dimssigma[1] != d) && (dimssigma[2] != M))
	{
		mexErrMsgTxt("p must be (1 x 1 x M x n1 x ... x nL)");	
	}
	
	/* Input 4 */
	
	p                   = mxGetPr(prhs[3]);
	numdimsp            = mxGetNumberOfDimensions(prhs[3]);
	dimsp               = mxGetDimensions(prhs[3]);
	if ( (dimsp[0] != 1) && (dimsp[1] != 1) && (dimsp[2] != M))
		
	{
		mexErrMsgTxt("p must be (1 x 1 x M)");	
	}
	
	/* Output 1 */
	
	numdimspdf         = 2 + (numdimsmu - ctedimsmu) + (numdimsx - 2);	
	dimspdf            = (int *)malloc(numdimspdf*sizeof(int));
	dimspdf[0]         = 1;
	dimspdf[1]         = N;
		
	for (i = 2 ; i < numdimsx ; i++)	
	{
        dimspdf[i] = dimsx[i] ;
	}
	for(i = 3 ; i < numdimsmu  ; i++)
	{
		dimspdf[(numdimsx - 2) + i - 1] = dimsmu[i];
	}
	plhs[0]            = mxCreateNumericArray(numdimspdf , dimspdf , mxDOUBLE_CLASS, mxREAL);
	pdf                = mxGetPr(plhs[0]);

	vect               = (double *)malloc(d*sizeof(double));
	vv                 = (double *)malloc(d*sizeof(double));
	temp_sigma         = (double *)malloc(d2*sizeof(double));
	temp_invsigma      = (double *)malloc(d2*sizeof(double));
	det_sigma          = (double *)malloc(M*sizeof(double));
	invsigma           = (double *)malloc((d2*M)*sizeof(double));
	indx               = (int *)malloc(d*sizeof(int));
	res                = (double *)malloc(d*sizeof(double));

    /*---------------------------------------------------------------*/
	/*------------------------ MAIN CALL ----------------------------*/
	/*---------------------------------------------------------------*/
	
	pdf_mvgm(x , mu , sigma , p , d , M , N , K , V , pdf , invsigma , temp_sigma , temp_invsigma , det_sigma , vect , vv , indx , res);

	/*---------------------------------------------------------------*/
	/*------------------------ FREE MEMORY --------------------------*/
	/*---------------------------------------------------------------*/

	free(vect);
	free(vv);
	free(temp_sigma);
	free(temp_invsigma);
	free(det_sigma);
	free(invsigma);
	free(indx);
	free(res);
	free(dimspdf);
 } 
 /* ----------------------------------------------------------------------- */
 void pdf_mvgm(double *x , double *mu , double *sigma  , double *p , int d , int M , int N , int K , int V ,  double *pdf , double *invsigma , double *temp_sigma , double *temp_invsigma , double *det_sigma , double *vect , double *vv , int *indx , double *res)
 {
	 int  i , j , l , r , m , jd , dN = d*N  , k, d2 = d*d , kd , ld , mN , ld2 , i2 , iM ,  mdN , NV = N*V , iNV  , idM , id2M;
	 double cte = 1.0/pow(2*M_PI , d/2) , temp;

	 for (i = 0 ; i < K ; i++) /* Loop on mu, sigma, p */
	 {
		 iM    = i*M;
         idM   = d*iM;
		 id2M  = d*idM;
		 iNV   = i*NV;
		 for (l = 0 ; l < M ; l++)
		 {
			 ld    = l*d;
			 ld2   = ld*d;
			 i2    = ld2  + id2M;
			 /* invsigma */		 
			 for(r = 0 ; r < d2 ; r++)
			 {
				 temp_sigma[r] = sigma[r + i2];
			 }
			 det_sigma[l]  = inv(temp_sigma , temp_invsigma , vect , vv , indx , d);
			 for(r = 0 ; r < d2 ; r++)
			 {
				 invsigma[r + ld2] = temp_invsigma[r];
			 }
			 det_sigma[l] = (cte*sqrt(fabs(det_sigma[l])));
		 }
		 
		 /*  Loop on x	*/	 
		 for (m = 0 ; m < V ; m++) 
		 {
			 mdN = m*dN;
			 mN  = m*N + iNV;			 
			 for (j = 0 ; j < N ; j++)
			 {
				 jd            = j*d + mdN;			 
				 temp          = 0.0;
				 for (k = 0 ; k < M ; k++)
				 {
					 kd  = k*d;
					 for(r = 0 ; r < d ; r++)
					 {
						 res[r] = (x[r + jd] - mu[r + kd]);
					 }
					 temp      += (p[k + iM]*det_sigma[k])*exp(-0.5*gauss(res , invsigma , d , kd*d));
				 }				 
				 pdf[j + mN]    = temp;
			 }			 
		 }
	 }
 }
/*----------------------------------------------------------------------------------------------*/
double gauss(double *y, double *R , int d , int offset)
{
	int  i , j , id;	
	register double temp;
	register double Q = 0.0;

	for (i = 0 ; i < d ; i++)
	{
		temp = 0.0;
		id   = i*d + offset;
		for(j = 0 ; j < d ; j++)
		{
			temp   += y[j]*R[j + id];
		}		
		Q += temp*y[i];
	}
	return Q;
}
/*------------------------------------------------------------------*/
double inv(double *temp , double *invQ  , double *vect , double *vv , int *indx , int d)
{
	int i , j , jd;
	double dd , det = 1.0;

	if(ludcmp(temp , d , indx , &dd , vv ))
	{
		for(i = 0 ; i < d ; i++)			
		{
			det *= temp[i + i*d];	
		}
		for(j = 0; j < d; j++)
		{            
			for(i = 0; i < d; i++) 				
			{
				vect[i] = 0.0;
			}
			jd      = j*d;
			vect[j] = 1.0;
			lubksb(temp , d , indx , vect);
			for(i = 0 ; i < d ; i++) 
			{
				invQ[jd + i] = vect[i];	
			}
		}
	}
	return (1.0/det);
}
/*-------------------------------------------------------------------------------*/
void lubksb(double *m, int n, int *indx, double *b)
{
    int i, ii = -1, ip, j , in;	
    double sum;
    
    for(i = 0 ; i < n; i++)
	{
        ip        = indx[i];
        sum       = b[ip];		
        b[ip]     = b[i];
        if(ii > -1)
		{
            for(j = ii; j <= i - 1; j++)
			{
				sum -= m[i + j*n] * b[j];
			}
        } 
		else if(sum)
		{
			ii = i;
		}
		b[i]     = sum;
    }
    
	for(i = n - 1 ; i >= 0 ; i--)
	{
        sum = b[i];
		in  = i*n;
        for(j = i + 1 ; j < n; j++)
		{
            sum -= m[i + j*n] * b[j];
        }
        
		b[i] = sum / m[i + in];
    }
}

/*-------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------*/
int ludcmp(double *m, int n, int *indx, double *d , double *vv)
{
    int i, imax, j, k , jn , kn , n1 = n - 1;
    double big, dum, sum , temp;
	
    d[0] = 1.0;	
    for(i = 0; i < n; i++)
	{
        big = 0.0;
        for(j = 0; j < n; j++)
		{
            if((temp = fabs(m[i + j*n])) > big)	
			{
                big = temp;
            }	
		}
        if(big == 0.0)
		{		
            return 0;
        }
        vv[i] = 1.0 / big;
    }
    for(j = 0; j < n; j++)
	{
		jn  = j*n;	
        for(i = 0; i < j; i++)
		{
            sum = m[i + jn];
            for(k = 0 ; k < i; k++)
			{
                sum -= m[i + k*n ] * m[k + jn];
            }
			m[i + jn] = sum;
        }
        big = 0.0;		
        for(i = j; i < n; i++)
		{
            sum = m[i + jn];
            for(k = 0; k < j; k++)
			{
				sum -= m[i + k*n] * m[k + jn];
			}
			m[i + jn] = sum;
            if((dum = vv[i] * fabs(sum)) >= big)			
			{
                big  = dum;
                imax = i;
            }
        }
		if(j != imax)
		{
            for(k = 0; k < n; k++)
			{
				kn            = k*n;	
                dum           = m[imax + kn];
                m[imax + kn]  = m[j + kn];
                m[j + kn]     = dum;
            }
			d[0]       = -d[0];
            vv[imax]   = vv[j];
        }
        indx[j] = imax;
        if(m[j + jn] == 0.0)	
		{
			m[j + jn] = NUMERICS_FLOAT_MIN;
		}
		if(j != n1)
		{
            dum = 1.0 / (m[j + jn]);
            for(i = j + 1; i < n; i++)
			{
				m[i + jn] *= dum;
			}
        }
    }
    return 1;
};
/*-------------------------------------------------------------------------*/
