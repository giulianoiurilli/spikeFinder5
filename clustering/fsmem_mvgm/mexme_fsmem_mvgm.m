function mexme_fsmem_mvgm(options)
%
%
% Compile each mex-files of fsmem_mvgm
%
%  Usage
%  ------
%
%  mexme_fsmem_mvgm([options])
%
%  Inputs
%  -------
%
%  options            options strucure
%                     config_file   If user need a particular compiler config file (default config_file = []).
%                     ext           Extention to the compiled files (default ext = [])
%                     generator     'ranSHR3' or 'ranKISS' (default generator = 'ranSHR3')
%
%
%  Example1
%  -------
%
%  mexme_fsmem_mvgm;
%
%
%
%  Example2
%  -------
%
%  options.config_file = 'mexopts_intel10.bat';
%  options.ext         = 'dll';
%  options.generator   = 'ranSHR3';
%  mexme_fsmem_mvgm(options);
%
%
%  Author : Sébastien PARIS : sebastien.paris@lsis.org
%  -------  Date : 01/27/2009


warning off

files1  = {'likelihood_mvgm' , 'loglike_mvgm' , 'pdf_mvgm' , 'ndellipse' };
files2   = {'fsmem_mvgm' , 'sample_mvgm'};

if( (nargin < 1) || isempty(options) )
    options.config_file = [];
    options.ext         = [];
    options.generator   = 'ranSHR3';
end

if(~any(strcmp(fieldnames(options) , 'config_file')))
    options.config_file = [];
end
if(~any(strcmp(fieldnames(options) , 'ext')))
    options.ext = [];
end

if(~any(strcmp(fieldnames(options) , 'generator')))
    options.generator = 'ranSHR3';
end

if(~exist(options.config_file , 'file'))
    options.config_file = [];
end
try
    for i = 1 : length(files1)
        str  = [];
        if(~isempty(options.config_file))
            str = ['-f ' , options.config_file , ' '];
        end
        if(~isempty(options.ext))
            str = [str , '-output ' , files1{i} , '.' , options.ext , ' '];
        end
        str   = [str , files1{i} , '.c'];
        disp(['compiling ' files1{i}])
        eval(['mex ' str])
    end
    
    for i = 1 : length(files2)
        str     = ['-D' , options.generator , ' '];
        if(~isempty(options.config_file))
            str = [str, ' -f ' , options.config_file , ' '];
        end
        if(~isempty(options.ext))
            str = [str , '-output ' , files2{i} , '.' , options.ext , ' '];
        end
        str   = [str , files2{i} , '.c '];
        disp(['compiling ' files2{i}])
        eval(['mex ' str])
    end
    
catch exception
    if(~isempty(exception))
        fprintf(['\n Error during compilation, be sure to:\n'...
            'i)  You have C compiler installed (prefered compiler are MSVC/Intel/GCC)\n'...
            'ii) You did "mex -setup" in matlab prompt before running mexme_fsmem_mvgm\n']);
    end
end

warning on
