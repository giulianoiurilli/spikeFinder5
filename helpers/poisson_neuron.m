function spikeTimes = poisson_neuron(n_spike, totalTime)



%rate of firing
rate = n_spike/(totalTime/1000);

%dt in milliseconds
dt = 1;



%declaration of variables
spikeTimes = [];
spikeTrain = [];

%loop throough whole time
for t = 1 : dt : totalTime,
    %r*dt is the poisson distribution
    %of firing in dt. if the distribution is 
    %greater the uniform sampling,
    %a spike is fired and its time
    %is kept.
    if rate * dt / 1000 >= rand(1),
        spikeTimes(end + 1) = t;
    end
end

