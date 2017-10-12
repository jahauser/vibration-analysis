fmin = 0.1;
fmax = 100;
bins = 100;

filemin = 1;
filemax = 2160;
column = 2;

master = zeros(filemin-filemax,bins);

average = zeros(150001,1); 
for i = filemin:filemax
    A = importdata(strcat('reduced',num2str(column),'/test_',num2str(i)),' ');
    t = A(:,1);
    a = A(:,2);
    
    L = length(a);
    Fs = L/(t(end)-t(1));

    Y = fft(a);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = (2*P1(2:end-1)).^2;
    average = average + P1(1:L/2+1);
    interpolation = fit((0:(Fs/L):(Fs/2-Fs/L))',P1(1:L/2),'linearinterp');   
    step = (fmax/fmin)^(1/bins);
    
    for j = 1:bins
        f1 = fmin*(step^(j-1));
        f2 = fmin*(step^j);
        integral = integrate(interpolation,f2,f1);
        master(i,j) = integral/(f2-f1);
    end
    if mod(i,20) == 0
        i, Fs,L
    end
end
plot(t,a)

plot(0:(Fs/L):(Fs/2-Fs/L),average(1:L/2)/(1+filemax-filemin))
axis([0 2500 0 1E-8])