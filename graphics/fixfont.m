function fixfont(font1,font2,filename)
%FIXFONT Works around MATLAB bug that affects fonts.
%
%   Fonts with more than one word in their name require special care.  For
%   example, instead of 'Helvetica Neue LT Std Thin', the operating system
%   might require something like 'HelveticaNeueLTStd-Th'.

replace(font1,font2,filename,'-nobackup');