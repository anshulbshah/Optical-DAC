 function [rx,tx] = NOLM(rho,gamma,L,E1,EP)
    phi1 = gamma*(abs(E1).^2*0.5*rho + 2*abs(EP).^2*(1-rho))*L;
    phi2 = gamma*(abs(E1).^2*0.5)*L;
    Eback = E1*sqrt(0.5)*sqrt(rho).*exp(phi2*1i)*(sqrt(0.9))*1i;
    Eforw = E1*sqrt(0.5)*sqrt(rho).*exp(phi1*1i)*(sqrt(0.9));
    tx = sqrt(0.5).*Eforw + sqrt(0.5).*Eback*1i;
    rx = sqrt(0.5).*Eforw*1i + sqrt(0.5).*Eback;
    rx = sqrt(0.5)*rx;
end

