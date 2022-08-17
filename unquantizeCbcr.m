function [outputMatrix] = unquantizeCbcr(inputMatrix)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Q = [17 18 24 47 99 99 99 99;18 21 26 66 99 99 99 99;24 26 56 99 99 99 99 99;47 66 99 99 99 99 99 99;99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99];
outputMatrix=inputMatrix.*Q;
end

