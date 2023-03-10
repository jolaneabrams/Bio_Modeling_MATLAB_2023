function [beta,fittedValues] = fitPolynomial(x,y,degree)
% This function will fit the provided data (x,y) with a polynomial. The
% third input "degree" specifies the order of the polynomial. For example,
% if degree is 3, the function will fit a cubic polynomial. The output of
% the function will be the parameters identified by the fit, beginning with
% the constant term, and continuing from lowest to highest degree terms.

x=x(:);  % This will reshape the input x into a column vector
y=y(:);  % This will reshape the input y into a column vector

% Generate the xMat matrix for representing the fitting problem in matrix
% form as:
% y = xMat * beta
xMat = zeros(length(x),degree+1);  % initialize the matrix to the proper size

% complete the lines to fill in the correct values for the columns of xMat
for i=1:(degree+1)
    xMat(:,i)=x.^(i-1);
end
size(y)
% Use the left divide operator (\) to solve for the parameter values
beta = xMat\y;

% Use the fitted parameters to compute the fitted values (or the estimated
% y values for each input x value)
fittedValues = xMat * beta;
