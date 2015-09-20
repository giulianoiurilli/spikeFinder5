/* loglike_mvgm.c 


  Compute the loglikelihood of mixture of Multivariate Gaussian pdf.


  Usage: logl = loglike_mvgm(Z , mu , sigma , p); 
  ------

  Inputs
  ------

	Z          Measures    (d x K x [s1] x ....x [sn])   
    mu         Mean parameters (d x 1 x M x [v1] x ... x [vp])
    sigma      Covariance parameters (d x d x M x [v1] x ... x [vp])
    p          Weight parameters  (1 x 1 x M x [v1] x ... x [vp]), sum(p) = 1

   Outputs
   -------

    logl       Loglikelihood ([s1] x ... x [sn] x [v1] x ... x [vp]) matrix.

  
    
		  
 Example 
 --------



 N          = 200;
 V          = 90;
 OV         = ones(1 , V);
  
 mu         = cat(3 , [-5 ; -5] , [0 ; 0] ,[ 5 ; 5]);                %(d x 1 x M)
 sigma      = cat(3 , [2 0; 0 1] , [2 -.2; -.2 2] , [1 .9; .9 1]  ); %(d x d x M)
 p          = cat(3 , [0.3] , [0.1]  , [0.6]);                       %(1 x 1 x M)

 M          = mu(: , : , : , OV) + 0.5*randn(2 , 1 , 3 , V);
 S          = sigma(: , : , : , OV) + 0.01*randn(2 , 2 , 3 , V);
 P          = p(: , : , : , OV);

 Z          = sample_mvgm(N , mu , sigma , p);
 [x , y]    = ndellipse(mu , sigma);
 [X , Y]    = ndellipse(M , S);
 logl       = loglike_mvgm(Z , M , S , P);

 logltrue   = loglike_mvgm(Z , mu , sigma , p);
 figure(1)
 plot(Z(1 , :) , Z(2 , :) , 'k+',reshape(permute(X , [1 3 2]) , 50*V , 3) , reshape(permute(Y , [1 3 2]) , 50*V , 3)  , 'markersize' , 2 , 'linewidth' , 1);
 hold on
 plot( x , y , 'g'  , reshape(mu(1 , : , :) , 1 , 3) , reshape(mu(2 , : , :) , 1 , 3) , 'r+' , 'markersize' , 6 ,  'linewidth' , 2);
 hold off
 figure(2),plot(1:V , logl , 1:V , logltrue(: , ones(1 , V))),grid on


  To compile : 
  -----------

  mex -output loglike_mvgm.dll loglike_mvgm.c

  Myself, I use Intel CPP compiler as : 
  
  mex -f mexopts_intel10.bat -output loglike_mvgm.dll loglike_mvgm.c

  Ver 1.1 (03/26/05)

  Changelog

  1.0 Initial release

  1.1 New Feature : nd slices measurements is now accepted

  Author : Sébastien PARIS © (sebastien.paris@lsis.org) 
  --------
				  
*/


#include <math.h>
#include "mex.h"

#define NUMERICS_FLOAT_MIN 1.0E-37
#define PI 3.14159265358979323846

#ifndef max
    #define max(a,b) (a >= b ? a : b)
    #define min(a,b) (a <= b ? a : b)
#endif

/*--------------------------------------------------------------- */
double gauss(double *, double * , int , int);
void lubksb(double *, int , int *, double *);
int ludcmp(double *, int , int *, double * , double *);
double inv(double * , double * , double * , double * , int * , int );
void loglike_mvgm(double * , double * , double * , double * , int , int , int , int , int , double * , double * , double * , double * , double * , double * , double * , int * , double *);

