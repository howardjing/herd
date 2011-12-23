function domVal = singlePass(A, k)
    Omega = rand(length(A),k);
    Y = A*Omega;
    [Q garbage] = qr(Y);
    B = (Q'*Y)/(Q'*Omega);
    domVal = svd(B);
end