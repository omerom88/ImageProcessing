function passed= ex2presub
display(' ');
display('Started ex2 pre-submission script.');
display(' ');
display('Disclaimer');
display('----------');
display('The purpose of this script is to make sure that your code is compliant');
display('with the exercise API and some of the requirements');
display('The script does not test the quality of your results.');
display('Don''t assume that passing this script will guarantee that you will get');
display('a high grade in the exercise');
display(' ');
display('- Closing all open figures (hope you don''t mind)...');
close all;

display(' ');
filename='monkey.jpg';

grayIm=rgb2gray(im2double(imread(filename)));

display('Section 1.1');
display('-----------');
try
    display('- 1D DFT...');
    DFT(rand(1,20));
    IDFT(exp(2i*pi*rand(1,20)));
catch
    display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
    return;
end
display('- Passed.');


display('Section 1.2');
display('-----------');
try
    display('- 2D DFT...');
    DFT2(grayIm);
    IDFT2(exp(2i*pi*rand(200,200)));
catch
    display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
    return;
end
display('- Passed.');

display('Section 2.1');
display('-----------');
try
    display('- Image derivatives...');
    convDerivative(grayIm);
    input('press any key to continue...');
catch
    display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');


display('Section 2.2');
display('-----------');
try
    display('- Image derivatives in fourier space...');
    fourierDerivative(grayIm);
    input('press any key to continue...');
catch er
    display(er);
    display('- Failed');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');

display('Section 3.1');
display('-----------');
try
    display('- Image blurring...');
    blurInImageSpace(grayIm,7);
    input('press any key to continue...');
catch
    display('- Failed');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');

display('Section 3.2');
display('-----------');
try
    display('- Image blurring in f;ourier space...');
    blurInFourierSpace(grayIm,7);
    input('press any key to continue...');
catch
    display('- Failed');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');

display(' ');
display('- Pre-submission script done.');
display(' ');

display('Please go over the output and verify that there are no failures/warnings.');
display('Remember that this script tested only some basic technical aspects of your implementation');
display('It is your responsibility to make sure your results are actually correct and not only')
display('technically valid.');
passed=1;