/*--------------------------------------------------------------- */
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] )
{
	
	double *Z  , *mu , *sigma , *p;
	double *logl ;
	double *vect , *vv , *invsigma  , *temp_sigma , *temp_invsigma , *det_sigma , *res;
	const int  *dimsZ , *dimsmu , *dimssigma , *dimsp;
	int  *dimslogl;
  	int  *indx;
   	int  numdimsZ , numdimsmu , numdimssigma , numdimsp;
	int  numdimslogl;
	int  i , d , N , M = 1 , V = 1 , R = 1, d2 , dim;
	 	 
	 /* Check input */
	 
	 if(nrhs < 4)	 
	 {     
		 mexErrMsgTxt("4 inputs argument are required for loglike_mvgm");	
	 }

	 /* Input 1 */
	 
	 Z            = mxGetPr(prhs[0]);
	 numdimsZ     = mxGetNumberOfDimensions(prhs[0]);
	 dimsZ        = mxGetDimensions(prhs[0]);
	 	 
	 d            = dimsZ[0];
	 N            = dimsZ[1];
	 for (i = 2 ; i < numdimsZ ; i++)
	 {
		 R *= dimsZ[i];	 
	 }
	 
	 d2           = d*d;
	 
	 /* Input 2 */
	 
	 
	 mu           = mxGetPr(prhs[1]); 
	 numdimsmu    = mxGetNumberOfDimensions(prhs[1]);
	 dimsmu       = mxGetDimensions(prhs[1]);
	 if ( (dimsmu[1] != 1))
	 {
		 mexErrMsgTxt("mu must be (d x 1 x M x S1 x ... Sn)");	
	 }
	 if(numdimsmu > 2)	 
	 {
		 M              = dimsmu[2];	 
		 for (i = 3 ; i < numdimsmu ; i++)
		 {
			 V *=dimsmu[i];	 
		 }
	 }
	 
	 /* Input 3 */
	 	 
	 sigma           = mxGetPr(prhs[2]);
	 numdimssigma    = mxGetNumberOfDimensions(prhs[2]);
	 dimssigma       = mxGetDimensions(prhs[2]);	 
	 if ( (numdimssigma > 3) && (dimssigma[0] !=d) && (dimssigma[1] != d) && (dimssigma[2] != M))
	 {
		 mexErrMsgTxt("sigma must be (d x d x M x S1 x ... Sn)");	
	 }

	 /* Input 4 */
	 
	 p               = mxGetPr(prhs[3]);	 
	 numdimsp        = mxGetNumberOfDimensions(prhs[3]);
	 dimsp           = mxGetDimensions(prhs[3]);
	 if ( (numdimsp != numdimsmu) && (dimsp[0] !=1) && (dimsp[1] !=1) && (dimsp[2] != M))
	 {
		 mexErrMsgTxt("p must be (1 x 1 x M x S1 x ... Sn)");	
	 }
	 
	 /* Output 1 */
	 
	 if (numdimsmu > 2) /* mu (d x 1 x L) */		 
	 {
		 dim               = 3;	 
	 }
	 else	 
	 {
		 dim               = 3;	 
	 }
	 
	 numdimslogl       = max((numdimsZ - 2) + (numdimsmu - dim) , 2);
	 dimslogl          = (int *)malloc(numdimslogl*sizeof(int));	 
	 dimslogl[0]       = 1;
	 dimslogl[1]       = 1;
	 
	 for(i = 2 ; i < numdimsZ ; i++)
	 {
		 dimslogl[i - 2] = dimsZ[i];	 
	 }
	 for(i = dim ; i < numdimsmu ; i++)	 
	 {
		 dimslogl[(numdimsZ - 2) + i - dim] = dimsmu[i] ;	 
	 }
	 
	 plhs[0]            = mxCreateNumericArray(numdimslogl, dimslogl, mxDOUBLE_CLASS, mxREAL);
	 logl               = mxGetPr(plhs[0]);

	 /* vecteur temporaire */
	 	 
	 res                = (double *)malloc(d*sizeof(double));
	 vect               = (double *)malloc(d*sizeof(double));
	 vv                 = (double *)malloc(d*sizeof(double));
	 temp_sigma         = (double *)malloc(d2*sizeof(double));
	 temp_invsigma      = (double *)malloc(d2*sizeof(double));
	 det_sigma          = (double *)malloc(M*sizeof(double));
	 invsigma           = (double *)malloc((d2*M)*sizeof(double));
	 indx               = (int *)malloc(d*sizeof(int));
	 
	 /* Main call */
	 
	 loglike_mvgm(Z , mu , sigma , p , d , M , N , V, R , logl , invsigma , temp_sigma , temp_invsigma , det_sigma , vect , vv , indx ,  res);
	 
	 /* Free ressources */
	 
	 free(res);
	 free(vect);	 
	 free(vv);
	 free(temp_sigma);
	 free(temp_invsigma);
	 free(det_sigma);
	 free(invsigma);
	 free(indx);
	 free(dimslogl);	 
 }
 /*----------------------------------------------------------------------------------------------*/
 void loglike_mvgm(double *Z , double *mu , double *sigma , double *p , int d , int M , int N , int V , int R ,  double *logl , double *invsigma , double *temp_sigma , double *temp_invsigma , double *det_sigma , double *vect , double *vv , int *indx , double *res)
 {
	 int i , k , l  , r , t;
	 int d2 = d*d , d2M = M*d2 , dM = M*d , dN = d*N , lR , tdN , i1 , i2 , t1 , t2 , e1 , e2 , kd , kd2;
	 int rd ;
	 double cte = 1.0/pow(2*PI , d/2) ;
	 register double like  , logl_temp ;
	 
	 /* Main Loop */ 
	 	 
	 for(l = 0 ; l < V ; l++)
	 {
		 i1          = l*d2M;
		 t1          = l*dM;
		 e1          = l*M;
		 lR          = l*R;
		 
		 /*1) Compute R_{l,k}^(-1), l=1,...,V, k=1,...,M */ 

		 for (k = 0 ; k < M ; k ++)			 
		 {
			 kd    = k*d;	 
			 kd2   = kd*d;
			 i2    = kd2  + i1;
			 t2    = kd   + t1;
			 e2    = k    + e1;
		
			 /* invsigma */	 
			 for(i = 0 ; i < d2 ; i++)
			 {
				 temp_sigma[i] = sigma[i + i2];	 
			 }
			 det_sigma[k]  = inv(temp_sigma , temp_invsigma , vect , vv , indx , d);
			 for(i = 0 ; i < d2 ; i++)				 
			 {
				 invsigma[i + kd2] = temp_invsigma[i];	 
			 }
			 det_sigma[k] = (cte*sqrt(fabs(det_sigma[k])));
		 }
		 
		 /*2) Compute logl[t,l], t=1,...,R , l=1,...,V */ 
		 
		 for (t = 0 ; t < R ; t++)			 
		 {
			 logl_temp = 0.0;	 
			 tdN       = t*dN;			 
			 for (r = 0 ; r < N ; r++)
			 {				
				 like = 0.0;
				 rd   = r*d + tdN;
				 for (k = 0 ; k < M ; k ++)
				 {
					 kd2 = k*d2;	 
					 t2  = k*d  + t1;
					 e2  = k    + e1;
					 for(i = 0 ; i < d ; i++)
					 {
						 res[i] = (Z[i + rd] - mu[i + t2]);	 
					 }
					 like     += (p[e2]*det_sigma[k])*exp(-0.5*gauss(res , invsigma , d , kd2));
				 }
				 logl_temp  += log(like);
			 }
			 logl[t + lR]    = logl_temp;			
		 }
     }
}
/*------------------------------------------------------------------*/
double gauss(double *y, double *R , int d , int offset)
{	
	int  i , j , id;	
	register double temp , Q = 0.0;				
	id      = offset;
	for (i = 0 ; i < d ; i++)
	{		
		temp        = 0.0;		
		for(j = 0 ; j < d ; j++)			
		{		
			temp   += y[j]*R[j + id];		
		}	
		Q   += temp*y[i];
		id  += d;		
	}	
	return Q;	
}
/*------------------------------------------------------------------*/
double inv(double *temp , double *invQ  , double *vect , double *vv , int *indx , int d)
{
	int i , j , jd , d1 = d+1;	
	double dd , det = 1.0;
	if(ludcmp(temp , d , indx , &dd , vv ))
	{
		jd     = 0;
		for(j = 0 ; j < d ; j++)		
		{			
			det *= temp[jd];
			jd  += d1;		
		}
		jd    = 0;	
		for(j = 0; j < d; j++)
		{            
			for(i = 0; i < d; i++) 				
			{
				vect[i] = 0.0;
			}						
			vect[j] = 1.0;			
			lubksb(temp , d , indx , vect);			
			for(i = 0 ; i < d ; i++) 				
			{	
				invQ[jd + i] = vect[i];				
			}
			jd    += d;
		}		
	}
	return (1.0/det);	
}
/*-------------------------------------------------------------------------------*/
void lubksb(double *m, int n, int *indx, double *b)
{
    int i, ii = -1, ip, j , jn , in;	
    double sum;
    
    for(i = 0 ; i < n; i++)	
	{
        ip        = indx[i];		
        sum       = b[ip];		
        b[ip]     = b[i];
		
        if(ii > -1)
		{
			jn = 0;
            for(j = ii; j <= i - 1; j++)
			{            
				sum -= m[i + jn] * b[j];
				jn  += n;          
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
		jn  = 0;	
        for(j = 0; j < n; j++)
		{
            if((temp = fabs(m[i + jn])) > big)		
			{
                big = temp;
            }
			jn   += n;		
		}
        if(big == 0.0)
		{		
            return 0;
        }	
        vv[i] = 1.0 / big;
    }

	jn   = 0;
    for(j = 0; j < n; j++)
	{	
        for(i = 0; i < j; i++)	
		{
            sum = m[i + jn];
			kn    = 0;			
            for(k = 0 ; k < i; k++)				
			{
                sum -= m[i + kn ] * m[k + jn];
            }          
			m[i + jn] = sum;
			kn       += n;
        }
		
        big = 0.0;		
        for(i = j ; i < n; i++)	
		{
			kn  = 0;
            sum = m[i + jn];			
            for(k = 0; k < j; k++)		
			{            
				sum -= m[i + kn] * m[k + jn];
				kn  += n;         
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
			kn    = 0;
            for(k = 0; k < n; k++)				
			{								
                dum           = m[imax + kn];				
                m[imax + kn]  = m[j + kn];				
                m[j + kn]     = dum;
				kn           += n;				
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
		jn    += n;
    }
    return 1;
};
